/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 17:02:55
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-10-05 10:26:04
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'package:bytedesk_kefu/model/jsonResult.dart';
import 'package:equatable/equatable.dart';
import 'package:im/common/auth/model/scan_json.dart';
import 'package:meta/meta.dart';

import '../model/auth_json.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  @override
  String toString() => 'AuthInitial';
}

class AuthInProgress extends AuthState {
  @override
  String toString() => 'AuthInProgress';
}

class AuthSuccess extends AuthState {
  final AuthJson auth;

  const AuthSuccess({required this.auth});

  @override
  String toString() => 'AuthSuccess';
}

class AuthError extends AuthState {
  final AuthJson auth;

  const AuthError({required this.auth});

  @override
  String toString() => 'AuthError';
}

class AuthFailure extends AuthState {
  final String? error;

  const AuthFailure({@required this.error});

  @override
  List<Object> get props => [error!];

  @override
  String toString() => 'AuthFailure { error: $error }';
}

/////////////////////////////////////////////////
///
class RequestCodeInProgress extends AuthState {
  @override
  String toString() => 'RequestCodeInProgress';
}

class RequestCodeSuccess extends AuthState {
  final JsonResult jsonResult;
  const RequestCodeSuccess({required this.jsonResult}) : super();
  @override
  String toString() => 'RequestCodeSuccess';
}

class RequestCodeError extends AuthState {
  final String? message;
  final int? statusCode;
  const RequestCodeError({@required this.message, @required this.statusCode});
  @override
  String toString() => 'RequestCodeError { error: $message }';
}

/////////////////////////////////////////////////
///
class ScanInProgress extends AuthState {
  @override
  String toString() => 'ScanInProgress';
}

class ScanSuccess extends AuthState {
  final ScanJson scanJson;
  const ScanSuccess({required this.scanJson}) : super();
  @override
  String toString() => 'ScanSuccess';
}

class ScanError extends AuthState {
  final ScanJson scanJson;
  const ScanError({required this.scanJson});
  @override
  String toString() => 'ScanError { error: $scanJson }';
}

/////////////////////////////////////////////////
///
class ScanConfirmInProgress extends AuthState {
  @override
  String toString() => 'ScanConfirmInProgress';
}

class ScanConfirmSuccess extends AuthState {
  final ScanJson scanJson;
  const ScanConfirmSuccess({required this.scanJson}) : super();
  @override
  String toString() => 'ScanConfirmSuccess';
}

class ScanConfirmError extends AuthState {
  final ScanJson scanJson;
  const ScanConfirmError({required this.scanJson});
  @override
  String toString() => 'ScanConfirmError { error: $scanJson }';
}
