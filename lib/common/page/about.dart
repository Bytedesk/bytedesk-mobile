import 'package:bytedesk_kefu/bytedesk_kefu.dart';
import 'package:bytedesk_common/res/gaps.dart';
import 'package:bytedesk_common/util/utils.dart';
import 'package:bytedesk_common/widgets/click_item.dart';
import 'package:bytedesk_common/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../chat/util/chat_consts.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    // 检测是否有新版本，并升级
    checkAppVersion();
    //
    BytedeskKefu.getAppVersion().then((value) => {
          setState(() {
            _appVersion = value;
          })
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About'.tr),
        ),
        body: Stack(
          children: [
            Column(
              children: <Widget>[
                Gaps.vGap50,
                const LoadAssetImage(
                  'logo',
                  height: 100,
                  width: 100,
                ),
                Gaps.vGap10,
                ClickItem(
                    title: 'i18n.about.website'.tr,
                    content: '',
                    onTap: () {
                      Uri toLaunch = Uri(
                          scheme: 'https', host: ChatConsts.website, path: '/');
                      Utils.launchInBrowser(toLaunch);
                    }),
                // TODO: 检测到新版本，则红点提示，点击更新版本
                ClickItem(
                    title: 'i18n.about.version'.tr,
                    content: _appVersion,
                    onTap: () => {
                          // 检测是否有新版本，并升级
                          checkAppVersion()
                        }),
              ],
            ),
            Positioned(
              //设置子元素
              bottom: 100,
              width: Get.width,
              //设置子元素
              child: Row(
                children: [
                  Expanded(child: Container()),
                  InkWell(
                    child: Text(
                      "i18n.auth.user.agreement".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      //
                      final Uri toLaunch = Uri(
                          scheme: 'https',
                          host: ChatConsts.website,
                          path: '/protocol.html');
                      Utils.launchInBrowser(toLaunch);
                    },
                  ),
                  Text(
                    "i18n.auth.and".tr,
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    child: Text(
                      "i18n.auth.privacy.policy".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      //
                      final Uri toLaunch = Uri(
                          scheme: 'https',
                          host: ChatConsts.website,
                          path: '/privacy.html');
                      Utils.launchInBrowser(toLaunch);
                    },
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ],
        ));
  }

  // 检测是否有新版本，并升级
  void checkAppVersion() {
    // UpdateVersion.checkAppVersion(WeiyuConstants.bytedesk_kefu_KEY, context);
  }
}
