/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2023-08-01 14:26:10
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-13 06:53:25
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

import 'llm.dart';

class Robot extends Equatable {
  //
  final String? uid;
  final String? nickname;
  final String? avatar;
  final String? description;
  final String? type;
  final bool? published;
  final String? orgUid;
  // 
  final Llm? llm;
  //
  const Robot(
      {this.uid,
      this.nickname,
      this.avatar,
      this.description,
      this.type,
      this.published,
      this.orgUid,
      this.llm,
      })
      : super();

  //
  static Robot fromJson(dynamic json) {
    return Robot(
      uid: json['uid'],
      nickname: json['nickname'],
      avatar: json['avatar'],
      description: json['description'],
      type: json['type'],
      published: json['published'],
      orgUid: json['orgUid'],
      llm: json['llm'] != null ? Llm.fromJson(json['llm']) : Llm.init(),
    );
  }

  //
  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'nickname': nickname,
        'avatar': avatar,
        'description': description,
        'type': type,
        'published': published,
        'orgUid': orgUid
      };

  //
  static Robot init() {
    return const Robot(
      uid: '',
      nickname: '',
      avatar: '',
      description: '',
      type: '',
      published: false,
      orgUid: '',
    );
  }

  //
  @override
  List<Object> get props => [uid!];
}
