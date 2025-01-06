/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-09-09 12:42:31
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2025-01-06 16:04:54
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'package:bytedesk_common/res/gaps.dart';
import 'package:bytedesk_kefu/ui/widget/my_button.dart';
import 'package:bytedesk_common/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../bloc/bloc.dart';

class AuthScanPage extends StatefulWidget {
  final String mobile;
  final String deviceUid;
  final String code;
  //
  const AuthScanPage(
      {super.key,
      required this.mobile,
      required this.deviceUid,
      required this.code});

  @override
  State<AuthScanPage> createState() => _AuthScanPageState();
}

class _AuthScanPageState extends State<AuthScanPage> {
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false, // 隐藏返回按钮
          title: Text('i18n.auth.scan.login'.tr),
          elevation: 0,
        ),
        body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          // do stuff here based on BlocA's state
          debugPrint("AuthBloc: ${state.runtimeType}");
          if (state is ScanInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ScanSuccess) {
          } else if (state is ScanError) {
            EasyLoading.showError(state.toString());
          } else if (state is ScanConfirmInProgress) {
            EasyLoading.showToast('i18n.auth.submitting'.tr);
          } else if (state is ScanConfirmSuccess) {
            EasyLoading.dismiss();
            // 确认成功，pop返回上一页
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
          } else if (state is ScanConfirmError) {
            EasyLoading.showError(state.toString());
          } else if (state is AuthFailure) {
            EasyLoading.showError(state.error!);
          }
          //
          return MyScrollView(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
            children: _buildBody(),
          );
        }));
  }

  //
  Future<void> _login() async {
    // 登录
    BlocProvider.of<AuthBloc>(context).add(
      ScanConfirmEvent(
          mobile: widget.mobile,
          deviceUid: widget.deviceUid,
          code: widget.code),
    );
  }

  //
  List<Widget> _buildBody() {
    return <Widget>[
      Gaps.vGap50,
      // const Center(
      //   child: LoadAssetImage(
      //     'logo',
      //     height: 100,
      //     width: 100,
      //   ),
      // ),
      // Text(widget.mobile),
      // Text(widget.deviceUid),
      // Text(widget.code),
      Gaps.vGap5,
      MyButton(
        onPressed: _login,
        text: "i18n.auth.confirm.login".tr,
      ),
    ];
  }
}
