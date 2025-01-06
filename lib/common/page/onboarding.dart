import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im/common/page/tab.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sp_util/sp_util.dart';

import '../../chat/util/chat_consts.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});
  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    super.initState();
    //
    initSharePreference();
  }

  // 初始化preference
  void initSharePreference() async {
    debugPrint("i18n.init.preference".tr);

    /// sp初始化
    await SpUtil.getInstance();
    // 待初始化之后才能读取
    checkFirstOpen();
  }

  // 检测是否第一次打开
  void checkFirstOpen() {
    if (SpUtil.isInitialized()) {
      bool firstOpen = SpUtil.getBool(ChatConsts.firstOpen, defValue: true)!;
      debugPrint("i18n.first.open".tr);
      if (!firstOpen) {
        _onIntroEnd(context);
      }
    } else {
      debugPrint("i18n.sp.not.initialized".tr);
    }
  }

  void _onIntroEnd(context) {
    debugPrint("i18n.intro.end".tr);
    // 设置非第一次打开
    SpUtil.putBool(ChatConsts.firstOpen, false);
    // 进入主页
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const TabPage()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/onboard/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      pages: [
        PageViewModel(
          title: "i18n.onboarding.enterprise.title".tr,
          body: "i18n.onboarding.enterprise.body".tr,
          image: _buildImage('img1.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "i18n.onboarding.customer.title".tr,
          body: "i18n.onboarding.customer.body".tr,
          image: _buildImage('img2.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "i18n.onboarding.ai.title".tr,
          body: "i18n.onboarding.ai.body".tr,
          image: _buildImage('img3.jpg'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: Text('i18n.onboarding.skip'.tr,
          style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: Text('i18n.onboarding.done'.tr,
          style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
