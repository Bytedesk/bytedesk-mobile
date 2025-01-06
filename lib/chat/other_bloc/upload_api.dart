/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-14 06:32:06
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-10-08 14:30:24
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
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:im/chat/model/upload_jsonResult.dart';
import 'package:sp_util/sp_util.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../util/base_api.dart';
import '../util/chat_consts.dart';
import '../util/chat_utils.dart';

class BytedeskUploadHttpApi extends BaseHttpApi {
  ///// https://pub.dev/documentation/http/latest/http/MultipartRequest-class.html
  // Future<JsonResult> uploadFile(String? filePath) async {
  //   //
  //   String? fileName = filePath!.split("/").last;
  //   // String? username = SpUtil.getString(ChatConsts.uid);
  //   String? accessToken = SpUtil.getString(ChatConsts.accessToken);

  //   // var uploadUrl = Utils.getHostUri('/api/v1/upload/file');
  //   // const uploadUrl = '${ChatConsts.httpBaseUrl}/api/v1/upload/file';
  //   debugPrint("uploadImage fileName $fileName");
  //   // 获取当前日期时间
  //   DateTime now = DateTime.now();
  //   // 格式化日期时间
  //   String formattedDateTime = DateFormat('yyyyMMddHHmmss').format(now);
  //   // 拼接文件名
  //   String fileNameNew = '${formattedDateTime}_$fileName';
  //   // web browser 浏览器中不支持此种上传图片方式
  //   // Unsupported operation: MultipartFile is only supported where dart:io is available.
  //   // var uri = Uri.parse(uploadUrl);
  //   Uri uploadUri = Utils.getHostUri('/api/v1/upload/file');
  //   debugPrint("uploadUri ${uploadUri.toString()}");
  //   var request = http.MultipartRequest('POST', uploadUri)
  //     ..files.add(await http.MultipartFile.fromPath('file', filePath))
  //     // ..fields["file", file)
  //     ..fields['file_name'] = fileNameNew
  //     ..fields["file_type"] = ""
  //     ..fields["is_avatar"] = "false"
  //     ..fields["kb_type"] = ChatConsts.UPLOAD_TYPE_CHAT
  //     ..fields["category_uid"] = ""
  //     ..fields["kb_uid"] = ""
  //     ..fields["client"] = client
  //     //  ..headers['Content-Type'] = 'multipart/form-data' // 设置Content-Type为multipart/form-data
  //     ..headers['Authorization'] =
  //         'Bearer $accessToken'; // 假设你需要一个认证令牌，替换YOUR_TOKEN为实际的令牌

  //   http.Response response =
  //       await http.Response.fromStream(await request.send());
  //   // debugPrint("Result: ${response.body}");

  //   //解决json解析中的乱码问题
  //   Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
  //   //将string类型数据 转换为json类型的数据
  //   final responseJson = json.decode(utf8decoder.convert(response.bodyBytes));
  //   debugPrint("upload image responseJson $responseJson");
  //   //
  //   return JsonResult.fromJson(responseJson);
  // }

  // https://github.com/fluttercandies/flutter_wechat_assets_picker/blob/main/README-ZH.md
  Future<UploadJsonResult> upload(AssetEntity entity) async {
    final File? file = await entity.file;
    if (file == null) {
      throw StateError('Unable to obtain file of the entity ${entity.id}.');
    }
    String? accessToken = SpUtil.getString(ChatConsts.accessToken);

    // 获取当前日期时间
    // DateTime now = DateTime.now();
    // 格式化日期时间
    String formattedDateTime = ChatUtils
        .formattedTimestampNow(); //DateFormat('yyyyMMddHHmmss').format(now);
    // 拼接文件名
    String fileNameNew = '${formattedDateTime}_${file.path.split("/").last}';
    //
    // const uploadUrl = '${ChatConsts.httpBaseUrl}/api/v1/upload/file';
    // var uri = Uri.parse(uploadUrl);
    Uri uploadUri = ChatUtils.getHostUri('/api/v1/upload/file');
    debugPrint("uploadUri ${uploadUri.toString()}");

    final request = http.MultipartRequest('POST', uploadUri)
      ..files.add(await http.MultipartFile.fromPath('file', file.path))
      ..fields['file_name'] = fileNameNew
      ..fields["file_type"] = ChatUtils.getFileType(fileNameNew)
      ..fields["is_avatar"] = "false"
      ..fields["kb_type"] = ChatConsts.UPLOAD_TYPE_CHAT
      ..fields["category_uid"] = ""
      ..fields["kb_uid"] = ""
      ..fields["client"] = client
      //  ..headers['Content-Type'] = 'multipart/form-data' // 设置Content-Type为multipart/form-data
      ..headers['Authorization'] =
          'Bearer $accessToken'; // 假设你需要一个认证令牌，替换YOUR_TOKEN为实际的令牌

    // final response = await request.send();
    http.Response response =
        await http.Response.fromStream(await request.send());
    // debugPrint("Result: ${response.body}");

    //解决json解析中的乱码问题
    Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
    //将string类型数据 转换为json类型的数据
    final responseJson = json.decode(utf8decoder.convert(response.bodyBytes));
    debugPrint("upload entity responseJson $responseJson");
    //
    return UploadJsonResult.fromJson(responseJson, entity);
  }

  // Future<http.MultipartFile> multipartFileFromAssetEntity(
  //     AssetEntity entity) async {
  //   http.MultipartFile mf;
  //   // Using the file path.
  //   final file = await entity.file;
  //   if (file == null) {
  //     throw StateError('Unable to obtain file of the entity ${entity.id}.');
  //   }
  //   mf = await http.MultipartFile.fromPath('file', file.path);
  //   // // Using the bytes.
  //   // final bytes = await entity.originBytes;
  //   // if (bytes == null) {
  //   //   throw StateError('Unable to obtain bytes of the entity ${entity.id}.');
  //   // }
  //   // mf = http.MultipartFile.fromBytes('file', bytes);
  //   return mf;
  // }
}
