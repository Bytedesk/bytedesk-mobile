/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-05-17 10:20:14
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-21 21:10:23
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  技术/商务联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
//
import 'package:im/chat/model/upload_jsonResult.dart';
import 'package:im/chat/other_bloc/agentJson.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../contact/model/contact.dart';
import '../../robot/model/robot.dart';
import '../../thread/api/thread_api.dart';
import '../../thread/model/thread.dart';
import '../../thread/model/thread_json.dart';
import 'agent_api.dart';
import 'upload_api.dart';

class OtherRepository {
  final BytedeskAgentHttpApi bytedeskAgentHttpApi = BytedeskAgentHttpApi();
  final BytedeskUploadHttpApi bytedeskUploadHttpApi = BytedeskUploadHttpApi();
  final ThreadHttpApi threadHttpApi = ThreadHttpApi();

  // Future<JsonResult> uploadFile(String? filePath) async {
  //   return await bytedeskUploadHttpApi.uploadFile(filePath);
  // }

  Future<UploadJsonResult> uploadAssetEntity(AssetEntity entity) async {
    return await bytedeskUploadHttpApi.upload(entity);
  }

  Future<AgentJson> queryAgent() async {
    return await bytedeskAgentHttpApi.queryAgent();
  }

  Future<ThreadJson> createMemberThread(String memberSelfUid, Contact member) {
    return threadHttpApi.createMemberThread(memberSelfUid, member);
  }

  Future<ThreadJson> createRobotThread(String currentUserUid, Robot robot) {
    return threadHttpApi.createRobotThread(currentUserUid, robot);
  }

  Future<ThreadJson> updateThreadUnreadCount(Thread thread) {
    return threadHttpApi.updateThreadUnreadCount(thread);
  }
}
