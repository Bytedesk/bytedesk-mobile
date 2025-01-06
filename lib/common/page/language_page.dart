/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-09-15 10:10:05
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-09-15 10:10:09
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Language'.tr)),
      body: ListView(
          children: ListTile.divideTiles(context: context, tiles: [
        ListTile(
          leading: const Icon(Icons.mobile_friendly_outlined),
          title: Text('English'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.light_mode_outlined),
          title: const Text('中文简体',),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.dark_mode_outlined),
          title: const Text('中文繁体',),
          onTap: () {},
        )
      ]).toList()),
    );
  }
}
