/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 07:24:58
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-09-14 19:20:16
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im/common/config/routes.dart';

import '../../contact/model/contact.dart';
import '../../contact/view/contact_detail_provider.dart';
import '../../utils/constants.dart';

class CommonUtils {
  static String getImgPath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static Widget getSusItem(BuildContext context, String tag, Brightness? brightness,
      {double susHeight = 40}) {
    if (tag == '★') {
      tag = '★ 热门城市';
    }
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 16.0),
      color: brightness == Brightness.dark ? null : const Color(0xFFF3F4F5),
      alignment: Alignment.centerLeft,
      child: Text(
        tag,
        softWrap: false,
        style: const TextStyle(
          fontSize: 14.0,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

  static Widget getWeChatItem(
    BuildContext context,
    ContactInfo model, Brightness? brightness, {
    Color? defHeaderBgColor,
  }) {
    DecorationImage? image;
    if (model.img != null && model.img!.isNotEmpty) {
      image = DecorationImage(
        image: CachedNetworkImageProvider(model.img!),
        fit: BoxFit.contain,
      );
    }
    return Card(
      elevation: 1.0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: const EdgeInsets.only(bottom: 0.2),
      child: ListTile(
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4.0),
            color: model.bgColor ?? defHeaderBgColor,
            image: image,
          ),
          child: model.iconData == null
              ? null
              : Icon(
                  model.iconData,
                  color: Colors.white,
                  size: 20,
                ),
        ),
        title: Text(model.name),
        onTap: () {
          // LogUtil.e("onItemClick : $model");
          // CommonUtils.showSnackBar(context, 'onItemClick : ${model.name}');
          if (model.id == Constants.contactNewFriend) {
            // 新朋友
            Get.toNamed(Routes.newFriend);
          } else if (model.id == Constants.contactGroupChat) {
            // 群聊
            Get.toNamed(Routes.groupChats);
          } else if (model.id == Constants.contactTags) {
            // 标签
            Get.toNamed(Routes.tags);
          } else if (model.id == Constants.contactMps) {
            // 公众号
            Get.toNamed(Routes.mps);
          } else {
            // 好友
            chooseContact(model.contact!, context);
          }
        },
      ),
    );
  }

  static void chooseContact(Contact contact, BuildContext context) {
    debugPrint("chooseContact:${contact.uid}");
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ContactDetailProvider(contact: contact);
    }));
  }
}
