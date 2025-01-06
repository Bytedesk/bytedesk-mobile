/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-05-17 10:20:31
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-10-05 10:25:43
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  技术/商务联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'dart:convert';

import 'package:bytedesk_kefu/model/jsonResult.dart';
import 'package:flutter/foundation.dart';
import 'package:sp_util/sp_util.dart';

import '../../../chat/model/user.dart';
import '../../../chat/util/base_api.dart';
import '../../../chat/util/chat_consts.dart';
import '../../../chat/util/chat_utils.dart';
import '../model/auth_json.dart';
import '../model/scan_json.dart';

class BytedeskAuthHttpApi extends BaseHttpApi {
  //
  Future<JsonResult> sendMobileCode(
      String mobile, String type, String platform) async {
    var sendMobileCodeUrl = ChatUtils.getHostUri('/auth/v1/send/mobile');
    var body = json.encode({
      "mobile": mobile,
      "type": type,
      "captchaUid": "captchaUid", // 占位符，TODO: 替换为真实值
      "captchaCode": "captchaCode", // 占位符，TODO: 替换为真实值
      "platform": platform,
      "client": client
    });
    final response = await httpClient.post(sendMobileCodeUrl,
        headers: getHeadersForVisitor(), body: body);
    //
    final sendCodeJson = jsonDecode(response.body);
    debugPrint('sendMobileCode:$sendCodeJson');
    //
    return JsonResult.fromJson(sendCodeJson);
  }

  Future<AuthJson> loginMobile(
      String mobile, String code, String platform) async {
    //
    var loginMobileUrl = ChatUtils.getHostUri('/auth/v1/login/mobile');
    var body = json.encode({
      "mobile": mobile,
      "code": code,
      "captchaUid": "captchaUid", // 占位符，TODO: 替换为真实值
      "captchaCode": "captchaCode", // 占位符，TODO: 替换为真实值
      "platform": platform,
      "client": client
    });
    final oauthResponse = await httpClient.post(loginMobileUrl,
        headers: getHeadersForVisitor(), body: body);
    // debugPrint('oauth result: $oauthResponse');
    // 200: 授权成功，否则授权失败
    final oauthJson = jsonDecode(oauthResponse.body);
    debugPrint('oauth:$oauthJson');
    //
    final auth = AuthJson.fromJson(oauthJson);
    if (auth.code == 200) {
      SpUtil.putBool(ChatConsts.isLogin, true);
      SpUtil.putString(ChatConsts.accessToken, auth.data!.accessToken!);
      //
      User user = auth.data!.user!;
      ChatUtils.saveUserCache(user);
    }
    //
    return auth;
  }

  Future<ScanJson> scan(String deviceUid, String code) async {
    //
    final scanUrl = ChatUtils.getHostUri('/api/v1/vip/scan',
        {'deviceUid': deviceUid, 'code': code, 'client': client});
    final initResponse = await httpClient.get(scanUrl, headers: getHeaders());
    //解决json解析中的乱码问题
    Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
    //将string类型数据 转换为json类型的数据
    final responseJson =
        json.decode(utf8decoder.convert(initResponse.bodyBytes));
    debugPrint("$scanUrl, scan:$responseJson");
    //
    return ScanJson.fromJson(responseJson);
  }

  //
  Future<ScanJson> scanConfirm(
      String mobile, String deviceUid, String code) async {
    //
    var scanConfirmUrl = ChatUtils.getHostUri('/api/v1/vip/scan/confirm');
    var body = json.encode({
      "receiver": mobile,
      "deviceUid": deviceUid,
      "code": code,
      "client": client
    });
    final response = await httpClient.post(scanConfirmUrl,
        headers: getHeaders(), body: body);
    //
    final sendCodeJson = jsonDecode(response.body);
    debugPrint('scanConfirm:$sendCodeJson');
    //
    return ScanJson.fromJson(sendCodeJson);
  }
}
