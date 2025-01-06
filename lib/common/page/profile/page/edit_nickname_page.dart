import 'package:bytedesk_common/blocs/profile_bloc/bloc.dart';
import 'package:bytedesk_common/util/toast.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../chat/util/chat_consts.dart';

class EditNicknamePage extends StatefulWidget {
  const EditNicknamePage({super.key});

  @override
  State<EditNicknamePage> createState() => _EditNicknamePageState();
}

class _EditNicknamePageState extends State<EditNicknamePage>
    with AutomaticKeepAliveClientMixin<EditNicknamePage> {
  //
  final TextEditingController _mEtController = TextEditingController();
  var nickname = SpUtil.getString(ChatConsts.nickname);
  //
  @override
  void initState() {
    super.initState();
    _mEtController.text = nickname!;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //
    return Scaffold(
        appBar: AppBar(
          title: Text('i18n.profile.edit.nickname'.tr),
        ),
        body:
            BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
          //
          if (state is UpdateNicknameSuccess) {
            Toast.show('i18n.profile.nickname.success'.tr);
            Navigator.pop(context, SpUtil.getString(ChatConsts.nickname));
          }
        }, builder: (context, state) {
          return Container(
              color: const Color(0xffF3F1F4),
              child: Column(
                children: <Widget>[
                  Container(
                      height: 50,
                      color: const Color(0xffffffff),
                      margin: const EdgeInsets.only(top: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          controller: _mEtController,
                          decoration: InputDecoration(
                            hintText: "i18n.profile.nickname.hint".tr,
                            hintStyle: const TextStyle(
                                color: Color(0xff999999), fontSize: 16),
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 15),
                            border: InputBorder.none,
                          ),
                        ),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        child: Text(
                          "i18n.profile.nickname.rule".tr,
                          style: const TextStyle(
                              fontSize: 14.0, color: Color(0xff999999)),
                        ),
                      )),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 60.0, left: 20, right: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_mEtController.text.isEmpty) {
                            Toast.show('i18n.profile.nickname.empty'.tr);
                            return;
                          }
                          //
                          SpUtil.putString(
                              ChatConsts.nickname, _mEtController.text);
                          BlocProvider.of<ProfileBloc>(context).add(
                              UpdateNicknameEvent(
                                  nickname: _mEtController.text));
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                          child: Text(
                            "i18n.profile.save".tr,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ));
        }));
  }

  @override
  bool get wantKeepAlive => true;
}
