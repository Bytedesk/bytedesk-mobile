/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 08:50:51
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-12 22:31:05
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

import '../model/contact_data.dart';

enum ContactStatus { initial, loading, success, failure }

extension ContactStatusX on ContactStatus {
  bool get isInitial => this == ContactStatus.initial;
  bool get isLoading => this == ContactStatus.loading;
  bool get isSuccess => this == ContactStatus.success;
  bool get isFailure => this == ContactStatus.failure;
}

final class ContactState extends Equatable {
  final ContactStatus status;
  final String type;
  final ContactData? contactData;

  const ContactState(
      {this.status = ContactStatus.initial, this.type = '', this.contactData});

  ContactState copyWith(
      {ContactStatus? status, String? type, ContactData? contactData}) {
    return ContactState(
        status: status ?? this.status,
        type: type ?? this.type,
        contactData: contactData ?? this.contactData);
  }

  factory ContactState.fromJson(Map<String, dynamic> json) => ContactState(
      status: _$ContactStatusEnumMap[json['status']]!,
      type: json['type'],
      contactData: ContactData.fromJson(json['contactData']));

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status.index,
        'type': type,
        'contactData': contactData!.toJson()
      };

  @override
  List<Object> get props => [status, type, contactData!];
}

const _$ContactStatusEnumMap = {
  0: ContactStatus.initial,
  1: ContactStatus.loading,
  2: ContactStatus.success,
  3: ContactStatus.failure,
};
