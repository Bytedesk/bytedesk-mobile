/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2025-01-06 12:04:44
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2025-01-06 13:14:06
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  技术/商务联系：270580156@qq.com
 * Copyright (c) 2025 by bytedesk.com, All Rights Reserved. 
//  */
// import 'dart:async';
// import 'dart:typed_data';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_scankit/flutter_scankit.dart';

// class BitmapMode extends StatefulWidget {
//   const BitmapMode({super.key});

//   @override
//   State<BitmapMode> createState() => _BitmapModeState();
// }

// class _BitmapModeState extends State<BitmapMode> {
//   CameraController? controller;
//   StreamSubscription? subscription;
//   String code = '';
//   ScanKitDecoder decoder = ScanKitDecoder(photoMode: false, parseResult: false);

//   @override
//   void initState() {
//     availableCameras().then((val) {
//       List<CameraDescription> _cameras = val;
//       if (_cameras.isNotEmpty) {
//         controller = CameraController(_cameras[0], ResolutionPreset.max);
//         controller!.initialize().then((_) {
//           if (!mounted) {
//             return;
//           }
//           controller!.startImageStream(onLatestImageAvailable);
//           setState(() {});
//         });
//       }
//     });

//     subscription = decoder.onResult.listen((event) async {
//       if (event is ResultEvent && event.value.isNotEmpty) {
//         subscription!.pause();
//         await stopScan();
//         if (mounted) {
//           setState(() {
//             code = event.value.originalValue;
//           });
//         }
//       } else if (event is ZoomEvent) {
//         /// set zoom value
//       }
//     });
//     super.initState();
//   }

//   Future<void> stopScan() async {
//     if (controller != null && controller!.value.isStreamingImages) {
//       // Pause the camera preview
//       await controller!.pausePreview();
//       await controller!.stopImageStream();
//     }
//   }

//   @override
//   void dispose() {
//     subscription?.cancel();
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//                 flex: 4,
//                 child: (controller != null && controller!.value.isInitialized)
//                     ? CameraPreview(controller!)
//                     : Placeholder()),
//             Expanded(
//                 flex: 1,
//                 child: Container(
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.all(16),
//                   child: Text(code),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }

//   void onLatestImageAvailable(CameraImage image) async {
//     if (image.planes.length == 1 &&
//         image.format.group == ImageFormatGroup.bgra8888) {
//       await decoder.decode(image.planes[0].bytes, image.width, image.height);
//     } else if (image.planes.length == 3) {
//       Uint8List y = image.planes[0].bytes;
//       Uint8List u = image.planes[1].bytes;
//       Uint8List v = image.planes[2].bytes;

//       Uint8List combined = Uint8List(y.length + u.length + v.length);
//       combined.setRange(0, y.length, y);
//       combined.setRange(y.length, y.length + u.length, u);
//       combined.setRange(y.length + u.length, y.length + u.length + v.length, v);
//       await decoder.decodeYUV(combined, image.width, image.height);
//     }
//   }
// }
