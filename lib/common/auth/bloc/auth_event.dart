/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 17:02:55
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-09-09 18:19:46
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

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RequestCodeButtonPressed extends AuthEvent {
  //
  final String mobile;
  final String type;
  final String platform;

  const RequestCodeButtonPressed(
      {required this.mobile, required this.type, required this.platform})
      : super();
  @override
  String toString() {
    return 'RequestCodeButtonPressed { mobile: $mobile, type: $type, platform: $platform }';
  }
}

class AuthButtonPressed extends AuthEvent {
  //
  final String mobile;
  final String code;
  final String platform;

  const AuthButtonPressed(
      {required this.mobile, required this.code, required this.platform})
      : super();

  @override
  String toString() {
    return 'AuthButtonPressed { mobile: $mobile, code: $code, platform: $platform }';
  }
}

class ScanEvent extends AuthEvent {
  //
  final String deviceUid;
  final String code;

  const ScanEvent(
      {required this.deviceUid, required this.code,
  }): super();

  @override
  String toString() {
    return 'ScanEvent { code: $code, platform: $deviceUid }';
  }
}

class ScanConfirmEvent extends AuthEvent {
  //
  final String mobile;
  final String deviceUid;
  final String code;

  const ScanConfirmEvent({
    required this.mobile,
    required this.deviceUid,
    required this.code,
  }) : super();

  @override
  String toString() {
    return 'ScanConfirmEvent { mobile: $mobile, code: $code, platform: $deviceUid }';
  }
}
