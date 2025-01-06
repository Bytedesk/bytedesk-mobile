/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 06:55:35
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-14 08:12:48
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'package:equatable/equatable.dart';
import 'package:im/chat/other_bloc/agent.dart';

class AgentJson extends Equatable {
  final String? message;
  final int? code;
  final Agent? data;

  const AgentJson({this.message, this.code, this.data}) : super();

  static AgentJson fromJson(dynamic json) {
    return AgentJson(
        message: json["message"],
        code: json["code"],
        data: Agent.fromJson(json['data']));
  }

  //
  Map<String, dynamic> toJson() => <String, dynamic>{
        'message': message,
        'code': code,
        'data': data?.toJson(),
      };

  static AgentJson init() {
    Agent agent = Agent.init();
    return AgentJson(message: "", code: 0, data: agent);
  }

  @override
  List<Object> get props => [];
}
