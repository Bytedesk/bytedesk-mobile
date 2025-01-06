/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-13 07:39:47
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-15 14:07:33
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

import '../model/message_data.dart';
import '../model/message_json.dart';
import '../util/base_api.dart';
import '../util/chat_utils.dart';

class MessageHttpApi extends BaseHttpApi {
  ///
  /// http://localhost:8000/visitors/api/v1/query/threadqa?uid=1178211962621440&type=&page=0&size=10
  Future<MessageData> queryMessage(
      int? page, int? size, String? threadTopic) async {
    //
    final queryMessageUrl =
        ChatUtils.getHostUri('/api/v1/message/query/topic', {
      'pageNumber': page.toString(),
      'pageSize': size.toString(),
      'threadTopic': threadTopic,
      'client': client
    });
    final initResponse =
        await httpClient.get(queryMessageUrl, headers: getHeaders());
    //解决json解析中的乱码问题
    Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
    //将string类型数据 转换为json类型的数据
    final responseJson =
        json.decode(utf8decoder.convert(initResponse.bodyBytes));
    debugPrint("$queryMessageUrl, queryMessage:$responseJson");
    //
    return MessageData.fromJson(responseJson['data']);
  }

  //
  Future<MessageJson> sendRestMessage(String json) async {
    //
    var sendRestMessageUrl = ChatUtils.getHostUri('/api/v1/message/rest/send');
    final response = await httpClient.post(sendRestMessageUrl,
        headers: getHeaders(), body: json);
    //
    final sendRestMessageResponse = jsonDecode(response.body);
    debugPrint('sendRestMessage:$sendRestMessageResponse');
    //
    return MessageJson.fromJson(sendRestMessageResponse);
  }
}
