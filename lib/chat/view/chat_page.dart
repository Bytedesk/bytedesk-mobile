/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-13 07:41:51
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-10-13 20:30:04
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'dart:async';
import 'dart:convert';
// import 'dart:typed_data';

import 'package:bytedesk_common/blocs/cubit/theme_cubit.dart';
import 'package:bytedesk_common/blocs/cubit/theme_state.dart';
import 'package:bytedesk_kefu/ui/widget/expanded_viewport.dart';
import 'package:bytedesk_kefu/ui/widget/send_button_visibility_mode.dart';
import 'package:bytedesk_kefu/util/bytedesk_utils.dart';
import 'package:bytedesk_kefu/util/bytedesk_uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:im/chat/model/message_data.dart';
import 'package:im/chat/util/chat_consts.dart';
import 'package:im/chat/view/chat_profile_page.dart';
import 'package:im/thread/model/thread.dart';
import 'package:get/get.dart';
import 'package:im/chat/model/user_protobuf.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sp_util/sp_util.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
// import 'package:sp_util/sp_util.dart';
import 'package:bytedesk_kefu/ui/widget/voice_record/voice_widget.dart';

import '../message_bloc/bloc.dart';
import '../model/message.dart';
import '../model/message_provider.dart';
import '../mqtt/bytedesk_mqtt.dart';
import '../mqtt/events.dart';
import '../other_bloc/bloc.dart';
import '../widget/extra_item.dart';
import '../widget/message_widget.dart';
import '../widget/chat_input.dart';

class ChatPage extends StatefulWidget {
  final Thread? thread;
  const ChatPage({super.key, this.thread});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with
        AutomaticKeepAliveClientMixin<ChatPage>,
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  // 下拉刷新
  final RefreshController _refreshController = RefreshController();
  // 输入文字
  final TextEditingController _textController = TextEditingController();
  // 滚动监听
  final ScrollController _scrollController = ScrollController();
  // 聊天记录本地存储
  final MessageProvider _messageProvider = MessageProvider();
  // 聊天记录内存存储
  final List<MessageWidget> _messages = <MessageWidget>[];
  // 长连接
  final BytedeskMqtt _bdMqtt = BytedeskMqtt();
  // 当前用户uid
  final String? _currentUid = SpUtil.getString(ChatConsts.uid);
  // final String? _currentUsername = SpUtil.getString(ChatConsts.username);
  final String? _currentNickname = SpUtil.getString(ChatConsts.nickname);
  final String? _currentAvatar = SpUtil.getString(ChatConsts.avatar);
  // 分页加载聊天记录
  int _localPage = 0;
  int _httpPage = 0;
  final int size = 20;
  late bool _isLoading;
  String? orgUid;
  String? _title;
  //
  @override
  void initState() {
    // TODO: implement initState
    initListeners();
    super.initState();
    WidgetsBinding.instance.addObserver(this); // 开始监听生命周期事件
    //
    orgUid = SpUtil.getString(ChatConsts.orgUid);
    _title = widget.thread!.user!.nickname!.tr;
    // 加载本地历史消息
    _getMessages(_localPage, size);
    // _bdMqtt.connect();
    SpUtil.putString(ChatConsts.currentThreadTopic, widget.thread!.topic!);
  }

