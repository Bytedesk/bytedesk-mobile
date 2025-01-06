// /*
//  * @Author: jackning 270580156@qq.com
//  * @Date: 2025-01-06 12:04:43
//  * @LastEditors: jackning 270580156@qq.com
//  * @LastEditTime: 2025-01-06 13:09:49
//  * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
//  *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
//  *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
//  *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
//  *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
//  *  contact: 270580156@qq.com 
//  *  技术/商务联系：270580156@qq.com
//  * Copyright (c) 2025 by bytedesk.com, All Rights Reserved. 
//  */
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_scankit/flutter_scankit.dart';
// import 'package:permission_handler/permission_handler.dart';

// class DefaultMode extends StatefulWidget {
//   const DefaultMode({super.key});

//   @override
//   State<DefaultMode> createState() => _DefaultModeState();
// }

// class _DefaultModeState extends State<DefaultMode> {
//   ScanKit? scanKit;
//   String code = "";

//   @override
//   void initState() {
//     super.initState();
//     // flutter_scankit无法在模拟器中运行
//     // Check if running on a simulator or web
//     if (kIsWeb ||
//         (Platform.isIOS && !Platform.isMacOS) ||
//         (Platform.isAndroid && !Platform.isLinux)) {
//       // 在模拟器中运行的逻辑
//       code = "模拟器中运行，无法使用扫描功能";
//     } else {
//       scanKit = ScanKit();
//       scanKit!.onResult.listen((val) {
//         debugPrint(
//             "scanning result:${val.originalValue}  scanType:${val.scanType}");
//         setState(() {
//           code = val.originalValue;
//         });
//       });
//       _requestPermission();
//     }
//   }

//   Future<void> _requestPermission() async {
//     await Permission.camera.onGrantedCallback(() {
//       startScan();
//     }).request();
//   }

//   @override
//   void dispose() {
//     scanKit?.dispose();
//     super.dispose();
//   }

//   Future<void> startScan() async {
//     try {
//       await scanKit?.startScan(
//           scanTypes: ScanTypes.qRCode.bit |
//               ScanTypes.code39.bit |
//               ScanTypes.code128.bit);
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               code,
//               maxLines: 2,
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             ElevatedButton(
//               child: Text("Scan Code"),
//               onPressed: () async {
//                 // if (!await FlutterEasyPermission.has(
//                 //     perms: permissions, permsGroup: permissionGroup)) {
//                 //   FlutterEasyPermission.request(
//                 //       perms: permissions, permsGroup: permissionGroup);
//                 // } else {
//                 // startScan();
//                 // }
//                 _requestPermission();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
