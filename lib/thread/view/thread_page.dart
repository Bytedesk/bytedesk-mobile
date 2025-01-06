import 'dart:io';

import 'package:bytedesk_common/blocs/cubit/theme_cubit.dart';
import 'package:bytedesk_common/blocs/cubit/theme_state.dart';
import 'package:bytedesk_kefu/ui/widget/pop_up_menu.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:im/chat/mqtt/bytedesk_mqtt.dart';
import 'package:im/chat/util/chat_consts.dart';
import 'package:im/common/config/routes.dart';
// import 'package:left_scroll_actions/left_scroll_actions.dart';
import 'package:sp_util/sp_util.dart';

import '../../chat/mqtt/events.dart';
import '../bloc/bloc.dart';
import '../model/thread.dart';
import '../widget/thread_item_widget.dart';
import 'thread_search_provider.dart';

//
class ThreadPage extends StatefulWidget {
  const ThreadPage({super.key});

  @override
  State<ThreadPage> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage>
    with
        AutomaticKeepAliveClientMixin<ThreadPage>,
        // TickerProviderStateMixin,
        WidgetsBindingObserver {
  //
  late int page;
  late int size;
  late List<Thread> _threadList;
  late EasyRefreshController _controller;
  late int selectedIndex;
  late bool _isLoading;
  late String _title;
  late Brightness _brightness;
  //
  final BytedeskPopupMenuController _popupMenuController =
      BytedeskPopupMenuController();
  final List<ItemModel> menuItems = [
    // ItemModel('newGroup', '发起群聊', Icons.chat_bubble),
    // ItemModel('addFriend', '添加朋友', Icons.group_add),
    ItemModel('scan', 'i18n.thread.scan'.tr, Icons.settings_overscan),
  ];
  late String networkConnectivity;
  late List<ConnectivityResult> connectivityResult;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this); // 开始监听生命周期事件
    // 初始化
    page = 0;
    size = 20;
    _isLoading = false;
    _threadList = <Thread>[];
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    selectedIndex = -1;
    _title = 'i18n.thread.title'.tr;
    //
    if (SpUtil.getBool(ChatConsts.isDarkMode)!) {
      _brightness = Brightness.dark;
    } else {
      _brightness = Brightness.light;
    }
    //
    initListeners();
    loadFirstPage();
    BytedeskMqtt().connect();
    getDeviceToken();
    getNetworkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
          // backgroundColor: Colors.grey.shade100,
          // backgroundColor: const Color(0xFFEDEDED),
          actions: [
            BytedeskPopupMenu(
              menuBuilder: _topRightMenu(),
              pressType: PressType.singleClick,
              verticalMargin: -10,
              controller: _popupMenuController,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Icon(Icons.add_circle_outline),
              ),
            )
            // PopupMenuButton<int>(
            //   itemBuilder: (context) => [
            //     // popupmenu item 1
            //     PopupMenuItem(
            //       value: 1,
            //       // row has two child icon and text.
            //       child: Row(
            //         children: [
            //           Icon(Icons.star),
            //           SizedBox(
            //             // sized box with width 10
            //             width: 10,
            //           ),
            //           Text("Get The App")
            //         ],
            //       ),
            //     ),
            //     // popupmenu item 2
            //     PopupMenuItem(
            //       value: 2,
            //       // row has two child icon and text
            //       child: Row(
            //         children: [
            //           Icon(Icons.chrome_reader_mode),
            //           SizedBox(
            //             // sized box with width 10
            //             width: 10,
            //           ),
            //           Text("About")
            //         ],
            //       ),
            //     ),
            //   ],
            //   offset: Offset(0, 0),
            //   color: Colors.grey,
            //   elevation: 2,
            // ),
          ],
        ),
        body: MultiBlocListener(
            listeners: [
              BlocListener<ThreadBloc, ThreadState>(
                listener: (context, state) {
                  debugPrint(
                      "thread page threadBloc: ${state.status} ${state.threadData}");
                  //
                  if (state.status.isSuccess) {
                    _isLoading = false;
                    EasyLoading.dismiss();
                    if (page == 0) {
                      _controller.finishRefresh();
                    } else {
                      _controller.finishLoad();
                    }
                    //
                    if (state.threadData != null &&
                        state.threadData!.threadList != null &&
                        state.threadData!.threadList!.isNotEmpty) {
                      for (Thread thread in state.threadData!.threadList!) {
                        if (!_threadList.contains(thread)) {
                          _threadList.add(thread);
                        }
                      }
                      _threadList.sort((a, b) =>
                          b.updatedAt!.compareTo(a.updatedAt!)); // 按updatedAt排序
                      //
                      setState(() {});
                    }
                  } else if (state.status.isFailure) {
                    EasyLoading.showError("i18n.thread.load.error".tr);
                    _isLoading = false;
                    EasyLoading.dismiss();
                    if (page == 0) {
                      _controller.finishRefresh();
                    } else {
                      _controller.finishLoad();
                    }
                  } else if (state.status.isLoading) {
                    _isLoading = true;
                    // EasyLoading.show();
                  }
                },
              ),
              BlocListener<ThemeCubit, ThemeState>(listener: (context, state) {
                debugPrint("thread page themeCubit: ${state.brightness}");
                setState(() {
                  _brightness = state.brightness!;
                });
              })
            ],
            child: EasyRefresh(
              controller: _controller,
              refreshOnStart: false,
              header: const ClassicHeader(
                dragText: "i18n.refresh.pull".tr,
                armedText: "i18n.refresh.release".tr,
                readyText: "i18n.refresh.refreshing".tr,
                processingText: "i18n.refresh.refreshing".tr,
                processedText: "i18n.refresh.success".tr,
                messageText: "i18n.refresh.last.update".tr,
              ),
              // footer: const ClassicFooter(
              //   dragText: "下拉刷新",
              //   armedText: "松开刷新",
              //   readyText: "正在刷新",
              //   processingText: "正在刷新",
              //   processedText: "刷新成功",
              //   messageText: "最近更新%T",
              // ),
              onLoad: () {
                debugPrint("上拉加载更多onLoad");
                loadMore();
              },
              onRefresh: () {
                debugPrint("下拉刷新onRefresh");
                loadFirstPage();
              },
              child: getSearchListView(),
              // child: _threadList.isEmpty
              //     ? EmptyWidget(
              //         tip: '加载中，请稍后',
              //         tapCallback: () {
              //           loadFirstPage();
              //         },
              //       )
              //     : getSearchListView(),
            )));
  }

  Widget getSearchListView() {
    return Column(
      children: [
        getSearchBar(),
        Visibility(
          visible: networkConnectivity == 'ConnectivityResult.none',
          child: ListTile(
            title: Text('i18n.network.disconnected'.tr),
          ),
        ),
        Expanded(
          child: getListView(),
        ),
      ],
    );
  }

  Widget getSearchBar() {
    return InkResponse(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ThreadSearchProvider(
            brightness: _brightness,
          );
        }));
      },
      child: Hero(
        tag: "search",
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            width: MediaQuery.of(context).size.width,
            height: 46,
            // decoration: _brightness == Brightness.dark
            //     ? BoxDecoration(
            //         border:
            //             Border.all(color: Colors.grey, width: 1), // 设置灰色边框及其宽度
            //         borderRadius: BorderRadius.circular(6), // 设置边框的圆角半径
            //       )
            //     : null,
            color: _brightness == Brightness.dark ? null : Colors.grey.shade100,
            child: Container(
              alignment: Alignment.center,
              decoration: _brightness == Brightness.dark
                  ? null
                  : BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/images/common/search.png",
                      width: 20, height: 20),
                  const SizedBox(width: 6),
                  Text(
                    "搜索",
                    style: TextStyle(
                      color: _brightness == Brightness.dark
                          ? null
                          : const Color(0xFFbfbfbf),
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget getListView() {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              Thread thread = _threadList.elementAt(index);
              return ThreadItemWidget(thread: thread);
              // return CupertinoLeftScroll(
              //     buttonWidth: 60,
              //     bounce: true,
              //     buttons: <Widget>[
              //       // Visibility(
              //       //   visible: ChatConsts.isDebug,
              //       //   child: LeftScrollItem(
              //       //     text: '删除',
              //       //     color: Colors.red,
              //       //     onTap: () {
              //       //       // TODO:
              //       //     },
              //       //   ),
              //       // ),
              //       // Visibility(
              //       //   visible: ChatConsts.isDebug,
              //       //   child: LeftScrollItem(
              //       //     text: '置顶',
              //       //     color: Colors.orange,
              //       //     onTap: () {
              //       //       // TODO:
              //       //     },
              //       //   ),
              //       // ),
              //       // Visibility(
              //       //   visible: ChatConsts.isDebug,
              //       //   child: LeftScrollItem(
              //       //     text: '标记未读',
              //       //     color: Colors.green,
              //       //     onTap: () {
              //       //       // TODO:
              //       //     },
              //       //   ),
              //       // ),
              //       // Visibility(
              //       //   visible: ChatConsts.isDebug,
              //       //   child: LeftScrollItem(
              //       //     text: '免打扰',
              //       //     color: Colors.grey,
              //       //     onTap: () {
              //       //       // TODO:
              //       //     },
              //       //   ),
              //       // )
              //     ],
              //     // onTap: () {
              //     //   debugPrint('tap row');
              //     // },
              //     child: ThreadItemWidget(thread: thread)
              //   );
            },
            childCount: _threadList.length,
          ),
        ),
      ],
    );
  }

  void initListeners() {
    //
    bytedeskEventBus.on<ConnectionEventBus>().listen((event) {
      debugPrint("ConnectionEventBus ${event.status}");
      if (event.status == ChatConsts.USER_STATUS_CONNECTING) {
        setState(() {
          _title = 'Connecting'.tr;
        });
      } else if (event.status == ChatConsts.USER_STATUS_CONNECTED) {
        // 重连成功后，重新加载数据
        setState(() {
          _title = 'Home'.tr;
        });
        loadFirstPage();
      } else if (event.status == ChatConsts.USER_STATUS_DISCONNECTED) {
        // 不显示连接断开
        // setState(() {
        //   _title = 'Disconnected'.tr;
        // });
        // 断线重连
        // BytedeskMqtt().connect();
        // TODO: 拉取离线消息
      }
    });
    //
    bytedeskEventBus.on<ReceiveThreadEventBus>().listen((event) {
      debugPrint("ReceiveThreadEventBus ${event.thread.toJson()}");
      String? currentThreadTopic =
          SpUtil.getString(ChatConsts.currentThreadTopic);
      bool contains = false;
      for (var i = 0; i < _threadList.length; i++) {
        Thread thread = _threadList[i];
        if (thread.uid == event.thread.uid) {
          contains = true;
          thread.content = event.thread.content;
          //
          if (currentThreadTopic != event.thread.topic) {
            thread.unreadCount = thread.unreadCount! + 1;
          }
          _threadList[i] = thread;
          // 更新列表
          setState(() {});
          return;
        }
      }
      if (!contains) {
        _threadList.insert(0, event.thread);
        // 更新列表
        setState(() {});
      }
    });
    //
    bytedeskEventBus
        .on<ReceiveThreadClearUnreadCountEventBus>()
        .listen((event) {
      debugPrint(
          "ReceiveThreadClearUnreadCountEventBus ${event.thread.toJson()}");
      //
      for (var i = 0; i < _threadList.length; i++) {
        Thread thread = _threadList[i];
        if (thread.uid == event.thread.uid) {
          thread.unreadCount = 0;
          _threadList[i] = thread;
          // 更新列表
          setState(() {});
          return;
        }
      }
    });
  }

  // 监听生命周期事件
  // 当应用程序从后台切换到前台时，会触发这个回调
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("thread didChangeAppLifecycleState: $state");
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        BytedeskMqtt().disconnect();
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        BytedeskMqtt().disconnect();
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
        // APP切换到前台之后，重连
        // BytedeskUtils.mqttReConnect();
        loadFirstPage();
        BytedeskMqtt().connect();
        // BytedeskAgentHttpApi().queryAgent();
        // TODO: 拉取离线消息
        break;
      case AppLifecycleState.detached: // 申请将暂时暂停
        BytedeskMqtt().disconnect();
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  void loadFirstPage() {
    // EasyLoading.show();
    if (_isLoading) {
      print('is loading');
      return;
    }
    _isLoading = true;
    page = 0;
    // debugPrint("Loading first page $page, type ${widget.category!.slug}");
    BlocProvider.of<ThreadBloc>(context).add(GetThreadEvent(
      page: page,
      size: size,
    ));
  }

  void loadMore() {
    // EasyLoading.show();
    if (_isLoading) {
      print('is loading');
      return;
    }
    _isLoading = true;
    page += 1;
    // debugPrint("Loading more $page, type ${widget.category!.slug}");
    BlocProvider.of<ThreadBloc>(context).add(GetThreadEvent(
      page: page,
      size: size,
    ));
  }

  // 聊天页面右上角plus按钮，显示下拉菜单
  Widget _topRightMenu() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: const Color(0xFF4C4C4C),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: menuItems
                .map(
                  (item) => GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      debugPrint("onTap ${item.name}");
                      _popupMenuController.hideMenu();
                      //
                      if (item.name == "scan") {
                        Get.toNamed(Routes.qrScan);
                      }
                      // setState(() {
                      //   _promot = "";
                      //   _messages = [];
                      // });
                      // if (item.name == "newthread") {
                      //   requestThread("1");
                      // } else if (item.name == "clearmsg") {
                      //   // 迁移到最上方，开启新会话同样需要清空聊天记录
                      // }
                    },
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            item.icon,
                            size: 15,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                item.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  void getDeviceToken() async {
    if (!Platform.isIOS) {
      debugPrint("getDeviceToken is only available in iOS.");
      return;
    }
    // TODO: 检测是否已经获取过device token，如果获取过，则直接返回，否则获取token
    // TODO: 如果已经拒绝，则提示跳转到设置页面打开推送
    // FIXME: Unhandled Exception: PlatformException(UNAVAILABLE, Device token not available, null, null)
    // 注册推送通知
  }

  void getNetworkConnectivity() async {
    networkConnectivity = '';
    connectivityResult = await (Connectivity().checkConnectivity());
    debugPrint("network status: $connectivityResult");
    // This condition is for demo purposes only to explain every connection type.
    // Use conditions which work for your requirements.
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      // Mobile network available.
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      // Wi-fi is available.
      // Note for Android:
      // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      // Ethernet connection available.
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      // Vpn connection active.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      // Bluetooth connection available.
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      // Connected to a network which is not in the above mentioned networks.
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      // No available network types
    }
    setState(() {
      networkConnectivity = connectivityResult.toString();
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // 停止监听
    // Do not forget to dispose the listener
    super.dispose();
  }
}
