/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 14:41:07
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-13 07:04:54
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
import '../model/robotData.dart';
import 'robot_api.dart';

class RobotRepository {
  final RobotHttpApi robotHttpApi = RobotHttpApi();

  Future<RobotData> queryRobot(int? page, int? size,) {
    return robotHttpApi.queryRobot(page, size,);
  }

  Future<RobotData> searchRobotList(int? page, int? size, String? content) {
    return robotHttpApi.searchRobot(page, size, content);
  }
}
