/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 07:24:58
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-10-05 10:34:44
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'package:bytedesk_common/util/update.dart';
import 'package:bytedesk_kefu/util/bytedesk_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:im/chat/util/chat_consts.dart';

import '../../../common/config/routes.dart';
import '../../chat/mqtt/bytedesk_mqtt.dart';
import '../../chat/util/chat_utils.dart';

// 设置
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'.tr),
        // elevation: 0,
      ),
      body: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          ListTile(
            leading: const Icon(Icons.theater_comedy_outlined),
            title: Text('Theme'.tr),
            onTap: () {
              Get.toNamed(Routes.theme);
            },
          ),
          Visibility(
            visible: ChatConsts.isDebug,
            child: ListTile(
              leading: const Icon(Icons.account_balance_outlined),
              title: Text('Mode'.tr),
              onTap: () {
                Get.toNamed(Routes.mode);
              },
            ),
          ),
          Visibility(
              visible: ChatConsts.isDebug,
              child: ListTile(
                leading: const Icon(Icons.star_border_outlined),
                title: Text('Status'.tr),
                onTap: () {
                  Get.toNamed(Routes.status);
                },
              )),
          Visibility(
              visible: ChatConsts.isDebug,
              child: ListTile(
                leading: const Icon(Icons.language_outlined),
                title: Text('Language'.tr),
                onTap: () {
                  Get.toNamed(Routes.language);
                },
              )),
          ListTile(
            leading: const Icon(Icons.album_outlined),
            title: Text('About'.tr),
            onTap: () {
              Get.toNamed(Routes.about);
            },
          ),
          ListTile(
            leading: const Icon(Icons.undo_rounded),
            title: Text('Unregister'.tr),
            onTap: () {
              UpdateVersion.showUnregisterDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.cleaning_services_outlined),
            title: Text('ClearCache'.tr),
            onTap: () {
              HydratedBloc.storage.clear();
              EasyLoading.showInfo('i18n.cache.cleared'.tr);
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_outlined),
            title: Text('Logout'.tr),
            onTap: () {
              Get.defaultDialog(
                title: "i18n.dialog.tip".tr,
                middleText: "i18n.dialog.confirm.logout".tr,
                textConfirm: "i18n.dialog.confirm".tr,
                textCancel: "i18n.dialog.cancel".tr,
                onConfirm: () => {
                  // ...
                  Get.back(),
                  //
                  BytedeskMqtt().disconnect(),
                  ChatUtils.showAuth(context),
                  BytedeskUtils.clearUserCache()
                  //
                  // BytedeskFlutter.logout(),
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) {
                  //   return const AuthProvider();
                  // }))
                },
                onCancel: () => {},
              );
            },
          ),
        ]).toList(),
      ),
    );
  }
}
