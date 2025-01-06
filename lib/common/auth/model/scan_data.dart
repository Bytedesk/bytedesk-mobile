/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-05-17 10:48:45
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-09-09 17:36:26
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  技术/商务联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'package:equatable/equatable.dart';

class ScanData extends Equatable {
  final String? uid;
  final String? type;
  final String? status;
  final String? sender;
  final String? receiver;
  final String? content;
  final String? ip;
  final String? ipLocation;
  final String? deviceUid;
  final String? client;
  final String? createdAt;
  final String? updatedAt;

  const ScanData({
    this.uid,
    this.type,
    this.status,
    this.sender,
    this.receiver,
    this.content,
    this.ip,
    this.ipLocation,
    this.deviceUid,
    this.client,
    this.createdAt,
    this.updatedAt,
  }) : super();

  //
  static ScanData fromJson(dynamic json) {
    return ScanData(
      uid: json['uid'],
      type: json['type'],
      status: json['status'],
      sender: json['sender'],
      receiver: json['receiver'],
      content: json['content'],
      ip: json['ip'],
      ipLocation: json['ip_location'],
      deviceUid: json['device_uid'],
      client: json['client'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  //
  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'type': type,
        'status': status,
        'sender': sender,
        'receiver': receiver,
        'content': content,
        'ip': ip,
        'ip_location': ipLocation,
        'device_uid': deviceUid,
        'client': client,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  //
  static ScanData init() {
    return const ScanData(
      uid: '',
      type: '',
      status: '',
      sender: '',
      receiver: '',
    );
  }

  @override
  List<Object> get props => [uid!];
}
