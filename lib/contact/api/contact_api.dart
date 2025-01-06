/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 14:40:36
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-11-28 22:21:56
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
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:im/contact/model/contact.dart';
import 'package:sp_util/sp_util.dart';

import '../../chat/util/base_api.dart';
import '../../chat/util/chat_consts.dart';
import '../../chat/util/chat_utils.dart';
import '../model/contact_data.dart';

class ContactHttpApi extends BaseHttpApi {
  ///
  /// http://localhost:8000/visitors/api/v1/query/contactqa?uid=1178211962621440&type=&page=0&size=10
  Future<ContactData> queryContact(int? page, int? size) async {
    String? currentUid = SpUtil.getString(ChatConsts.uid);
    String? orgUid = SpUtil.getString(ChatConsts.orgUid);
    debugPrint("queryContact:$orgUid, $currentUid");
    //
    final queryContactUrl = ChatUtils.getHostUri('/api/v1/member/query/org', {
      'pageNumber': page.toString(),
      'pageSize': size.toString(),
      'orgUid': orgUid,
      'client': client
    });
    final initResponse =
        await httpClient.get(queryContactUrl, headers: getHeaders());
    //解决json解析中的乱码问题
    Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
    //将string类型数据 转换为json类型的数据
    final responseJson =
        json.decode(utf8decoder.convert(initResponse.bodyBytes));
    // debugPrint("$queryContactUrl, queryContact:$responseJson");
    //
    ContactData contactData = ContactData.fromJson(responseJson['data']);
    if (contactData.contactList!.isNotEmpty) {
      for (Contact contact in contactData.contactList!) {
        if (contact.user?.uid == currentUid) {
          SpUtil.putString(ChatConsts.memberSelfUid, contact.uid!);
        }
      }
    }

    return contactData;
  }

  ///
  Future<ContactData> searchContact(
      int? page, int? size, String? content) async {
    //
    final queryContactUrl = ChatUtils.getHostUri('/api/v1/member/query/search', {
      'pageNumber': page.toString(),
      'pageSize': size.toString(),
      'content': content,
      'client': client
    });
    final initResponse =
        await httpClient.get(queryContactUrl, headers: getHeaders());
    //解决json解析中的乱码问题
    Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
    //将string类型数据 转换为json类型的数据
    final responseJson =
        json.decode(utf8decoder.convert(initResponse.bodyBytes));
    // debugPrint("searchContactList:$responseJson");
    //
    return ContactData.fromJson(responseJson['data']);
  }
}
