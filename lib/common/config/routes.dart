/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 07:24:58
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2025-01-06 13:15:13
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
// import '../../ui/page/chat.dart';
import 'package:bytedesk_common/blocs/cubit/theme_page.dart';
import 'package:bytedesk_common/page/unknownPage.dart';
import 'package:get/get.dart';
import 'package:im/common/page/language_page.dart';
import 'package:im/contact/view/group_chat_page.dart';
import 'package:im/contact/view/mps_page.dart';
import 'package:im/contact/view/new_friend_page.dart';
import 'package:im/contact/view/tags_page.dart';
import 'package:im/robot/view/robot_provider.dart';
import '../page/about.dart';
import '../page/mode_page.dart';
import '../page/onboarding.dart';
import '../page/profile/provider/edit_profile_provider.dart';
// import '../page/qr_scanner_page.dart';
import '../page/setting.dart';
import '../page/status_page.dart';
// import '../widget/scan/default_mode.dart';

class Routes {
  // Home
  static const home = '/';
  //
  // static const login = '/login';
  static const theme = '/theme';
  static const about = '/about';
  static const setting = '/setting';
  static const history = '/history';
  static const discovery = '/discovery';
  static const settle = '/settle';
  static const disclaimer = '/disclaimer';
  static const mode = '/mode';
  static const status = '/status';
  static const language = '/language';
  //
  static const editProfile = '/editProfile';
  static const favorite = '/favorite';
  static const qrScan = '/qrScan';
  // contact
  static const newFriend = '/newFriend';
  static const groupChats = '/groupChats';
  static const tags = '/tags';
  static const mps = '/mps';
  // discovery
  static const robot = '/robot';

  static final getPages = [
    // Home
    GetPage(
      name: home,
      page: () => const OnBoardingPage(),
    ),
    //
    // GetPage(name: login, page: const AuthProvider());
    GetPage(name: theme, page: () => const ThemePage()),
    GetPage(name: about, page: () => const AboutPage()),
    GetPage(name: setting, page: () => const SettingPage()),
    // GetPage(name: history, page: () => const HistoryPage()),
    // GetPage(name: discovery, page: () => const HomeTabPage()),
    // GetPage(name: settle, page: () => const EditSettleProvider()),
    // GetPage(name: disclaimer, page: () => const DisclaimerPage()),
    GetPage(name: mode, page: () => const ModePage()),
    GetPage(name: status, page: () => const StatusPage()),
    GetPage(name: language, page: () => const LanguagePage()),
    //
    GetPage(name: editProfile, page: () => const EditProfileProvider()),
    // GetPage(name: favorite, page: () => const FavoritePage()),
    // GetPage(name: qrScan, page: () => const QrScannerPage()),
    // GetPage(name: qrScan, page: () => const DefaultMode()),
    //
    GetPage(name: newFriend, page: () => const NewFriendPage()),
    GetPage(name: groupChats, page: () => const GroupChatPage()),
    GetPage(name: tags, page: () => const TagsPage()),
    GetPage(name: mps, page: () => const MpsPage()),
    //
    GetPage(name: robot, page: () => const RobotProvider()),
  ];

  //
  static final unknownPage =
      GetPage(name: '/notfound', page: () => const UnknownPage());
}
