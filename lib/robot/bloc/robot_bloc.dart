/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 14:41:50
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-13 07:06:05
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

import '../api/robot_repository.dart';
import '../model/robotData.dart';
import 'robot_event.dart';
import 'robot_state.dart';

class RobotBloc extends HydratedBloc<RobotEvent, RobotState> {
  //
  final RobotRepository _robotRepository;

  RobotBloc(this._robotRepository)
      : super(RobotState(robotData: RobotData.init())) {
    on<GetRobotEvent>(_mapGetRobotEventToState);
  }

  void _mapGetRobotEventToState(GetRobotEvent event, Emitter<RobotState> emit) async {
    emit(state.copyWith(status: RobotStatus.loading));
    try {
      final RobotData robotData = await _robotRepository.queryRobot(event.page, event.size!);
      emit(state.copyWith(status: RobotStatus.success, robotData: robotData));
    } catch (error) {
      debugPrint(error.toString());
      emit(state.copyWith(status: RobotStatus.failure));
    }
  }

  @override
  RobotState? fromJson(Map<String, dynamic> json) {
    // debugPrint("TikuState fromJson $json");
    return RobotState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(RobotState state) {
    // debugPrint("TikuState toJson ${state.toJson()}");
    return state.toJson();
  }
}
