/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 08:50:51
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-11-29 18:19:34
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

import '../model/thread_data.dart';

enum ThreadStatus { initial, loading, success, failure }

extension ThreadStatusX on ThreadStatus {
  bool get isInitial => this == ThreadStatus.initial;
  bool get isLoading => this == ThreadStatus.loading;
  bool get isSuccess => this == ThreadStatus.success;
  bool get isFailure => this == ThreadStatus.failure;
}

final class ThreadState extends Equatable {
  final ThreadStatus status;
  // final String type;
  final ThreadData? threadData;

  const ThreadState({this.status = ThreadStatus.initial, this.threadData});

  ThreadState copyWith(
      {ThreadStatus? status, String? type, ThreadData? threadData}) {
    return ThreadState(
        status: status ?? this.status,
        threadData: threadData ?? this.threadData);
  }

  factory ThreadState.fromJson(Map<String, dynamic> json) => ThreadState(
      status: _$ThreadStatusEnumMap[json['status']]!,
      // type: json['type'],
      threadData: ThreadData.fromJson(json['threadData']));

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status.index,
        'threadData': threadData!.toJson()
      };

  @override
  List<Object> get props => [status, threadData!];
}

const _$ThreadStatusEnumMap = {
  0: ThreadStatus.initial,
  1: ThreadStatus.loading,
  2: ThreadStatus.success,
  3: ThreadStatus.failure,
};
