/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-09-09 10:07:07
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-09-09 10:49:50
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// class ScannedBarcodeLabel extends StatelessWidget {
//   const ScannedBarcodeLabel({
//     super.key,
//     required this.barcodes,
//   });

//   final Stream<BarcodeCapture> barcodes;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: barcodes,
//       builder: (context, snapshot) {
//         final scannedBarcodes = snapshot.data?.barcodes ?? [];

//         if (scannedBarcodes.isEmpty) {
//           return const Text(
//             '',
//             overflow: TextOverflow.fade,
//             style: TextStyle(color: Colors.white),
//           );
//         }

//         return Text(
//           scannedBarcodes.first.displayValue ?? '未发现二维码.',
//           overflow: TextOverflow.fade,
//           style: const TextStyle(color: Colors.white),
//         );
//       },
//     );
//   }
// }
