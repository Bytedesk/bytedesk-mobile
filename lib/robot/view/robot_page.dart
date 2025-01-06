import 'package:bytedesk_kefu/ui/widget/empty_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:im/robot/view/robot_detail_provider.dart';
import 'package:get/get.dart';

import '../bloc/bloc.dart';
import '../model/robot.dart';

//
class RobotPage extends StatefulWidget {
  const RobotPage({super.key});

  @override
  State<RobotPage> createState() => _RobotPageState();
}

class _RobotPageState extends State<RobotPage>
    with
        AutomaticKeepAliveClientMixin<RobotPage>,
        // TickerProviderStateMixin,
        WidgetsBindingObserver {
  //
  late int page;
  late int size;
  late List<Robot> _robotList;
  late EasyRefreshController _controller;
  late int selectedIndex;
  late bool _isLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 初始化
    page = 0;
    size = 20;
    _isLoading = false;
    _robotList = <Robot>[];
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    selectedIndex = -1;
    //
    loadFirstPage();
    // isMediumAndUp.addListener(() {
    //   debugPrint('isMediumAndUp');
    // });
    // 显示loading
    // EasyLoading.show();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('i18n.robot.title'.tr),
        // backgroundColor: const Color(0xFFEDEDED),
      ),
      body: BlocBuilder<RobotBloc, RobotState>(builder: (context, state) {
        _isLoading = false;
        EasyLoading.dismiss();
        if (page == 0) {
          _controller.finishRefresh();
        } else {
          _controller.finishLoad();
        }
        //
        if (state.status.isSuccess) {
          //
          if (state.robotData!.robotList!.isNotEmpty) {
            // _robotList = state.robotData!.robotList!;
            for (Robot robot in state.robotData!.robotList!) {
              if (!_robotList.contains(robot)) {
                _robotList.add(robot);
              }
            }
          }
        } else if (state.status.isFailure) {
          EasyLoading.showError("i18n.robot.load.error".tr);
        }
        //
        return EasyRefresh(
          controller: _controller,
          refreshOnStart: true,
          header: ClassicHeader(
            dragText: "i18n.refresh.pull".tr,
            armedText: "i18n.refresh.release".tr,
            readyText: "i18n.refresh.refreshing".tr,
            processingText: "i18n.refresh.refreshing".tr,
            processedText: "i18n.refresh.success".tr,
            messageText: "i18n.refresh.last.update".tr,
          ),
          footer: ClassicFooter(
            dragText: "i18n.load.pull".tr,
            armedText: "i18n.load.release".tr,
            readyText: "i18n.load.loading".tr,
            processingText: "i18n.load.loading".tr,
            processedText: "i18n.load.success".tr,
            messageText: "i18n.load.last.update".tr,
          ),
          onLoad: () {
            debugPrint("上拉加载更多onLoad");
            loadMore();
          },
          onRefresh: () {
            debugPrint("下拉刷新onRefresh");
            loadFirstPage();
          },
          child: _robotList.isEmpty
              ? EmptyWidget(
                  tip: 'i18n.robot.loading'.tr,
                  tapCallback: () {
                    loadFirstPage();
                  },
                )
              : getListView(),
        );
      }),
    );
  }

  Widget getListView() {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              Robot robot = _robotList.elementAt(index);
              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: robot.avatar!,
                  width: 45,
                  height: 45,
                ),
                title: Text(
                  robot.nickname!.tr,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(robot.description!.tr),
                selected: selectedIndex == index,
                // tileColor: Colors.red,
                // isThreeLine: true,
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  //
                  chooseRobot(robot);
                  // if (!Breakpoints.mediumAndUp.isActive(context)) {
                  //   // 手机版
                  //   // Navigator.of(context).push(MaterialPageRoute(
                  //   //     fullscreenDialog: true,
                  //   //     builder: (context) {
                  //   //       return QaProvider(
                  //   //         tiku: tiku,
                  //   //       );
                  //   //     }));
                  // } else {
                  //   chooseRobot(tiku);
                  // }
                },
              );
            },
            childCount: _robotList.length,
          ),
        ),
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("robot didChangeAppLifecycleState: $state");
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
        // APP切换到前台之后，重连
        // BytedeskUtils.mqttReConnect();
        // TODO: 拉取离线消息
        break;
      case AppLifecycleState.detached: // 申请将暂时暂停
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
    debugPrint("Loading first page $page");
    BlocProvider.of<RobotBloc>(context)
        .add(GetRobotEvent(page: page, size: size));
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
    BlocProvider.of<RobotBloc>(context)
        .add(GetRobotEvent(page: page, size: size));
  }

  @override
  bool get wantKeepAlive => true;
  //
  void chooseRobot(Robot robot) {
    debugPrint("choose robot ${robot.nickname}");
    // bytedeskEventBus.fire(ChooseTikuEvent(tiku));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RobotDetailProvider(robot: robot);
    }));
  }
}
