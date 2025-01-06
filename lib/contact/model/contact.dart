/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2023-08-01 14:26:10
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-09-13 16:47:16
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
import 'package:im/chat/model/user_protobuf.dart';
import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';

class Contact extends Equatable {
  //
  final String? uid;
  final String? nickname;
  final String? avatar;
  final String? description;
  final String? jobNo;
  final String? jobTitle;
  final String? seatNo;
  final String? telephone;
  final String? email;
  //
  final UserProtobuf? user;
  //
  const Contact(
      {this.uid,
      this.nickname,
      this.avatar,
      this.description,
      this.jobNo,
      this.jobTitle,
      this.seatNo,
      this.telephone,
      this.email,
      this.user})
      : super();

  //
  static Contact fromJson(dynamic json) {
    return Contact(
      uid: json['uid'],
      nickname: json['nickname'],
      avatar: json['avatar'],
      description: json['description'],
      jobNo: json['jobNo'],
      jobTitle: json['jobTitle'],
      seatNo: json['seatNo'],
      telephone: json['telephone'],
      email: json['email'],
      user: json['user'] != null
          ? UserProtobuf.fromJson(json['user'])
          : UserProtobuf.init(),
    );
  }

  //
  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'nickname': nickname,
        'avatar': avatar,
        'description': description,
        'jobNo': jobNo,
        'jobTitle': jobTitle,
        'seatNo': seatNo,
        'telephone': telephone,
        'email': email,
      };

  //
  static Contact init() {
    return const Contact(
      uid: '',
      nickname: '',
      avatar: '',
      description: '',
      jobNo: '',
      jobTitle: '',
      seatNo: '',
      telephone: '',
      email: '',
    );
  }

  //
  @override
  List<Object> get props => [uid!];
}

class ContactInfo extends ISuspensionBean {
  //
  String name;
  String? tagIndex;
  String? namePinyin;

  Color? bgColor;
  IconData? iconData;

  String? img;
  String? id;
  String? firstletter;

  Contact? contact;

  ContactInfo({
    required this.name,
    this.tagIndex,
    this.namePinyin,
    this.bgColor,
    this.iconData,
    this.img,
    this.id,
    this.firstletter,
    this.contact,
  });

  // ContactInfo.fromJson(Map<String, dynamic> json)
  //     : name = json['name'],
  //       img = json['img'],
  //       id = json['id']?.toString(),
  //       firstletter = json['firstletter'];

  static ContactInfo fromContact(Contact contact) {
    return ContactInfo(
        name: contact.nickname!,
        img: contact.avatar,
        id: contact.uid,
        contact: contact,
      );
  }

  @override
  String getSuspensionTag() => tagIndex!;

  @override
  String toString() => json.encode(this);
}
