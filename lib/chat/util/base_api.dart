/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-15 13:47:27
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-09-13 16:32:06
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
import 'dart:io';

import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;

import 'chat_consts.dart';
import 'chat_utils.dart';

class BaseHttpApi {
  //
  String client = ChatUtils.getClient();
  final http.Client httpClient = http.Client();

  BaseHttpApi();
  //
  Map<String, String> getHeaders() {
    String? accessToken = SpUtil.getString(ChatConsts.accessToken);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"
    };
    return headers;
  }

  //
  Map<String, String> getHeadersForVisitor() {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    return headers;
  }
}
