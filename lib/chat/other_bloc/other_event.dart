/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 17:02:55
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-15 10:09:06
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../contact/model/contact.dart';
import '../../robot/model/robot.dart';
import '../../thread/model/thread.dart';

@immutable
abstract class OtherEvent extends Equatable {
  const OtherEvent();

  @override
  List<Object> get props => [];
}

class UploadEvent extends OtherEvent {
  final String filePath;
  const UploadEvent({required this.filePath}) : super();
  @override
  String toString() {
    return 'UploadEvent { filePath: $filePath }';
  }
}

class UploadAssetEntityEvent extends OtherEvent {
  final AssetEntity entity;
  const UploadAssetEntityEvent({required this.entity}) : super();
  @override
  String toString() {
    return 'UploadAssetEntityEvent';
  }
}

class QueryAgentEvent extends OtherEvent {
  const QueryAgentEvent() : super();
  @override
  String toString() {
    return 'QueryAgentEvent';
  }
}

class CreateMemberThreadEvent extends OtherEvent {
  final String memberSelfUid;
  final Contact member;
  const CreateMemberThreadEvent({required this.memberSelfUid, required this.member}) : super();
  @override
  String toString() {
    return 'CreateMemberThreadEvent';
  }
}

class CreateRobotThreadEvent extends OtherEvent {
  final String currentUserUid;
  final Robot robot;
  const CreateRobotThreadEvent({required this.currentUserUid, required this.robot}) : super();
  @override
  String toString() {
    return 'CreateRobotThreadEvent';
  }
}

class UpdateThreadUnreadCountEvent extends OtherEvent {
  final Thread thread;
  const UpdateThreadUnreadCountEvent(
      {required this.thread})
      : super();
  @override
  String toString() {
    return 'UpdateThreadUnreadCountEvent';
  }
}
