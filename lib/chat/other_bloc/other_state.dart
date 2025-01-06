/*
 * @Otheror: jackning 270580156@qq.com
 * @Date: 2024-08-12 17:02:55
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-21 21:07:59
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
import 'package:im/chat/model/upload_jsonResult.dart';
import 'package:im/chat/other_bloc/agentJson.dart';
import 'package:meta/meta.dart';

import '../../thread/model/thread_json.dart';

abstract class OtherState extends Equatable {
  const OtherState();

  @override
  List<Object> get props => [];
}

class OtherInitial extends OtherState {
  @override
  String toString() => 'OtherInitial';
}

class OtherInProgress extends OtherState {
  @override
  String toString() => 'OtherInProgress';
}

class UploadingProgress extends OtherState {
  @override
  String toString() => 'UploadingProgress';
}

class UploadSuccess extends OtherState {
  final UploadJsonResult upload;
  const UploadSuccess({required this.upload});
  @override
  String toString() => 'UploadSuccess';
}

class QueryAgentSuccess extends OtherState {
  final AgentJson agentJson;
  const QueryAgentSuccess({required this.agentJson});
  @override
  String toString() => 'QueryAgentSuccess';
}

class CreateMemberThreadSuccess extends OtherState {
  final ThreadJson threadJson;
  const CreateMemberThreadSuccess({required this.threadJson});
  @override
  String toString() => 'CreateMemberThreadSuccess';
}

class CreateRobotThreadSuccess extends OtherState {
  final ThreadJson threadJson;
  const CreateRobotThreadSuccess({required this.threadJson});
  @override
  String toString() => 'CreateRobotThreadSuccess';
}

class UpdateThreadUnreadCountSuccess extends OtherState {
  final ThreadJson threadJson;
  const UpdateThreadUnreadCountSuccess({required this.threadJson});
  @override
  String toString() => 'UpdateThreadUnreadCountSuccess';
}

class OtherFailure extends OtherState {
  final String? error;
  const OtherFailure({@required this.error});
  @override
  List<Object> get props => [error!];
  @override
  String toString() => 'OtherFailure { error: $error }';
}
