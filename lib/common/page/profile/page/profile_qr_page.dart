/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-09-09 09:36:11
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-09-09 10:31:35
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileQrPage extends StatelessWidget {
  
  final String userUid;
  const ProfileQrPage({super.key, required this.userUid});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 280,
                  child: QrImageView(
                    data: userUid,
                    version: QrVersions.auto,
                    gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [Color(0xff289f70), Color(0xff134b38)],
                    ),
                    /*gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xffff0000),
                        Color(0xffffa500),
                        Color(0xffffff00),
                        Color(0xff008000),
                        Color(0xff0000ff),
                        Color(0xff4b0082),
                        Color(0xffee82ee),
                      ], 
                    ),*/
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: Color(0xff128760),
                      borderRadius: 10,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Color(0xff1a5441),
                      borderRadius: 5,
                      roundedOutsideCorners: true,
                    ),
                    embeddedImage: const AssetImage(
                        'assets/images/4.0x/logo_yakka_transparent.png'),
                    embeddedImageStyle: const QrEmbeddedImageStyle(
                      size: Size.square(40),
                      color: Colors.white,
                      safeArea: true,
                      safeAreaMultiplier: 1.1,
                      embeddedImageShape: EmbeddedImageShape.square,
                      shapeColor: Color(0xff128760),
                      borderRadius: 10,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40)
                  .copyWith(bottom: 40),
              child: Text(userUid),
            ),
          ],
        ),
      ),
    );
  }
}
