//

import 'dart:async';

// import 'package:bytedesk_kefu/bytedesk_kefu.dart';
// import 'package:bytedesk_kefu/ui/widget/pop_up_menu.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:sp_util/sp_util.dart';

// import '../../chat/util/chat_consts.dart';
// import '../auth/view/auth_scan_provider.dart';
// import '../widget/scan/scanner_error_widget.dart';

// // https://github.com/juliansteenbakker/mobile_scanner
// class QrScannerPage extends StatefulWidget {
//   const QrScannerPage({super.key});

//   @override
//   State<QrScannerPage> createState() => _QrScannerPageState();
// }

// class _QrScannerPageState extends State<QrScannerPage>
//     with WidgetsBindingObserver {
//   final MobileScannerController controller = MobileScannerController(
//     torchEnabled: false,
//   );
//   Barcode? _barcode;
//   StreamSubscription<Object?>? _subscription;
//   //
//   final BytedeskPopupMenuController _popupMenuController =
//       BytedeskPopupMenuController();
//   final List<ItemModel> menuItems = [
//     ItemModel('album', '相册', Icons.album),
//     ItemModel('splash', '闪光灯', Icons.flash_auto),
//     ItemModel('switch', '切换摄像头', Icons.camera),
//   ];
//   //
//   void _handleBarcode(BarcodeCapture barcodes) {
//     debugPrint('Barcode: $barcodes');
//     if (mounted && _barcode == null) {
//       // 扫码成功，播放提示音
//       SystemSound.play(SystemSoundType.click);
//       //
//       setState(() {
//         _barcode = barcodes.barcodes.firstOrNull;
//       });
//       debugPrint('Barcode: ${_barcode?.format}');
//       EasyLoading.showSuccess('扫码成功');
//       if (_barcode?.type == BarcodeType.url) {
//         // EasyLoading.showToast('${_barcode?.type}');
//         BytedeskKefu.openWebView(context, _barcode!.displayValue!, '网页');
//       } else if (_barcode!.displayValue!.contains('deviceUid')) {
//         // 跳转到点击确认登录页面
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           // 退出扫描页面
//           Navigator.of(context).pop();
//           //deviceUid=设备唯一uid&code=随机code&platform=平台
//           String qrcode = _barcode!.displayValue!;
//           List<String> parts = qrcode.split("&");
//           String deviceUid = parts[0].split("=")[1];
//           String code = parts[1].split("=")[1];
//           String mobile = SpUtil.getString(ChatConsts.mobile)!;
//           debugPrint('deviceUid: $deviceUid code: $code');
//           // 
//           Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//             return AuthScanProvider(
//               mobile: mobile,
//               deviceUid: deviceUid,
//               code: code,
//             );
//           }));
//         });
//       } else {
//         EasyLoading.showToast('${_barcode?.displayValue}');
//       }
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Start listening to lifecycle changes.
//     WidgetsBinding.instance.addObserver(this);
//     // Start listening to the barcode events.
//     _subscription = controller.barcodes.listen(_handleBarcode);
//     // Finally, start the scanner itself.
//     unawaited(controller.start());
//   }

//   double _zoomFactor = 0.0;
//   Widget _buildZoomScaleSlider() {
//     return ValueListenableBuilder(
//       valueListenable: controller,
//       builder: (context, state, child) {
//         if (!state.isInitialized || !state.isRunning) {
//           return const SizedBox.shrink();
//         }

//         final TextStyle labelStyle = Theme.of(context)
//             .textTheme
//             .headlineMedium!
//             .copyWith(color: Colors.white);

