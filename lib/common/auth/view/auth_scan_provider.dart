/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 07:24:58
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2025-01-06 16:12:00
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
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import 'auth_scan_page.dart';

class AuthScanProvider extends StatelessWidget {
  final String mobile;
  final String deviceUid;
  final String code;
  //
  const AuthScanProvider({
    super.key,
    required this.mobile,
    required this.deviceUid,
    required this.code,
  });
  //
  @override
  Widget build(BuildContext context) {
    //
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              AuthBloc()..add(ScanEvent(deviceUid: deviceUid, code: code)),
        ),
      ],
      child: AuthScanPage(mobile: mobile, deviceUid: deviceUid, code: code),
    );
  }
}
