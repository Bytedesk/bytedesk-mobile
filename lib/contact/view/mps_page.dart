/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-09-13 14:12:05
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-09-13 17:23:17
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
import 'package:bytedesk_kefu/ui/widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 公众号列表页面
class MpsPage extends StatefulWidget {
  const MpsPage({super.key});

  @override
  State<MpsPage> createState() => _MpsPageState();
}

class _MpsPageState extends State<MpsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('i18n.contact.mps'.tr),
      ),
      body: EmptyWidget(
        tip: 'i18n.contact.no.data'.tr,
        tapCallback: () {},
      ),
    );
  }
}