//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Row(
//             children: [
//               Text(
//                 '0%',
//                 overflow: TextOverflow.fade,
//                 style: labelStyle,
//               ),
//               Expanded(
//                 child: Slider(
//                   value: _zoomFactor,
//                   onChanged: (value) {
//                     setState(() {
//                       _zoomFactor = value;
//                       debugPrint("_zoomFactor: $value");
//                       controller.setZoomScale(value);
//                     });
//                   },
//                 ),
//               ),
//               Text(
//                 '100%',
//                 overflow: TextOverflow.fade,
//                 style: labelStyle,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO：动态扫描框
//     // final scanWindow = Rect.fromCenter(
//     //   center: MediaQuery.sizeOf(context).center(Offset.zero),
//     //   width: 200,
//     //   height: 200,
//     // );
//     //
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('二维码'),
//         // actions: [
//         //   BytedeskPopupMenu(
//         //     menuBuilder: _topRightMenu(),
//         //     pressType: PressType.singleClick,
//         //     verticalMargin: -10,
//         //     controller: _popupMenuController,
//         //     child: Container(
//         //       padding: const EdgeInsets.all(20),
//         //       child: const Icon(Icons.more_horiz_outlined),
//         //     ),
//         //   )
//         // ],
//         backgroundColor: Colors.transparent, // 修改这里来设置透明背景
//         elevation: 0,
//       ),
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: controller,
//             // fit: BoxFit.contain,
//             // scanWindow: scanWindow,
//             errorBuilder: (context, error, child) {
//               return ScannerErrorWidget(error: error);
//             },
//             // overlayBuilder: (context, constraints) {
//             //   return Padding(
//             //     padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: -50),
//             //     child: Align(
//             //       alignment: Alignment.bottomCenter,
//             //       child: ScannedBarcodeLabel(barcodes: controller.barcodes),
//             //     ),
//             //   );
//             // },
//           ),
//           // TODO:
//           // 在Stack中添加这个新的Widget
//           // GestureDetector(
//           //   onScaleUpdate: (ScaleUpdateDetails details) {
//           //     // 获取缩放比例
//           //     double scale = details.scale;
//           //    // ScaleUpdateDetails 对象的 scale 属性表示的是缩放的比例，其值大于1，将其转换为0~1区间
//           //     debugPrint("GestureDetector scale: $scale");
//           //     double normalizedScale = 1 - (1 - details.scale) / 2;
//           //     // 假设controller是MobileScanner的控制器实例，并且有一个setZoomScale方法
//           //     controller.setZoomScale(normalizedScale); // 调用方法来设置缩放比例
//           //   },
//           //   behavior: HitTestBehavior.translucent,
//           //   child: Container(
//           //     width: double.infinity, // 设置宽度为全屏
//           //     height: double.infinity, // 设置高度为全屏
//           //     color: Colors.transparent, // 设置透明背景，以便不影响下方Widget的显示
//           //   ), // 设置透明点击行为，以便手势可以穿透到下方Widget（如果需要）
//           // ),
//           // ValueListenableBuilder(
//           //   valueListenable: controller,
//           //   builder: (context, value, child) {
//           //     if (!value.isInitialized ||
//           //         !value.isRunning ||
//           //         value.error != null) {
//           //       return const SizedBox();
//           //     }
//           //     return CustomPaint(
//           //       painter: ScannerOverlay(scanWindow: scanWindow),
//           //     );
//           //   },
//           // ),
//           // Align(
//           //   alignment: Alignment.bottomCenter,
//           //   child: Container(
//           //     alignment: Alignment.bottomCenter,
//           //     height: 100,
//           //     color: Colors.black.withOpacity(0.4),
//           //     child: Column(
//           //       children: [
//           //         if (!kIsWeb) _buildZoomScaleSlider(),
//           //       ],
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }

//   // 聊天页面右上角plus按钮，显示下拉菜单
//   Widget _topRightMenu() {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(5),
//       child: Container(
//         color: const Color(0xFF4C4C4C),
//         child: IntrinsicWidth(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: menuItems
//                 .map(
//                   (item) => GestureDetector(
//                     behavior: HitTestBehavior.translucent,
//                     onTap: () {
//                       debugPrint("onTap ${item.name}");
//                       _popupMenuController.hideMenu();
//                       //
//                       EasyLoading.showToast("${item.name} clicked");
//                       // ToggleFlashlightButton(controller: controller),
//                       // SwitchCameraButton(controller: controller),
//                       // AnalyzeImageFromGalleryButton(controller: controller),
//                       //
//                     },
//                     child: Container(
//                       height: 40,
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Row(
//                         children: <Widget>[
//                           Icon(
//                             item.icon,
//                             size: 15,
//                             color: Colors.white,
//                           ),
//                           Expanded(
//                             child: Container(
//                               margin: const EdgeInsets.only(left: 10),
//                               padding: const EdgeInsets.symmetric(vertical: 10),
//                               child: Text(
//                                 item.title,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     // If the controller is not ready, do not try to start or stop it.
//     // Permission dialogs can trigger lifecycle changes before the controller is ready.
//     if (!controller.value.isInitialized) {
//       return;
//     }

//     switch (state) {
//       case AppLifecycleState.detached:
//       case AppLifecycleState.hidden:
//       case AppLifecycleState.paused:
//         return;
//       case AppLifecycleState.resumed:
//         // Restart the scanner when the app is resumed.
//         // Don't forget to resume listening to the barcode events.
//         _subscription = controller.barcodes.listen(_handleBarcode);
//         unawaited(controller.start());
//       case AppLifecycleState.inactive:
//         // Stop the scanner when the app is paused.
//         // Also stop the barcode events subscription.
//         unawaited(_subscription?.cancel());
//         _subscription = null;
//         unawaited(controller.stop());
//     }
//   }

//   @override
//   Future<void> dispose() async {
//     // Stop listening to lifecycle changes.
//     WidgetsBinding.instance.removeObserver(this);
//     // Stop listening to the barcode events.
//     unawaited(_subscription?.cancel());
//     _subscription = null;
//     // Dispose the widget itself.
//     super.dispose();
//     // Finally, dispose of the controller.
//     await controller.dispose();
//   }
// }
