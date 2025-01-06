/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 14:40:57
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-11-28 23:10:21
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
import 'package:im/chat/util/chat_consts.dart';
import 'package:sp_util/sp_util.dart';

import '../../chat/util/base_api.dart';
import '../../chat/util/chat_utils.dart';
import '../model/robotData.dart';

class RobotHttpApi extends BaseHttpApi {
  ///
  /// http://localhost:8000/visitors/api/v1/query/robotqa?uid=1178211962621440&type=&page=0&size=10
  Future<RobotData> queryRobot(int? page, int? size,) async {
    String? orgUid = SpUtil.getString(ChatConsts.orgUid);
    debugPrint("queryRobot:$orgUid");
    //
    final queryRobotUrl = ChatUtils.getHostUri('/api/v1/robot/query/org', {
      'pageNumber': page.toString(),
      'pageSize': size.toString(),
      'type': ChatConsts.ROBOT_TYPE_LLM,
      'orgUid': orgUid,
      'client': client,
      'level': ChatConsts.LEVEL_TYPE_ORGNIZATION
    });
    final initResponse =
        await httpClient.get(queryRobotUrl, headers: getHeaders());
    //解决json解析中的乱码问题
    Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
    //将string类型数据 转换为json类型的数据
    final responseJson =
        json.decode(utf8decoder.convert(initResponse.bodyBytes));
    debugPrint("$queryRobotUrl, queryRobot:$responseJson");
    //
    return RobotData.fromJson(responseJson['data']);
  }

  ///
  Future<RobotData> searchRobot(int? page, int? size, String? content) async {
    //
    final searchRobotUrl = ChatUtils.getHostUri('/api/v1/robot/search', {
      'pageNumber': page.toString(),
      'pageSize': size.toString(),
      'content': content,
      'client': client
    });
    final initResponse =
        await httpClient.get(searchRobotUrl, headers: getHeaders());
    //解决json解析中的乱码问题
    Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
    //将string类型数据 转换为json类型的数据
    final responseJson =
        json.decode(utf8decoder.convert(initResponse.bodyBytes));
    // debugPrint("searchThreadList:$responseJson");
    //
    return RobotData.fromJson(responseJson['data']);
  }
}
