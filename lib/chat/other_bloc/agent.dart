/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-14 06:41:18
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-14 08:12:36
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
import 'package:equatable/equatable.dart';

class Agent extends Equatable {
  //
  final String? uid;
  final String? nickname;
  final String? avatar;

  const Agent({this.uid, this.nickname, this.avatar});

  static Agent fromJson(dynamic json) {
    return Agent(
        uid: json["uid"], nickname: json["nickname"], avatar: json["avatar"]);
  }

  //
  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'nickname': nickname,
        'avatar': avatar,
      };

  static Agent init() {
    return const Agent(uid: "", nickname: "", avatar: "");
  }

  @override
  List<Object?> get props => [uid];
}
