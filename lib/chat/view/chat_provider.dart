/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-13 07:42:09
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-15 18:28:39
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
//
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/chat/message_bloc/message_event.dart';
import 'package:im/chat/other_bloc/other_bloc.dart';
import 'package:im/chat/other_bloc/other_event.dart';
import 'package:im/chat/view/chat_page.dart';
import 'package:im/thread/bloc/bloc.dart';
import 'package:im/thread/model/thread.dart';

import '../../thread/api/thread_repository.dart';
import '../message_bloc/message_bloc.dart';

class ChatProvider extends StatelessWidget {
  final Thread? thread;
  const ChatProvider({super.key, this.thread});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThreadBloc>(
          create: (BuildContext context) => ThreadBloc(context.read<ThreadRepository>()),
        ),
        BlocProvider<MessageBloc>(
          create: (BuildContext context) => MessageBloc()
            ..add(GetMessageEvent(page: 0, size: 20, topic: thread?.topic)),
        ),
        BlocProvider<OtherBloc>(
            create: (BuildContext context) =>
                OtherBloc()
                ..add(const QueryAgentEvent())
                ..add(UpdateThreadUnreadCountEvent(thread: thread!)))
      ],
      child: ChatPage(thread: thread),
    );
  }
}
