/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-05-17 10:20:14
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-10-05 10:25:53
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
import 'package:bytedesk_kefu/model/jsonResult.dart';
import 'package:im/common/auth/model/scan_json.dart';

import '../model/auth_json.dart';
import 'auth_api.dart';
import '../../../chat/other_bloc/upload_api.dart';

class AuthRepository {
  final BytedeskAuthHttpApi bytedeskHttpApi = BytedeskAuthHttpApi();
  final BytedeskUploadHttpApi bytedeskUploadHttpApi = BytedeskUploadHttpApi();

  Future<JsonResult> sendMobileCode(
      String mobile, String type, String platform) {
    return bytedeskHttpApi.sendMobileCode(mobile, type, platform);
  }

  Future<AuthJson> loginMobile(String mobile, String code, String platform) {
    return bytedeskHttpApi.loginMobile(mobile, code, platform);
  }

  Future<ScanJson> scan(String deviceUid, String code) {
    return bytedeskHttpApi.scan(deviceUid, code);
  }

  Future<ScanJson> scanConfirm(String mobile, String deviceUid, String code) {
    return bytedeskHttpApi.scanConfirm(mobile, deviceUid, code);
  }
}