  //
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_title!),
        elevation: 0.3,
        excludeHeaderSemantics: true,
        centerTitle: true,
        actions: [
          Visibility(
              visible: ChatConsts.isDebug,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const ChatProfilePage();
                    }));
                  },
                  child: const Text('...')))
        ],
      ),
      body: MultiBlocListener(
          listeners: [
            BlocListener<MessageBloc, MessageState>(listener: (context, state) {
              debugPrint('MessageBloc: $state');
              _isLoading = false;
              EasyLoading.dismiss();
              _refreshController.loadComplete();
              //
              if (state.status.isSuccess) {
                // 加载成功
                MessageData? messageData = state.messageData;
                for (var i = messageData!.messageList!.length - 1;
                    i >= 0;
                    i--) {
                  Message message = messageData.messageList![i];
                  // 本地持久化
                  _messageProvider.insert(message, _currentUid!);
                  // 界面显示
                  pushToMessageArray(message, false);
                }
              } else if (state.status.isFailure) {
                EasyLoading.showError("加载错误");
              }
            }),
            BlocListener<OtherBloc, OtherState>(listener: (context, state) {
              debugPrint('OtherBloc: $state');
              if (state is UploadingProgress) {
                EasyLoading.show(status: '上传中...');
              } else if (state is UploadSuccess) {
                EasyLoading.dismiss();
                // 上传成功
                AssetEntity asset = state.upload.entity!;
                String content = state.upload.data!;
                debugPrint('上传成功: $content');
                // 根据类型发送图片、视频消息、文件消息
                if (asset.type == AssetType.image) {
                  sendMessage(ChatConsts.MESSAGE_TYPE_IMAGE, content);
                } else if (asset.type == AssetType.video) {
                  sendMessage(ChatConsts.MESSAGE_TYPE_VIDEO, content);
                } else if (asset.type == AssetType.audio) {
                  sendMessage(ChatConsts.MESSAGE_TYPE_AUDIO, content);
                } else {
                  sendMessage(ChatConsts.MESSAGE_TYPE_FILE, content);
                }
              } else if (state is OtherFailure) {
                EasyLoading.showError(state.error.toString());
              }
              //
            }),
            BlocListener<ThemeCubit, ThemeState>(listener: (context, state) {
              debugPrint("thread page themeCubit: ${state.brightness}");
              if (state.brightness == Brightness.dark) {
                // BytedeskTheme().setDark();
              } else if (state.brightness == Brightness.light) {
                // BytedeskTheme().setLight();
              }
            })
          ],
          child: Container(
            alignment: Alignment.bottomCenter,
            // color: const Color(0xffdeeeeee),
            color: BytedeskUtils.isDarkMode(context)
                ? Colors.transparent
                : const Color(0xffdeeeeee),
            child: Column(
              children: <Widget>[
                // 参考pull_to_refresh库中 QQChatList例子
                Expanded(
                  child: SmartRefresher(
                    enablePullDown: false,
                    onLoading: () async {
                      // debugPrint('TODO: 下拉刷新'); // 注意：方向跟默认是反着的
                      loadMore();
                    },
                    footer: const ClassicFooter(
                      idleText: "上拉加载",
                      loadingText: "加载中...",
                      noDataText: "没有更多了",
                      failedText: "加载失败",
                      canLoadingText: "加载中...",
                      loadStyle: LoadStyle.ShowWhenLoading,
                    ),
                    enablePullUp: false,
                    controller: _refreshController,
                    //
                    child: Scrollable(
                      controller: _scrollController,
                      axisDirection: AxisDirection.up,
                      viewportBuilder: (context, offset) {
                        return ExpandedViewport(
                          offset: offset,
                          axisDirection: AxisDirection.up,
                          slivers: <Widget>[
                            SliverExpanded(),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (c, i) => _messages[i],
                                  childCount: _messages.length),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
                // const Divider(
                //   height: 1.0,
                // ),
                Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    // child: _textComposerWidget(),
                    // FIXME: 表情在web和Android有问题？暂时仅在iOS启用表情
                    // child: (BytedeskUtils.isWeb || BytedeskUtils.isAndroid) ? _textComposerWidget() : _chatInput(),
                    child: _chatInput()),
              ],
            ),
          )),
    );
  }

  Widget _chatInput() {
    return ChatInput(
      // 发送触发事件
      // isRobot: false,
      onSendPressed: _handleSendPressed,
      onTextChanged: _handleTextChanged,
      onTextFieldTap: _handleTextFieldTap,
      sendButtonVisibilityMode: SendButtonVisibilityMode.editing,
      // voiceWidget: VoiceRecord(),
      // voiceWidget: VoiceWidget(
      //   startRecord: () {},
      //   stopRecord: _handleVoiceSelection,
      //   // 加入定制化Container的相关属性
      //   height: 40.0,
      //   margin: EdgeInsets.zero,
      // ),
      extraWidget: ExtraItems(
        // 相册
        handleImageSelection: _handleAlbumSelection,
        // 拍摄
        handlePickerSelection: _handleCameraSelection,
      ),
    );
  }

  Future<bool> _handleSendPressed(String content) async {
    debugPrint('send: $content');
    _handleSubmitted(content);
    return true;
  }

  void _handleTextChanged(String text) {
    debugPrint('text changed: $text');
  }

  void _handleTextFieldTap() {
    debugPrint('text field tap');
  }

  void _handleVoiceSelection(AudioFile? obj) async {
    debugPrint('_handleVoiceSelection');
    if (obj != null) {}
  }

  // https://github.com/fluttercandies/flutter_wechat_assets_picker/blob/main/README-ZH.md
  void _handleAlbumSelection() async {
    debugPrint('_handleAlbumSelection');
    // _pickImage();
    final List<AssetEntity>? assets = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        maxAssets: 1,
        specialPickerType: SpecialPickerType.noPreview,
        // pickerTheme: AssetPicker.themeData(
        //   Colors.lightBlueAccent,
        //   light: true,
        // ),
      ),
    );
    if (assets != null) {
      debugPrint('_handleAlbumSelection assets: $assets');
      for (var i = 0; i < assets.length; i++) {
        AssetEntity asset = assets[i];
        debugPrint(
            'asset: ${asset.toString()} type ${asset.type} ${asset.relativePath}, ${asset.mimeType}');
        //
        BlocProvider.of<OtherBloc>(context)
            .add(UploadAssetEntityEvent(entity: asset));
      }
      //
      // TODO: 将图片显示到对话消息中
      // TODO: 显示处理中loading
      // 压缩
    }
  }

  Future<void> _handleCameraSelection() async {
    debugPrint('_handleCameraSelection');
    // _takeImage();
    // return;
    final AssetEntity? asset = await CameraPicker.pickFromCamera(
      context,
      pickerConfig: const CameraPickerConfig(
        enableRecording: true,
        // theme: CameraPicker.themeData(Colors.blue),
      ),
    );
    if (asset != null) {
      debugPrint(
          '_handleCameraSelection: ${asset.toString()} type ${asset.type} ${asset.relativePath}, ${asset.mimeType}');
      BlocProvider.of<OtherBloc>(context)
          .add(UploadAssetEntityEvent(entity: asset));
      //
      // TODO: 将图片显示到对话消息中
      // TODO: 显示处理中loading
    }
  }

  // 发送消息
  void _handleSubmitted(String? text) {
    _textController.clear();
    // 内容为空，直接返回
    if (text!.trim().isEmpty) {
      return;
    }
    sendMessage(ChatConsts.MESSAGE_TYPE_TEXT, text);
  }

  void sendMessage(String type, String content) {
    //
    var messageExtra = {
      orgUid: orgUid!,
    };
    String uid = BytedeskUuid.uuid();
    Message message = Message(
        uid: uid,
        type: type,
        content: content,
        status: ChatConsts.MESSAGE_STATUS_SENDING,
        createdAt: BytedeskUtils.formattedDateNow(),
        client: BytedeskUtils.getClient(),
        extra: jsonEncode(messageExtra),
        //
        threadTopic: widget.thread?.topic,
        user: UserProtobuf(
          uid: _currentUid,
          nickname: _currentNickname,
          avatar: _currentAvatar,
        ));
    pushToMessageArray(message, true);
    //
    if (type == ChatConsts.MESSAGE_TYPE_TEXT) {
      _bdMqtt.sendTextMessage(uid, content, widget.thread!);
    } else if (type == ChatConsts.MESSAGE_TYPE_IMAGE) {
      _bdMqtt.sendImageMessage(uid, content, widget.thread!);
    } else if (type == ChatConsts.MESSAGE_TYPE_VIDEO) {
      _bdMqtt.sendVideoMessage(uid, content, widget.thread!);
    } else if (type == ChatConsts.MESSAGE_TYPE_AUDIO) {
      _bdMqtt.sendAudioMessage(uid, content, widget.thread!);
    } else if (type == ChatConsts.MESSAGE_TYPE_FILE) {
      _bdMqtt.sendFileMessage(uid, content, widget.thread!);
    } else if (type == ChatConsts.MESSAGE_TYPE_LOCATION) {
      // _bdMqtt.sendLocationMessage(uid, content, widget.thread);
    }
  }

  //
  initListeners() {
    debugPrint('initListeners');
    // token过期，要求重新登录
    bytedeskEventBus.on<InvalidTokenEventBus>().listen((event) {
      debugPrint("chat_kf_page.dart InvalidTokenEventBus token过期，请重新登录");
      // 也即执行init初始接口 BytedeskFlutter.init(appKey, subDomain);
      // BytedeskFlutter.anonymousLogin2();
    });
    // 更新消息状态
    bytedeskEventBus.on<ReceiveMessageReceiptEventBus>().listen((event) {
      debugPrint('更新状态:${event.uid}-${event.status}');
      if (mounted) {
        // 更新界面
        for (var i = 0; i < _messages.length; i++) {
          MessageWidget messageWidget = _messages[i];
          if (messageWidget.message!.uid == event.uid &&
              messageWidget.message!.status != ChatConsts.MESSAGE_STATUS_READ) {
            // debugPrint('do update status:' + messageWidget.message!.uid!);
            if (event.status == ChatConsts.MESSAGE_STATUS_SUCCESS) {
              if (messageWidget.message!.status !=
                  ChatConsts.MESSAGE_STATUS_SENDING) {
                return;
              }
            }
            // 必须重新创建一个messageWidget才会更新
            Message message =
                Message.fromMessage(messageWidget.message!, event.status);
            MessageWidget messageWidget2 = MessageWidget(
                message: message,
                // customCallback: widget.customCallback,
                animationController: AnimationController(
                    vsync: this, duration: const Duration(milliseconds: 500)));
            setState(() {
              _messages[i] = messageWidget2;
            });
          }
        }
      }
    });
    bytedeskEventBus.on<ReceiveMessageTypingEventBus>().listen((event) {
      debugPrint('ReceiveMessageTypingEventBus');
      if (event.message.threadTopic != widget.thread!.topic ||
          event.message.isSend()) {
        return;
      }
      if (mounted) {
        setState(() {
          // TODO: 国际化，支持英文
          _title = '对方正在输入';
        });
      }
      // 还原title
      Timer(
        const Duration(seconds: 3),
        () {
          // debugPrint('timer');
          if (mounted) {
            setState(() {
              _title = widget.thread!.user!.nickname!.tr;
            });
          }
        },
      );
    });
    bytedeskEventBus.on<ReceiveMessagePreviewEventBus>().listen((event) {
      debugPrint('ReceiveMessagePreviewEventBus');
      if (event.message.threadTopic != widget.thread!.topic ||
          event.message.isSend()) {
        return;
      }
      if (mounted) {
        setState(() {
          // TODO: 国际化，支持英文
          _title = '对方正在输入';
        });
      }
      // 还原title
      Timer(
        const Duration(seconds: 3),
        () {
          // debugPrint('timer');
          if (mounted) {
            setState(() {
              _title = widget.thread!.user!.nickname!.tr;
            });
          }
        },
      );
    });
    // 接收到新消息
    bytedeskEventBus.on<ReceiveMessageEventBus>().listen((event) {
      // debugPrint('receive message: ${event.message.toJson().toString()}');
      if (event.message.threadTopic != widget.thread!.topic) {
        return;
      }
      debugPrint('receive message: ${event.message.toJson().toString()}');
      // 非自己发送的，发送已读回执
      if (!event.message.isSend()) {
        _bdMqtt.sendReceiptReadMessage(event.message.uid!, widget.thread!);
      } else {
        _bdMqtt.updateMessageSuccess(event.message.uid!);
      }
      pushToMessageArray(event.message, true);
    });
    // 删除消息
    bytedeskEventBus.on<DeleteMessageEventBus>().listen((event) {
      //
      if (mounted) {
        // 从sqlite中删除
        _messageProvider.delete(event.uid);
        // 更新界面
        setState(() {
          _messages.removeWhere((element) => element.message!.uid == event.uid);
        });
      }
    });
    // 滚动监听, https://learnku.com/articles/30338
    _scrollController.addListener(() {
      // 隐藏软键盘
      FocusScope.of(context).requestFocus(FocusNode());
      // 如果滑动到底部
      // if (_scrollController.position.pixels ==
      //     _scrollController.position.maxScrollExtent) {
      //   debugPrint('已经到底了');
      // }
    });
  }

  void loadFirstPage() {
    // EasyLoading.show();
    if (_isLoading) {
      print('is loading');
      return;
    }
    _isLoading = true;
    _httpPage = 0;
    // debugPrint("Loading first page $page, type ${widget.category!.slug}");
    BlocProvider.of<MessageBloc>(context).add(GetMessageEvent(
      page: _httpPage,
      size: size,
      topic: widget.thread!.topic,
    ));
  }

  void loadMore() {
    // EasyLoading.show();
    if (_isLoading) {
      print('is loading');
      return;
    }
    _isLoading = true;
    _httpPage += 1;
    // debugPrint("Loading more $page, type ${widget.category!.slug}");
    BlocProvider.of<MessageBloc>(context).add(GetMessageEvent(
      page: _httpPage,
      size: size,
      topic: widget.thread!.topic,
    ));
  }

  // 分页加载本地历史聊天记录
  // TODO: 从服务器加载聊天记录
  // FIXME: 消息排序错乱
  Future<void> _getMessages(int page, int size) async {
    //
    List<Message> messageList = await _messageProvider.getTopicMessages(
        widget.thread!.topic, _currentUid, page, size);
    // BytedeskUtils.printLog(messageList.length);
    int length = messageList.length;
    for (var i = 0; i < length; i++) {
      Message message = messageList[i];
      pushToMessageArray(message, false);
    }
    //
    _localPage += 1;
  }

  void pushToMessageArray(Message message, bool append) {
    if (mounted) {
      bool contains = false;
      for (var i = 0; i < _messages.length; i++) {
        Message? element = _messages[i].message;
        if (element!.uid == message.uid) {
          contains = true;
          // 更新消息状态
          _messageProvider.update(element.uid, message.status);
        }
      }
      if (!contains) {
        MessageWidget messageWidget = MessageWidget(
            message: message,
            // customCallback: widget.customCallback,
            animationController: AnimationController(
                vsync: this, duration: const Duration(milliseconds: 500)));
        setState(() {
          if (append) {
            _messages.insert(0, messageWidget);
          } else {
            _messages.add(messageWidget);
            _messages.sort((a, b) {
              return b.message!.createdAt!.compareTo(a.message!.createdAt!);
            });
          }
        });
      }
    }
    if (message.status != ChatConsts.MESSAGE_STATUS_READ) {
      // 发送已读回执
      if (!message.isSend()) {
        // debugPrint('message.uid ${message.uid}');
        // debugPrint('widget.thread ${widget.thread!.tid}');
        _bdMqtt.sendReceiptReadMessage(message.uid!, widget.thread!);
      }
    }
  }

  void scrollToBottom() {
    // After 1 second, it takes you to the bottom of the ListView
    // Timer(
    //   const Duration(seconds: 1),
    //   () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent),
    // );
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("didChangeAppLifecycleState: $state");
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

  @override
  void dispose() {
    // debugPrint('chat_kf_page dispose');
    // SpUtil.putBool(ChatConsts.isCurrentChatKfPage, false);
    WidgetsBinding.instance.removeObserver(this);
    SpUtil.putString(ChatConsts.currentThreadTopic, "");
    // _debounce?.cancel();
    // _loadHistoryTimer?.cancel();
    // _resendTimer?.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
