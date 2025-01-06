/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 07:24:58
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-10-05 10:23:27
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'package:bytedesk_common/blocs/cubit/theme_cubit.dart';
import 'package:bytedesk_common/blocs/cubit/theme_state.dart';
import 'package:bytedesk_common/config/bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:im/chat/util/chat_consts.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:share_handler/share_handler.dart';
import 'package:sp_util/sp_util.dart';

import '../../chat/util/chat_utils.dart';
import '../../thread/api/thread_repository.dart';
import '../config/routes.dart';
import '../l10n/translations.dart';
import '../page/onboarding.dart';

class App extends StatelessWidget {
  const App({required ThreadRepository threadRepository, super.key})
      : _threadRepository = threadRepository;

  final ThreadRepository _threadRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _threadRepository,
        child: BlocProvider(
          create: (_) => ThemeCubit(),
          child: const AppView(),
        ));
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  //
  final _appKey = GlobalKey();
  String shortcut = 'no action set';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    initQuickActions();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    //
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        debugPrint('themeState.brightness ${themeState.brightness}');
        if (themeState.brightness == Brightness.dark) {
          SpUtil.putBool(ChatConsts.isDarkMode, true);
        } else {
          SpUtil.putBool(ChatConsts.isDarkMode, false);
        }
        //
        return GetMaterialApp(
          key: _appKey,
          title: 'AppName'.tr,
          debugShowCheckedModeBanner: ChatConsts.isDebug,
          enableLog: ChatConsts.isDebug,
          // theme: ThemeModel.light,
          theme:
              ThemeData(brightness: themeState.brightness, useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: themeState.themeMode!,
          initialBinding: AppBindings(),
          translations: AppTranslations(),
          supportedLocales: AppTranslations.supportedLocales,
          locale: Get.deviceLocale,
          fallbackLocale: AppTranslations.fallbackLocale,
          localizationsDelegates: AppTranslations.localizationsDelegates,
          home: const OnBoardingPage(),
          initialRoute: '/',
          getPages: Routes.getPages,
          unknownRoute: Routes.unknownPage,
          builder: (context, widget) {
            return FlutterEasyLoading(child: widget!);
          },
        );
      },
    );
  }

  /// 长按桌面显示快捷菜单，
  /// 参考：https://pub.dev/packages/quick_actions
  /// ios： https://developer.apple.com/design/human-interface-guidelines/home-screen-quick-actions
  /// android：https://developer.android.com/develop/ui/views/launch/shortcuts?hl=zh-cn
  /// github： https://github.com/flutter/packages/blob/main/packages/quick_actions/quick_actions/example/lib/main.dart
  void initQuickActions() {
    const QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      setState(() {
        shortcut = shortcutType;
      });
    });
    //
    quickActions.setShortcutItems(<ShortcutItem>[
      // NOTE: This first action icon will only work on iOS.
      // In a real world project keep the same file name for both platforms.
      ShortcutItem(
        type: 'action_scan',
        localizedTitle: '扫一扫',
        icon: ChatUtils.isIOS ? 'AppIcon' : 'mipmap/ic_launcher',
      ),
      // NOTE: This second action icon will only work on Android.
      // In a real world project keep the same file name for both platforms.
      // const ShortcutItem(type: 'action_two', localizedTitle: '扫一扫', icon: 'ic_launcher'),
    ]).then((void _) {
      setState(() {
        if (shortcut == 'no action set') {
          shortcut = 'actions ready';
        }
      });
    });
  }

  /// 接收其他应用的分享文件
  /// https://pub.dev/packages/share_handler
  SharedMedia? media;
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final handler = ShareHandlerPlatform.instance;
    media = await handler.getInitialSharedMedia();

    handler.sharedMediaStream.listen((SharedMedia media) {
      if (!mounted) return;
      setState(() {
        this.media = media;
      });
    });
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });
  }
}
