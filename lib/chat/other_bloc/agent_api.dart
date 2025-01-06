/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-14 06:31:52
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-15 13:49:11
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
import 'package:im/chat/other_bloc/agentJson.dart';
import 'package:sp_util/sp_util.dart';

import '../util/base_api.dart';
import '../util/chat_consts.dart';
import '../util/chat_utils.dart';

class BytedeskAgentHttpApi extends BaseHttpApi {
  //
  Future<AgentJson> queryAgent() async {
    debugPrint("queryAgent");
    //
    String? orgUid = SpUtil.getString(ChatConsts.orgUid);
    if (orgUid == null) {
      debugPrint("queryAgent:orgUid is null");
      return AgentJson.init();
    }
    //
    String? agentInfo = SpUtil.getString(ChatConsts.agentInfo);
    if (agentInfo?.isNotEmpty ?? false) {
      debugPrint("local queryAgent:${agentInfo!}");
      return AgentJson.fromJson(jsonDecode(agentInfo));
    }
    //
    final queryAgentUrl = ChatUtils.getHostUri(
        '/api/v1/agent/query', {'orgUid': orgUid, 'client': client});
    final initResponse =
        await httpClient.get(queryAgentUrl, headers: getHeaders());
    //解决json解析中的乱码问题
    Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
    //将string类型数据 转换为json类型的数据
    final responseJson =
        json.decode(utf8decoder.convert(initResponse.bodyBytes));
    debugPrint("$queryAgentUrl, queryAgent:$responseJson");
    //
    AgentJson agentJson = AgentJson.fromJson(responseJson);
    if (agentJson.code == 200) {
      SpUtil.putString(ChatConsts.agentInfo, jsonEncode(agentJson.toJson()));
    }
    return agentJson;
  }
}
