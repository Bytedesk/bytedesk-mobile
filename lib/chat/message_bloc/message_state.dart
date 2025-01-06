/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 08:50:51
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-13 17:44:42
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

import '../model/message_data.dart';

enum MessageStatus { initial, loading, success, failure }

extension MessageStatusX on MessageStatus {
  bool get isInitial => this == MessageStatus.initial;
  bool get isLoading => this == MessageStatus.loading;
  bool get isSuccess => this == MessageStatus.success;
  bool get isFailure => this == MessageStatus.failure;
}

final class MessageState extends Equatable {
  final MessageStatus status;
  final MessageData? messageData;

  const MessageState({this.status = MessageStatus.initial, this.messageData});

  MessageState copyWith(
      {MessageStatus? status, String? type, MessageData? messageData}) {
    return MessageState(
        status: status ?? this.status,
        messageData: messageData ?? this.messageData);
  }

  factory MessageState.fromJson(Map<String, dynamic> json) => MessageState(
      status: _$MessageStatusEnumMap[json['status']]!,
      messageData: MessageData.fromJson(json['messageData']));

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status.index,
        'messageData': messageData!.toJson()
      };

  @override
  List<Object> get props => [status, messageData!];
}

const _$MessageStatusEnumMap = {
  0: MessageStatus.initial,
  1: MessageStatus.loading,
  2: MessageStatus.success,
  3: MessageStatus.failure,
};
