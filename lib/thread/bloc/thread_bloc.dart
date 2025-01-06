/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 08:50:51
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-14 11:14:10
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

import '../api/thread_repository.dart';
import '../model/thread_data.dart';
import 'thread_event.dart';
import 'thread_state.dart';

class ThreadBloc extends HydratedBloc<ThreadEvent, ThreadState> {
  //
  final ThreadRepository _threadRepository;

  ThreadBloc(this._threadRepository)
      : super(ThreadState(threadData: ThreadData.init())) {
    on<GetThreadEvent>(_mapGetThreadEventToState);
  }

  void _mapGetThreadEventToState(
      GetThreadEvent event, Emitter<ThreadState> emit) async {
    emit(state.copyWith(status: ThreadStatus.loading));
    try {
      final ThreadData threadData =
          await _threadRepository.queryThread(event.page, event.size!);
      emit(
          state.copyWith(status: ThreadStatus.success, threadData: threadData));
    } catch (error) {
      debugPrint("$error");
      emit(state.copyWith(status: ThreadStatus.failure));
    }
  }

  @override
  ThreadState? fromJson(Map<String, dynamic> json) {
    // debugPrint("TikuState fromJson $json");
    return ThreadState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ThreadState state) {
    // debugPrint("TikuState toJson ${state.toJson()}");
    return state.toJson();
  }
}
