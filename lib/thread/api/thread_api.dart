/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 08:50:51
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-09-14 09:23:04
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
import 'package:im/thread/model/thread_json.dart';
import 'package:sp_util/sp_util.dart';

import '../../chat/util/chat_consts.dart';
import '../../chat/util/base_api.dart';
import '../../chat/util/chat_utils.dart';
import '../../contact/model/contact.dart';
import '../../robot/model/robot.dart';
import '../model/thread.dart';
import '../model/thread_data.dart';

class ThreadHttpApi extends BaseHttpApi {
  ///
  /// http://localhost:8000/visitors/api/v1/query/threadqa?uid=1178211962621440&type=&page=0&size=10
  Future<ThreadData> queryThread(int? page, int? size) async {
    String? accessToken = SpUtil.getString(ChatConsts.accessToken);
    if (accessToken?.isEmpty ?? true) {
      debugPrint('accessToken is empty, query thread return');
      return ThreadData.init();
    }
    //
    final queryThreadUrl = ChatUtils.getHostUri('/api/v1/thread/query', {
      'pageNumber': page.toString(),
      'pageSize': size.toString(),
      'client': client
    });
    final initResponse =
        await httpClient.get(queryThreadUrl, headers: getHeaders());
    //解决json解析中的乱码问题
    Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
    //将string类型数据 转换为json类型的数据
    final responseJson =
        json.decode(utf8decoder.convert(initResponse.bodyBytes));
    // debugPrint("$queryThreadUrl, queryThread:$responseJson");
    //
    ThreadData threadData = ThreadData.fromJson(responseJson['data']);

    return threadData;
  }

  ///
  Future<ThreadData> searchThread(int? page, int? size, String? content) async {
    //
    final queryThreadUrl = ChatUtils.getHostUri('/api/v1/thread/search', {
      'pageNumber': page.toString(),
      'pageSize': size.toString(),
      'content': content,
      'client': client
    });
    final initResponse =
        await httpClient.get(queryThreadUrl, headers: getHeaders());
    //解决json解析中的乱码问题
    Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
    //将string类型数据 转换为json类型的数据
    final responseJson =
        json.decode(utf8decoder.convert(initResponse.bodyBytes));
    // debugPrint("searchThreadList:$responseJson");
    //
    return ThreadData.fromJson(responseJson['data']);
  }

  //
  Future<ThreadJson> createMemberThread(
      String memberSelfUid, Contact member) async {
    //
    var createThreadUrl = ChatUtils.getHostUri('/api/v1/thread/create');
    var body = json.encode({
      "user": {
        "uid": member.user?.uid,
        "nickname": member.nickname,
        "avatar": member.avatar,
      },
      "topic":
          "${ChatConsts.TOPIC_ORG_MEMBER_PREFIX}$memberSelfUid/${member.uid!}",
      "content": "",
      "type": ChatConsts.THREAD_TYPE_MEMBER,
      "extra": "",
      "client": client
    });
    final response = await httpClient.post(createThreadUrl,
        headers: getHeaders(), body: body);
    //
    final createMemberThread = jsonDecode(response.body);
    // debugPrint('createMemberThread:$createMemberThread');
    //
    return ThreadJson.fromJson(createMemberThread);
  }

  Future<ThreadJson> createRobotThread(
      String currentUserUid, Robot robot) async {
    //
    var createThreadUrl = ChatUtils.getHostUri('/api/v1/thread/create');
    var body = json.encode({
      "user": {
        "uid": robot.uid,
        "nickname": robot.nickname,
        "avatar": robot.avatar,
        "type": ChatConsts.USER_TYPE_USER,
      },
      "topic":
          "${ChatConsts.TOPIC_ORG_ROBOT_PREFIX}${robot.uid!}/$currentUserUid",
      "content": "",
      "type": ChatConsts.THREAD_TYPE_LLM,
      "extra": "",
      "client": client
    });
    final response = await httpClient.post(createThreadUrl,
        headers: getHeaders(), body: body);
    //
    final createRobotThread = jsonDecode(response.body);
    // debugPrint('createRobotThread:$createRobotThread');
    //
    return ThreadJson.fromJson(createRobotThread);
  }

  //
  Future<ThreadJson> updateThreadUnreadCount(Thread thread) async {
    //
    if (thread.unreadCount == 0) {
      debugPrint('updateThreadUnreadCount:unreadCount == 0');
      return ThreadJson.init();
    }
    //
    var createThreadUrl = ChatUtils.getHostUri('/api/v1/thread/update');
    var body = json.encode({
      "uid": thread.uid,
      "top": thread.top,
      "unread": thread.unread,
      "unreadCount": 0,
      "mute": thread.mute,
      "star": thread.star,
      "folded": thread.folded,
      "client": client
    });
    final response = await httpClient.post(createThreadUrl,
        headers: getHeaders(), body: body);
    //
    final updateThreadResponse = jsonDecode(response.body);
    // debugPrint('updateThreadUnreadCount:$updateThreadResponse');
    //
    return ThreadJson.fromJson(updateThreadResponse);
  }
}
