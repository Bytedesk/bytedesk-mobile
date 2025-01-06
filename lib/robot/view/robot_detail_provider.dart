/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-13 08:04:03
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-09-13 18:37:11
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
import 'package:im/robot/api/robot_repository.dart';
import 'package:im/robot/view/robot_detail.dart';

import '../../chat/other_bloc/bloc.dart';
import '../bloc/robot_bloc.dart';
import '../model/robot.dart';

class RobotDetailProvider extends StatelessWidget {
  final Robot? robot;
  const RobotDetailProvider({super.key, this.robot});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<RobotBloc>(
        create: (context) => RobotBloc(RobotRepository()),
      ),
      BlocProvider<OtherBloc>(
        create: (context) => OtherBloc(),
      )
    ], child: RobotDetail(robot: robot));
  }
}
