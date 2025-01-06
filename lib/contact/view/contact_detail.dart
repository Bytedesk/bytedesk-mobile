/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-13 07:18:20
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-14 22:31:19
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
import 'package:im/chat/other_bloc/bloc.dart';
import 'package:im/contact/model/contact.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import '../../chat/mqtt/events.dart';
import '../../chat/util/chat_consts.dart';
import '../../chat/view/chat_provider.dart';
import '../../thread/model/thread_json.dart';
import '../bloc/bloc.dart';

class ContactDetail extends StatefulWidget {
  final Contact? contact;
  const ContactDetail({super.key, this.contact});

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('i18n.contact.detail'.tr),
        ),
        body: MultiBlocListener(
            listeners: [
              BlocListener<ContactBloc, ContactState>(
                  listener: (context, state) {
                debugPrint('ContactBloc: $state');
                //
              }),
              BlocListener<OtherBloc, OtherState>(listener: (context, state) {
                debugPrint('OtherBloc: $state');
                //
                if (state is OtherInProgress) {
                  EasyLoading.show();
                } else if (state is CreateMemberThreadSuccess) {
                  ThreadJson threadJson = state.threadJson;
                  debugPrint('CreateMemberThreadSuccess: $threadJson');
                  EasyLoading.dismiss();
                  // Get.toNamed('/chat/${threadJson.data?.id}');
                  bytedeskEventBus
                      .fire(ReceiveThreadEventBus(threadJson.data!));
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return ChatProvider(
                        thread: threadJson.data,
                      );
                    },
                  ));
                  //
                } else if (state is OtherFailure) {
                  EasyLoading.showError(state.error.toString());
                }
              })
            ],
            child: MyScrollView(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
              children: [
                ListTile(
                  title: Text('i18n.contact.nickname'.tr),
                  trailing: Text(widget.contact!.nickname!),
                ),
                ListTile(
                  title: Text('i18n.contact.description'.tr),
                  trailing: Text(widget.contact!.description!.tr),
                ),
                ListTile(
                  title: Text('i18n.contact.job.no'.tr),
                  trailing: Text(widget.contact!.jobNo!),
                ),
                ListTile(
                  title: Text('i18n.contact.job.title'.tr),
                  trailing: Text(widget.contact!.jobTitle!),
                ),
                ListTile(
                  title: Text('i18n.contact.email'.tr),
                  trailing: Text(widget.contact!.email!),
                ),
                ListTile(
                  title: Text('i18n.contact.telephone'.tr),
                  trailing: Text(widget.contact!.telephone!),
                ),
                Gaps.vGap10,
                MyButton(
                    onPressed: () {
                      String? memberSelfUid =
                          SpUtil.getString(ChatConsts.memberSelfUid);
                      // EasyLoading.showInfo('chat');
                      BlocProvider.of<OtherBloc>(context).add(
                          CreateMemberThreadEvent(
                              memberSelfUid: memberSelfUid!,
                              member: widget.contact!));
                    },
                    text: 'i18n.contact.start.chat'.tr)
              ],
            )));
  }
}
