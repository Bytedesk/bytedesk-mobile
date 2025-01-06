/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 07:24:58
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-10-05 10:32:11
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'package:bytedesk_common/blocs/profile_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../page/edit_profile_page.dart';

class EditProfileProvider extends StatelessWidget {
  const EditProfileProvider({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return BlocProvider(
      create: (BuildContext context) => ProfileBloc(),
      child: const EditProfilePage(),
    );
  }
}
