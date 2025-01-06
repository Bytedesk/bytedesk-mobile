/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 08:50:51
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-15 17:38:31
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../api/message_repository.dart';
import '../model/message_data.dart';
import 'message_event.dart';
import 'message_state.dart';

class MessageBloc extends HydratedBloc<MessageEvent, MessageState> {
  //
  final MessageRepository _messageRepository = MessageRepository();

  MessageBloc()
      : super(MessageState(messageData: MessageData.init())) {
    on<GetMessageEvent>(_mapGetMessageEventToState);
  }

  void _mapGetMessageEventToState(
      GetMessageEvent event, Emitter<MessageState> emit) async {
    emit(state.copyWith(status: MessageStatus.loading));
    try {
      final MessageData messageData = await _messageRepository.queryMessage(
          event.page, event.size!, event.topic);
      emit(state.copyWith(
          status: MessageStatus.success, messageData: messageData));
    } catch (error) {
      debugPrint("$error");
      emit(state.copyWith(status: MessageStatus.failure));
    }
  }

  @override
  MessageState? fromJson(Map<String, dynamic> json) {
    // debugPrint("TikuState fromJson $json");
    return MessageState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(MessageState state) {
    // debugPrint("TikuState toJson ${state.toJson()}");
    return state.toJson();
  }
}
