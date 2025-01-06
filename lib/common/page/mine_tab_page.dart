import 'package:bytedesk_common/blocs/profile_bloc/bloc.dart';
// import 'package:bytedesk_kefu/util/bytedesk_events.dart';
import 'package:bytedesk_common/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sp_util/sp_util.dart';
import '../../../../../../common/config/routes.dart';
import '../../chat/util/chat_consts.dart';
import '../../chat/util/chat_utils.dart';
import '../../chat/view/chat_webview_page.dart';

class MineTabPage extends StatefulWidget {
  const MineTabPage({super.key});

  @override
  State<MineTabPage> createState() => _MineTabPageState();
}

class _MineTabPageState extends State<MineTabPage>
    with AutomaticKeepAliveClientMixin<MineTabPage>, WidgetsBindingObserver {
  //
  var nickname = '';
  var avatar = '';
  var description = '';

  //
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initListeners();
    initAuth();
  }

  void initAuth() async {
    bool? isLogin = SpUtil.getBool(ChatConsts.isLogin);
    if (isLogin!) {
      nickname = SpUtil.getString(ChatConsts.nickname)!;
      avatar = SpUtil.getString(ChatConsts.avatar)!;
      description = SpUtil.getString(ChatConsts.description)!;
      if (nickname.isEmpty) {
        // WeiyuUtils.getProfile(context);
      }
    } else {
      // 显示空白对话页面
      debugPrint("i18n.auth.not.authenticated".tr);
    }
    // token过期，要求重新登录
    // bytedeskEventBus.on<InvalidTokenEventBus>().listen((event) {
    //   debugPrint("InvalidTokenEventBus token过期，请重新登录");
    //   // 也即执行init初始接口 BytedeskFlutter.init(appKey, subDomain);
    //   // BytedeskFlutter.logout();
    //   ChatUtils.showAuth(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Mine".tr),
        // backgroundColor: const Color(0xFFEDEDED),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.setting);
              },
              icon: const Icon(Icons.settings_outlined))
        ],
      ),
      body: MultiBlocListener(
          listeners: [
            // BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            //   debugPrint('login state $state');
            //   if ((state is SMSAuthSuccess)) {
            //     WeiyuUtils.getProfile(context);
            //   }
            // }),
            BlocListener<ProfileBloc, ProfileState>(listener: (context, state) {
              debugPrint("i18n.profile.state"
                  .tr
                  .trParams({'state': state.toString()}));
              if (state is ProfileSuccess) {
                setState(() {
                  nickname = state.user!.nickname!;
                  avatar = state.user!.avatar!;
                  description = state.user!.description!;
                });
              } else if (state is UpdateAvatarSuccess) {
                debugPrint('i18n.profile.avatar.success'.tr);
                setState(() {
                  avatar = state.user.avatar!;
                });
              } else if (state is UpdateNicknameSuccess) {
                debugPrint('i18n.profile.nickname.success'.tr);
                setState(() {
                  nickname = state.user.nickname!;
                });
              } else if (state is UpdateDescriptionSuccess) {
                debugPrint('i18n.profile.description.success'.tr);
                setState(() {
                  description = state.user.description!;
                });
              } else {
                debugPrint('i18n.profile.other'.tr);
              }
            })
          ],
          child: RefreshIndicator(
              child: ListView(
                children: ListTile.divideTiles(context: context, tiles: [
                  //
                  ListTile(
                    // leading: LoadImage(avatar, width: 45.0, height: 45.0),
                    leading: CircleAvatar(
                      child: LoadImage(avatar, width: 45.0, height: 45.0),
                    ),
                    title: Text(nickname),
                    subtitle: Text(description.tr),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Get.toNamed(Routes.editProfile);
                      // context.read<ThemeCubit>().toggleBrightness();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.chat_bubble_outline),
                    title: Text('i18n.customer.service'.tr),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      // 进入客服中心
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ChatWebViewPage(
                          url:
                              "https://www.weiyuai.cn/chat?org=df_org_uid&t=1&sid=df_wg_uid&navbar=0&",
                          title: "i18n.customer.service".tr,
                        );
                      }));
                      // EasyLoading.showInfo('客服中心');
                      // BytedeskFlutter.startWorkGroupChat(
                      //     context, Constants.workGroupUid, "客服中心");
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.share_outlined),
                    title: Text('i18n.share.download'.tr),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Share.share(ChatConsts.websiteUrl,
                          subject: "i18n.app.share.subject".tr);
                    },
                  ),
                ]).toList(),
              ),
              onRefresh: () async {
                ChatUtils.getProfile(context);
              })),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("i18n.lifecycle.state".tr.trParams({'state': state.toString()}));
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
        setState(() {
          nickname = SpUtil.getString(ChatConsts.nickname)!;
          description = SpUtil.getString(ChatConsts.description)!;
        });
        break;
      case AppLifecycleState.detached: // 申请将暂时暂停
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  //
  void initListeners() {
    // 短信登录成功
    // bytedeskEventBus.on<SmsLoginSuccessEventBus>().listen((event) {
    //   debugPrint("i18n.sms.login.success".tr);
    //   // WeiyuUtils.getProfile(context);
    // });
  }
}
