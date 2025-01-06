/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-13 07:18:51
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-10-05 10:37:24
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
import 'package:sp_util/sp_util.dart';

import '../../chat/mqtt/events.dart';
import '../../chat/other_bloc/bloc.dart';
import '../../chat/util/chat_consts.dart';
import '../../chat/view/chat_provider.dart';
import '../../thread/model/thread_json.dart';
import '../model/robot.dart';

class RobotDetail extends StatefulWidget {
  final Robot? robot;
  const RobotDetail({super.key, this.robot});

  @override
  State<RobotDetail> createState() => _RobotDetailState();
}

class _RobotDetailState extends State<RobotDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.robot!.nickname!.tr),
        ),
        body: MultiBlocListener(
            listeners: [
              BlocListener<OtherBloc, OtherState>(listener: (context, state) {
                debugPrint('OtherBloc: $state');
                //
                if (state is OtherInProgress) {
                  EasyLoading.show();
                } else if (state is CreateRobotThreadSuccess) {
                  ThreadJson threadJson = state.threadJson;
                  debugPrint('CreateRobotThreadSuccess: $threadJson');
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
                  title: Text('i18n.robot.nickname'.tr),
                  trailing: Text(widget.robot!.nickname!.tr),
                ),
                ListTile(
                  title: Text('i18n.robot.description'.tr),
                  trailing: Text(widget.robot!.description!.tr),
                ),
                ListTile(
                  title: Text('i18n.robot.type'.tr),
                  trailing: Text(widget.robot!.type!),
                ),
                ListTile(
                  title: Text('i18n.robot.model'.tr),
                  trailing: Text(widget.robot!.llm!.model!),
                ),
                ListTile(
                  title: Text('i18n.robot.temperature'.tr),
                  trailing: Text('${widget.robot!.llm!.temperature!}'),
                ),
                ListTile(
                  title: Text('i18n.robot.prompt'.tr),
                  trailing: Text(widget.robot!.llm!.prompt!),
                ),
                Gaps.vGap10,
                MyButton(
                    onPressed: () {
                      // EasyLoading.showInfo('chat');
                      String? currentUid = SpUtil.getString(ChatConsts.uid);
                      debugPrint("currentUid:$currentUid");
                      //
                      BlocProvider.of<OtherBloc>(context).add(
                          CreateRobotThreadEvent(
                              currentUserUid: currentUid!,
                              robot: widget.robot!));
                    },
                    text: 'i18n.robot.start.chat'.tr)
              ],
            )));
  }
}
