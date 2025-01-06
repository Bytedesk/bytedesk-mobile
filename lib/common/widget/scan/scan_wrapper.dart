/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2025-01-06 12:58:15
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2025-01-06 13:09:41
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  技术/商务联系：270580156@qq.com
 * Copyright (c) 2025 by bytedesk.com, All Rights Reserved. 
 */
// import 'dart:io';
// import 'package:flutter/foundation.dart';

// // Real scanner implementation
// @pragma('vm:entry-point')
// class ScanWrapper {
//   static bool get isAvailable {
//     if (kIsWeb) return false;
//     if (Platform.isAndroid) return true;
//     if (Platform.isIOS) {
//       // iOS simulator check
//       return !bool.fromEnvironment('FLUTTER_TEST') &&
//           !bool.fromEnvironment('SIMULATOR');
//     }
//     return false;
//   }

//   static Future<dynamic> startScan() async {
//     if (!isAvailable) {
//       return Future.value("i18n.scanner.not.available".tr);
//     }

//     // Only import flutter_scankit when actually needed
//     if (isAvailable) {
//       await import_scankit();
//     }
//   }
// }

// // This function will only be compiled for real devices
// @pragma('vm:entry-point')
// Future<void> import_scankit() async {
//   if (ScanWrapper.isAvailable) {
//     // Import and use flutter_scankit
//     await import('package:flutter_scankit/flutter_scankit.dart');
//   }
// }
