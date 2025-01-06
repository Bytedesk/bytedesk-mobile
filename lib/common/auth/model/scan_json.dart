/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 17:02:55
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-09-09 17:37:00
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'package:equatable/equatable.dart';
import 'scan_data.dart';

class ScanJson extends Equatable {
  final String? message;
  final int? code;
  final ScanData? data;

  const ScanJson({
    this.message,
    this.code,
    this.data,
  }) : super();

  static ScanJson fromJson(dynamic json) {
    return ScanJson(
        message: json['message'],
        code: json['code'],
        data: json['data'] == null ? null : ScanData.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "message": message,
        "code": code,
        "data": data?.toJson(),
      };

  static ScanJson init() {
    return ScanJson(
      message: "",
      code: 0,
      data: ScanData.init(),
    );
  }

  @override
  List<Object> get props => [];
}
