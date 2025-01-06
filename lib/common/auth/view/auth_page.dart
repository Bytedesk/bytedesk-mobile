import 'package:bytedesk_common/res/color_consts.dart';
import 'package:bytedesk_kefu/model/jsonResult.dart';
import 'package:bytedesk_common/res/gaps.dart';
import 'package:bytedesk_kefu/ui/widget/my_button.dart';
import 'package:bytedesk_common/util/change_notifier_manage.dart';
import 'package:bytedesk_common/util/utils.dart';
import 'package:bytedesk_common/widgets/my_scroll_view.dart';
import 'package:bytedesk_common/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../chat/mqtt/bytedesk_mqtt.dart';
import '../../../chat/util/chat_consts.dart';
import '../bloc/bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.title});

  final String title;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with ChangeNotifierMixin<AuthPage> {
  //
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  //
  bool _clickable = false;
  bool _isChecked = false;
  String _mobile = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // 隐藏返回按钮
          title: Text(widget.title),
          actions: [
            Visibility(
              visible: ChatConsts.isDebug,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TextButton(
                  child: Text('Local'.tr),
                  onPressed: () {
                    debugPrint('i18n.auth.local.network'.tr);
                    EasyLoading.showToast('i18n.auth.local.network.todo'.tr);
                  },
                ),
              ),
            )
          ],
          elevation: 0,
        ),
        body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          // do stuff here based on BlocA's state
          debugPrint("AuthBloc: ${state.runtimeType}");
          if (state is RequestCodeSuccess) {
            JsonResult result = state.jsonResult;
            EasyLoading.showToast(result.message!);
          } else if (state is RequestCodeError) {
            EasyLoading.showToast(state.message!);
          } else if (state is AuthInProgress) {
            EasyLoading.showToast('i18n.auth.logging.in'.tr);
          } else if (state is AuthError || state is AuthFailure) {
            // 用户名密码错误，登录失败
            EasyLoading.showToast("i18n.auth.login.failed".tr);
          } else if ((state is AuthSuccess)) {
            EasyLoading.dismiss();
            // 初始化客服
            BytedeskMqtt().connect();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
          }
          //
          return MyScrollView(
            keyboardConfig: Utils.getKeyboardActionsConfig(
                context, <FocusNode>[_nodeText1, _nodeText2]),
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
            children: _buildBody(),
          );
        }));
  }

  //
  Future<void> _login() async {
    if (!_isChecked) {
      EasyLoading.showToast('i18n.auth.agree.policy'.tr);
      return;
    }
    _mobile = _phoneController.text;
    String code = _codeController.text;
    // 登录
    BlocProvider.of<AuthBloc>(context).add(
      AuthButtonPressed(
          mobile: _mobile, code: code, platform: ChatConsts.platform),
    );
  }

  //
  List<Widget> _buildBody() {
    return <Widget>[
      MyTextField(
        focusNode: _nodeText1,
        controller: _phoneController,
        maxLength: 11,
        keyboardType: TextInputType.phone,
        hintText: "i18n.auth.mobile".tr,
      ),
      Gaps.vGap8,
      MyTextField(
        focusNode: _nodeText2,
        controller: _codeController,
        maxLength: 6,
        keyboardType: TextInputType.number,
        hintText: "i18n.auth.code".tr,
        getVCode: () async {
          if (_phoneController.text.length == 11) {
            // 验证手机号是否有效
            BlocProvider.of<AuthBloc>(context).add(
              RequestCodeButtonPressed(
                  mobile: _phoneController.text,
                  type: ChatConsts.AUTH_TYPE_MOBILE_LOGIN,
                  platform: ChatConsts.platform),
            );
            return true;
          } else {
            EasyLoading.showError("i18n.auth.mobile.invalid".tr);
            return false;
          }
        },
      ),
      Gaps.vGap5,
      Text(
        'i18n.auth.auto.register'.tr,
        style: const TextStyle(fontSize: 12, color: ColorConsts.text_gray),
      ),
      // Gaps.vGap24,
      _buildPrivacyWidget(),
      MyButton(
        onPressed: _clickable ? _login : null,
        text: "i18n.auth.login".tr,
      ),
    ];
  }

  Widget _buildPrivacyWidget() {
    return Row(
      children: [
        // Expanded(child: Container()),
        Checkbox(
            value: _isChecked,
            onChanged: (value) {
              setState(() {
                _isChecked = value!;
              });
            }),
        InkWell(
          child: Text(
            "i18n.auth.user.agreement".tr,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue),
          ),
          onTap: () {
            final Uri toLaunch = Uri(
                scheme: 'https',
                host: ChatConsts.website,
                path: '/protocol.html');
            Utils.launchInBrowser(toLaunch);
          },
        ),
        Text(
          "i18n.auth.and".tr,
          textAlign: TextAlign.center,
        ),
        InkWell(
          child: Text(
            "i18n.auth.privacy.policy".tr,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue),
          ),
          onTap: () {
            final Uri toLaunch = Uri(
                scheme: 'https',
                host: ChatConsts.website,
                path: '/privacy.html');
            Utils.launchInBrowser(toLaunch);
          },
        ),
        // Expanded(child: Container()),
      ],
    );
  }

  @override
  Map<ChangeNotifier, List<VoidCallback>> changeNotifier() {
    final List<VoidCallback> callbacks = [_verify];
    return {
      _phoneController: callbacks,
      _codeController: callbacks,
      // _nodeText1: null,
      // _nodeText2: null,
    };
  }

  void _verify() {
    final String mobile = _phoneController.text;
    final String vCode = _codeController.text;
    bool clickable = true;
    if (mobile.isEmpty || mobile.length != 11) {
      clickable = false;
    }
    if (vCode.isEmpty || vCode.length != 6) {
      clickable = false;
    }
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }
}
