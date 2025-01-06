/*
 * @Otheror: jackning 270580156@qq.com
 * @Date: 2022-03-10 14:55:08
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-21 21:07:46
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  技术/商务联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'package:bloc/bloc.dart';
import 'package:im/chat/model/upload_jsonResult.dart';
import 'package:im/chat/other_bloc/agentJson.dart';

import '../../thread/model/thread_json.dart';
import 'other_event.dart';
import 'other_repository.dart';
import 'other_state.dart';

class OtherBloc extends Bloc<OtherEvent, OtherState> {
  //
  final OtherRepository _otherRepository = OtherRepository();

  OtherBloc() : super(OtherInitial()) {
    // on<UploadEvent>(_mapUploadEventState);
    on<UploadAssetEntityEvent>(_mapUploadAssetEntityEventState);
    on<QueryAgentEvent>(_mapQueryAgentEventState);
    on<CreateMemberThreadEvent>(_mapCreateMemberThreadEventState);
    on<CreateRobotThreadEvent>(_mapCreateRobotThreadEventState);
    on<UpdateThreadUnreadCountEvent>(_mapUpdateThreadUnreadCountEventState);
  }

  // void _mapUploadEventState(UploadEvent event, Emitter<OtherState> emit) async {
  //   emit(UploadingProgress());
  //   try {
  //     JsonResult result = await _otherRepository.uploadFile(event.filePath);
  //     emit(UploadSuccess(upload: result));
  //   } catch (error) {
  //     // 网络或其他错误
  //     emit(OtherFailure(error: error.toString()));
  //   }
  // }

  void _mapUploadAssetEntityEventState(
      UploadAssetEntityEvent event, Emitter<OtherState> emit) async {
    emit(UploadingProgress());
    try {
      UploadJsonResult result = await _otherRepository.uploadAssetEntity(event.entity);
      emit(UploadSuccess(upload: result));
    } catch (error) {
      // 网络或其他错误
      emit(OtherFailure(error: error.toString()));
    }
  }

  void _mapQueryAgentEventState(
      QueryAgentEvent event, Emitter<OtherState> emit) async {
    emit(OtherInProgress());
    try {
      AgentJson result = await _otherRepository.queryAgent();
      emit(QueryAgentSuccess(agentJson: result));
    } catch (error) {
      // 网络或其他错误
      emit(OtherFailure(error: error.toString()));
    }
  }

  void _mapCreateMemberThreadEventState(
      CreateMemberThreadEvent event, Emitter<OtherState> emit) async {
    emit(OtherInProgress());
    try {
      ThreadJson result = await _otherRepository.createMemberThread(
          event.memberSelfUid, event.member);
      emit(CreateMemberThreadSuccess(threadJson: result));
    } catch (error) {
      // 网络或其他错误
      emit(OtherFailure(error: error.toString()));
    }
  }

  void _mapCreateRobotThreadEventState(
      CreateRobotThreadEvent event, Emitter<OtherState> emit) async {
    emit(OtherInProgress());
    try {
      ThreadJson result = await _otherRepository.createRobotThread(
          event.currentUserUid, event.robot);
      emit(CreateRobotThreadSuccess(threadJson: result));
    } catch (error) {
      // 网络或其他错误
      emit(OtherFailure(error: error.toString()));
    }
  }

  void _mapUpdateThreadUnreadCountEventState(
      UpdateThreadUnreadCountEvent event, Emitter<OtherState> emit) async {
    emit(OtherInProgress());
    try {
      ThreadJson result = await _otherRepository.updateThreadUnreadCount(event.thread);
      emit(UpdateThreadUnreadCountSuccess(threadJson: result));
    } catch (error) {
      // 网络或其他错误
      emit(OtherFailure(error: error.toString()));
    }
  }

  
}
