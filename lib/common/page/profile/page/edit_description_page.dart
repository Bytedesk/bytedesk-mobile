import 'package:bytedesk_common/blocs/profile_bloc/bloc.dart';
import 'package:bytedesk_common/util/toast.dart';
import 'package:sp_util/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../chat/util/chat_consts.dart';

class EditDescriptionPage extends StatefulWidget {
  const EditDescriptionPage({super.key});

  @override
  State<EditDescriptionPage> createState() => _EditDescriptionPageState();
}

class _EditDescriptionPageState extends State<EditDescriptionPage>
    with AutomaticKeepAliveClientMixin<EditDescriptionPage> {
  //
  final TextEditingController _mEtController = TextEditingController();
  var description = SpUtil.getString(ChatConsts.description);
  //
  @override
  void initState() {
    super.initState();
    _mEtController.text = description!.tr;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //
    return Scaffold(
        appBar: AppBar(
          title: Text('i18n.profile.edit.description'.tr),
        ),
        body:
            BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
          //
          if (state is UpdateDescriptionSuccess) {
            Toast.show('i18n.profile.description.success'.tr);
            Navigator.pop(context, _mEtController.text);
          }
        }, builder: (context, state) {
          return Container(
              color: const Color(0xffF3F1F4),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 1,
                    color: const Color(0xfffefefe),
                  ),
                  Container(
                      constraints: const BoxConstraints(
                        minHeight: 100,
                      ),
                      height: 50,
                      color: const Color(0xffffffff),
                      child: Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: TextField(
                          controller: _mEtController,
                          maxLength: 50,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: "i18n.profile.description.hint".tr,
                            hintStyle: const TextStyle(
                                color: Color(0xff999999), fontSize: 15),
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 15),
                            border: InputBorder.none,
                          ),
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
                            Toast.show('i18n.profile.description.empty'.tr);
                            return;
                          }
                          //
                          BlocProvider.of<ProfileBloc>(context).add(
                              UpdateDescriptionEvent(
                                  description: _mEtController.text));
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
