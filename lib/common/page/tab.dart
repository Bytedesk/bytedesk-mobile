import 'dart:async';

import 'package:bytedesk_common/blocs/profile_bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../chat/util/chat_utils.dart';
import '../../contact/api/contact_repository.dart';
import '../../contact/bloc/bloc.dart';
import '../../contact/view/contacts_page.dart';
import '../../discovery/view/discover_page.dart';
import '../../robot/api/robot_repository.dart';
import '../../robot/bloc/bloc.dart';
import '../../thread/api/thread_repository.dart';
import '../../thread/bloc/bloc.dart';
import '../../thread/view/thread_page.dart';
import '../auth/bloc/bloc.dart';
import 'mine_tab_page.dart';

// Tab页面
class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage>
    with AutomaticKeepAliveClientMixin<TabPage> {
  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  // Page Controller.
  late PageController _pageController;
  // Current page.
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    //
    initConnectivity();
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    // 检测是否有新版本，并升级
    checkAppVersion();
    // 判断是否登录，如果未登录，则弹登录页面
    bool? isLogin = ChatUtils.isLogin();
    if (!isLogin!) {
      ChatUtils.showAuth(context);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onBottomNavigationBarTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: 'Home'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.book_outlined),
            label: 'Contact'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_outline),
            label: 'Discovery'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            label: 'Mine'.tr,
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   super.build(context);
  //   // Define the list of destinations to be used within the app.
  //   List<NavigationDestination> destinations = <NavigationDestination>[
  //     NavigationDestination(
  //       label: 'Home'.tr,
  //       icon: const Icon(Icons.home_outlined),
  //       // selectedIcon: Icon(Icons.inbox),
  //     ),
  //     NavigationDestination(
  //       label: 'Contact'.tr,
  //       icon: const Icon(Icons.book_outlined),
  //       // selectedIcon: Icon(Icons.inbox),
  //     ),
  //     NavigationDestination(
  //       label: 'AI'.tr,
  //       icon: const Icon(Icons.favorite_outline),
  //       // selectedIcon: Icon(Icons.inbox),
  //     ),
  //     NavigationDestination(
  //       label: 'Mine'.tr,
  //       icon: const Icon(Icons.settings_outlined),
  //       // selectedIcon: Icon(Icons.video_call),
  //     ),
  //   ];
  //   // #docregion Example
  //   // AdaptiveLayout has a number of slots that take SlotLayouts and these
  //   // SlotLayouts' configs take maps of Breakpoints to SlotLayoutConfigs.
  //   return AdaptiveLayout(
  //     // Primary navigation config has nothing from 0 to 600 dp screen width,
  //     // then an unextended NavigationRail with no labels and just icons then an
  //     // extended NavigationRail with both icons and labels.
  //     primaryNavigation: SlotLayout(
  //       config: <Breakpoint, SlotLayoutConfig>{
  //         Breakpoints.medium: SlotLayout.from(
  //           inAnimation: AdaptiveScaffold.leftOutIn,
  //           key: const Key('Primary Navigation Medium'),
  //           builder: (_) => AdaptiveScaffold.standardNavigationRail(
  //             selectedIndex: _pageIndex,
  //             onDestinationSelected: (int newIndex) {
  //               setState(() {
  //                 _pageIndex = newIndex;
  //               });
  //               _onBottomNavigationBarTap(_pageIndex);
  //             },
  //             // leading: const Icon(Icons.menu),
  //             destinations: destinations
  //                 .map((_) => AdaptiveScaffold.toRailDestination(_))
  //                 .toList(),
  //           ),
  //         ),
  //         Breakpoints.large: SlotLayout.from(
  //           key: const Key('Primary Navigation Large'),
  //           inAnimation: AdaptiveScaffold.leftOutIn,
  //           builder: (_) => AdaptiveScaffold.standardNavigationRail(
  //             selectedIndex: _pageIndex,
  //             onDestinationSelected: (int newIndex) {
  //               setState(() {
  //                 _pageIndex = newIndex;
  //               });
  //               _onBottomNavigationBarTap(_pageIndex);
  //             },
  //             extended: true, // 显示文字
  //             destinations: destinations
  //                 .map((_) => AdaptiveScaffold.toRailDestination(_))
  //                 .toList(),
  //           ),
  //         ),
  //       },
  //     ),
  //     // Body switches between a ListView and a GridView from small to medium
  //     // breakpoints and onwards.
  //     body: SlotLayout(
  //       config: <Breakpoint, SlotLayoutConfig>{
  //         Breakpoints.small: SlotLayout.from(
  //             key: const Key('Body Small'),
  //             builder: (_) => getBody()
  //         ),
  //         Breakpoints.medium: SlotLayout.from(
  //           key: const Key('Body Medium'),
  //           builder: (_) => getBody(),
  //         ),
  //         Breakpoints.mediumLarge: SlotLayout.from(
  //           key: const Key('Body Medium'),
  //           builder: (_) => getBody(),
  //         ),
  //         Breakpoints.large: SlotLayout.from(
  //           key: const Key('Body Medium'),
  //           builder: (_) => getBody(),
  //         ),
  //         Breakpoints.extraLarge: SlotLayout.from(
  //           key: const Key('Body Medium'),
  //           builder: (_) => getBody(),
  //         )
  //       },
  //     ),
  //     // secondaryBody: SlotLayout(
  //     //   config: <Breakpoint, SlotLayoutConfig?>{
  //     //     Breakpoints.mediumAndUp: SlotLayout.from(
  //     //       // This overrides the default behavior of the secondaryBody
  //     //       // disappearing as it is animating out.
  //     //       outAnimation: AdaptiveScaffold.stayOnScreen,
  //     //       key: const Key('Secondary Body'),
  //     //       builder: (_) => SafeArea(
  //     //           child: BlocProvider<ThreadBloc>(
  //     //         create: (context) => ThreadBloc(context.read<ThreadRepository>()),
  //     //         child: const ThreadPage(),
  //     //       )),
  //     //     )
  //     //   },
  //     // ),
  //     // BottomNavigation is only active in small views defined as under 600 dp width.
  //     bottomNavigation: SlotLayout(
  //       config: <Breakpoint, SlotLayoutConfig>{
  //         // 手机上显示
  //         Breakpoints.smallAndUp: SlotLayout.from(
  //           key: const Key('Bottom Navigation Small'),
  //           // inAnimation: AdaptiveScaffold.bottomToTop,
  //           // outAnimation: AdaptiveScaffold.topToBottom,
  //           builder: (_) => BottomNavigationBar(
  //             currentIndex: _pageIndex,
  //             type: BottomNavigationBarType.fixed,
  //             onTap: _onBottomNavigationBarTap,
  //             items: <BottomNavigationBarItem>[
  //               BottomNavigationBarItem(
  //                 icon: const Icon(Icons.home_outlined),
  //                 label: 'Home'.tr,
  //               ),
  //               BottomNavigationBarItem(
  //                 icon: const Icon(Icons.book_outlined),
  //                 label: 'Contact'.tr,
  //               ),
  //               BottomNavigationBarItem(
  //                 icon: const Icon(Icons.favorite_outline),
  //                 label: 'AI'.tr,
  //               ),
  //               BottomNavigationBarItem(
  //                 icon: const Icon(Icons.settings_outlined),
  //                 label: 'Mine'.tr,
  //               ),
  //             ],
  //           ),
  //         )
  //       },
  //     ),
  //   );
  //   // #enddocregion Example
  // }

  Widget getBody() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider<ThreadBloc>(
          create: (context) => ThreadBloc(context.read<ThreadRepository>()),
        ),
        BlocProvider<ContactBloc>(
          create: (context) => ContactBloc(ContactRepository()),
        ),
        BlocProvider<RobotBloc>(
          create: (context) => RobotBloc(RobotRepository()),
        ),
      ],
      child: PageView(
        controller: _pageController,
        children: const <Widget>[
          ThreadPage(),
          // ContactPage(),
          ContactsPage(),
          // RobotPage(),
          DiscoverPage(),
          MineTabPage()
        ],
        onPageChanged: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    // late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // try {
    //   result = await _connectivity.checkConnectivity();
    // } on PlatformException catch (e) {
    //   debugPrint('Couldn\'t check connectivity status $e');
    //   return;
    // }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    // return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      // _connectionStatus = result;
      debugPrint("_updateConnectionStatus $result");
      if (result == ConnectivityResult.none) {
        EasyLoading.showError('请检查网络是否可用');
        // Alert(
        //   context: context,
        //   title: "无网络",
        //   desc: "请检查网络是否可用",
        //   buttons: [
        //     DialogButton(
        //       onPressed: () => Navigator.pop(context),
        //       color: const Color.fromRGBO(0, 179, 134, 1.0),
        //       radius: BorderRadius.circular(0.0),
        //       child: const Text(
        //         "确定",
        //         style: TextStyle(color: Colors.white, fontSize: 20),
        //       ),
        //     ),
        //   ],
        // ).show();
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // Change page.
  void _onBottomNavigationBarTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }

  // 检测是否有新版本，并升级
  void checkAppVersion() {
    // UpdateVersion.checkAppVersion(WeiyuConstants.bytedesk_kefu_KEY, context);
  }

  @override
  bool get wantKeepAlive => true;
}
