/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2023-08-01 14:26:10
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-14 22:20:44
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:im/chat/model/user_protobuf.dart';
import 'package:im/chat/other_bloc/agentJson.dart';
import 'package:sp_util/sp_util.dart';
import '../../chat/protobuf/message.pb.dart' as protomsg;
import '../util/chat_consts.dart';

class Message extends Equatable {
  //
  final String? uid;
  final String? type;
  final String? content;
  final String? status;
  final String? createdAt;
  final String? client;
  final String? extra;
  //
  final String? threadTopic;
  final UserProtobuf? user;
  //
  const Message({
    this.uid,
    this.type,
    this.content,
    this.status,
    this.createdAt,
    this.client,
    this.extra,
    //
    this.threadTopic,
    this.user,
  }) : super();

  static Message fromMessage(Message message, String status) {
    return Message(
      uid: message.uid,
      type: message.type,
      content: message.content,
      status: status,
      createdAt: message.createdAt,
      client: message.client,
      extra: message.extra,
      //
      threadTopic: message.threadTopic,
      user: message.user,
    );
  }

  //
  static Message fromJson(dynamic json) {
    return Message(
      uid: json['uid'],
      type: json['type'],
      content: json['content'],
      status: json['status'],
      createdAt: json['createdAt'],
      client: json['client'],
      extra: json['extra'],
      //
      threadTopic: json['threadTopic'],
      user: json['user'] != null ? UserProtobuf.fromJson(json['user']) : null,
    );
  }

  //
  static Message fromProto(protomsg.Message messageProto) {
    return Message(
      uid: messageProto.uid,
      type: messageProto.type,
      content: messageProto.content,
      // status: messageProto.status,
      status: ChatConsts.MESSAGE_STATUS_SUCCESS,
      createdAt: messageProto.createdAt,
      client: messageProto.client,
      extra: messageProto.extra,
      //
      threadTopic: messageProto.thread.topic,
      user: UserProtobuf.fromProto(messageProto),
    );
  }

  //
  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'type': type,
        'content': content,
        'status': status,
        'createdAt': createdAt,
        'client': client,
        'extra': extra,
        //
        'threadTopic': threadTopic,
        //
        'user': user?.toJson(),
      };

  //
  Map<String, dynamic> toMap(String currentUid) => <String, dynamic>{
        'uid': uid,
        'type': type,
        'content': content,
        'status': status,
        'createdAt': createdAt,
        'client': client,
        'extra': extra,
        //
        'threadTopic': threadTopic,
        //
        'userUid': user?.uid,
        'userNickname': user?.nickname,
        'userAvatar': user?.avatar,
        //
        'currentUid': currentUid
      };

  //
  static Message init() {
    return Message(
      uid: '',
      type: '',
      content: '',
      status: '',
      createdAt: '',
      client: '',
      extra: '',
      //
      threadTopic: '',
      user: UserProtobuf.init(),
    );
  }

  bool isSend() {
    String? currentUid = SpUtil.getString(ChatConsts.uid);
    if (currentUid == user?.uid) {
      return true;
    }
    String? agentInfo = SpUtil.getString(ChatConsts.agentInfo);
    if (agentInfo?.isNotEmpty ?? false) {
      AgentJson agentJson = AgentJson.fromJson(jsonDecode(agentInfo!));
      if (agentJson.data?.uid == user?.uid) {
        return true;
      }
    }
    return false;
  }

  //
  @override
  List<Object> get props => [uid!];
}
