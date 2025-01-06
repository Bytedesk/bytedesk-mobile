/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-09-09 10:57:16
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-09-09 10:57:20
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
//
// import 'package:flutter/material.dart';

// class ScannerOverlay extends CustomPainter {
//   const ScannerOverlay({
//     required this.scanWindow,
//     this.borderRadius = 12.0,
//   });

//   final Rect scanWindow;
//   final double borderRadius;

//   @override
//   void paint(Canvas canvas, Size size) {
//     // TODO: use `Offset.zero & size` instead of Rect.largest
//     // we need to pass the size to the custom paint widget
//     final backgroundPath = Path()..addRect(Rect.largest);

//     final cutoutPath = Path()
//       ..addRRect(
//         RRect.fromRectAndCorners(
//           scanWindow,
//           topLeft: Radius.circular(borderRadius),
//           topRight: Radius.circular(borderRadius),
//           bottomLeft: Radius.circular(borderRadius),
//           bottomRight: Radius.circular(borderRadius),
//         ),
//       );

//     final backgroundPaint = Paint()
//       ..color = Colors.black.withOpacity(0.5)
//       ..style = PaintingStyle.fill
//       ..blendMode = BlendMode.dstOut;

//     final backgroundWithCutout = Path.combine(
//       PathOperation.difference,
//       backgroundPath,
//       cutoutPath,
//     );

//     final borderPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 4.0;

//     final borderRect = RRect.fromRectAndCorners(
//       scanWindow,
//       topLeft: Radius.circular(borderRadius),
//       topRight: Radius.circular(borderRadius),
//       bottomLeft: Radius.circular(borderRadius),
//       bottomRight: Radius.circular(borderRadius),
//     );

//     // First, draw the background,
//     // with a cutout area that is a bit larger than the scan window.
//     // Finally, draw the scan window itself.
//     canvas.drawPath(backgroundWithCutout, backgroundPaint);
//     canvas.drawRRect(borderRect, borderPaint);
//   }

//   @override
//   bool shouldRepaint(ScannerOverlay oldDelegate) {
//     return scanWindow != oldDelegate.scanWindow ||
//         borderRadius != oldDelegate.borderRadius;
//   }
// }
