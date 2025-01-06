/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2022-03-10 14:55:08
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-09-09 18:19:58
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
import 'package:bytedesk_kefu/model/jsonResult.dart';
import 'package:flutter/foundation.dart';
import 'package:im/common/auth/model/scan_json.dart';

import '../model/auth_json.dart';
import '../api/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  //
  final AuthRepository _authRepository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<AuthButtonPressed>(_mapAuthState);
    on<RequestCodeButtonPressed>(_mapRequestCodeState);
    on<ScanEvent>(_mapScanState);
    on<ScanConfirmEvent>(_mapScanConfirmState);
  }

  void _mapRequestCodeState(
      RequestCodeButtonPressed event, Emitter<AuthState> emit) async {
    emit(RequestCodeInProgress());
    try {
      //
      JsonResult result = await _authRepository.sendMobileCode(
          event.mobile, event.type, event.platform);
      if (result.code == 200) {
        emit(RequestCodeSuccess(jsonResult: result));
      } else {
        emit(
            RequestCodeError(message: result.message, statusCode: result.code));
      }
    } catch (error) {
      // 网络或其他错误
      emit(RequestCodeError(message: error.toString(), statusCode: -1));
    }
  }

  void _mapAuthState(AuthButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthInProgress());
    try {
      AuthJson auth = await _authRepository.loginMobile(
          event.mobile, event.code, event.platform);
      debugPrint('_mapAuthState AuthBloc: ${auth.toJson()}');
      if (auth.code == 200) {
        emit(AuthSuccess(auth: auth)); // 登录成功
      } else {
        emit(AuthError(auth: auth)); // 登录失败
      }
    } catch (error) {
      // 网络或其他错误
      emit(AuthFailure(error: error.toString()));
    }
  }

  void _mapScanState(ScanEvent event, Emitter<AuthState> emit) async {
    emit(ScanInProgress());
    try {
      ScanJson scanJson = await _authRepository.scan(event.deviceUid, event.code);
      debugPrint('_mapScanState AuthBloc: ${scanJson.toJson()}');
      if (scanJson.code == 200) {
        emit(ScanSuccess(scanJson: scanJson));
      } else {
        emit(ScanError(scanJson: scanJson));
      }
    } catch (error) {
      // 网络或其他错误
      emit(AuthFailure(error: error.toString()));
    }
  }

  void _mapScanConfirmState(ScanConfirmEvent event, Emitter<AuthState> emit) async {
    emit(ScanConfirmInProgress());
    try {
      ScanJson scanJson =
          await _authRepository.scanConfirm(event.mobile, event.deviceUid, event.code);
      debugPrint('_mapScanConfirmState AuthBloc: ${scanJson.toJson()}');
      if (scanJson.code == 200) {
        emit(ScanConfirmSuccess(scanJson: scanJson));
      } else {
        emit(ScanConfirmError(scanJson: scanJson));
      }
    } catch (error) {
      // 网络或其他错误
      emit(AuthFailure(error: error.toString()));
    }
  }

}
