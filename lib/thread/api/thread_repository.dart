/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2023-08-09 16:52:26
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-12 19:29:14
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import '../../contact/model/contact.dart';
import '../../robot/model/robot.dart';
import '../model/thread_data.dart';
import '../model/thread_json.dart';
import 'thread_api.dart';

class ThreadRepository {
  final ThreadHttpApi threadHttpApi = ThreadHttpApi();

  Future<ThreadData> queryThread(int? page, int? size, ) {
    return threadHttpApi.queryThread(page, size);
  }

  Future<ThreadData> searchThreadList(int? page, int? size, String? content) {
    return threadHttpApi.searchThread(page, size, content);
  }

  Future<ThreadJson> createMemberThread(String memberSelfUid, Contact member) {
    return threadHttpApi.createMemberThread(memberSelfUid, member);
  }

  Future<ThreadJson> createRobotThread(String currentUserUid, Robot robot) {
    return threadHttpApi.createRobotThread(currentUserUid, robot);
  }

}
