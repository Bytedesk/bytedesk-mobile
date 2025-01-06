/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2023-08-09 16:54:23
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-12 21:50:54
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
import 'package:meta/meta.dart';

@immutable
abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class GetContactEvent extends ContactEvent {
  final int? page;
  final int? size;
  const GetContactEvent({
    @required this.page,
    @required this.size,
  }) : super();
}

class SearchContactEvent extends ContactEvent {
  final int? page;
  final int? size;
  final String? content;
  const SearchContactEvent(
      {@required this.page, @required this.size, @required this.content})
      : super();
}

class GetTikuQaEvent extends ContactEvent {
  final int? page;
  final int? size;
  final String? uid;
  const GetTikuQaEvent(
      {@required this.page, @required this.size, @required this.uid})
      : super();
}
