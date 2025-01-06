/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2023-08-09 16:54:23
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-13 17:49:02
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
abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class GetMessageEvent extends MessageEvent {
  final int? page;
  final int? size;
  final String? topic;
  const GetMessageEvent(
      {@required this.page,
      @required this.size, 
      @required this.topic})
      : super();
}

class SearchMessageEvent extends MessageEvent {
  final int? page;
  final int? size;
  final String? content;
  const SearchMessageEvent(
      {@required this.page,
      @required this.size,
      @required this.content})
      : super();
}

class UploadImageEvent extends MessageEvent {
  final String? filePath;

  const UploadImageEvent({@required this.filePath}) : super();
}

class UploadImageBytesEvent extends MessageEvent {
  final String? fileName;
  final List<int>? fileBytes;
  final String? mimeType;

  const UploadImageBytesEvent(
      {@required this.fileName,
      @required this.fileBytes,
      @required this.mimeType})
      : super();
}

class UploadVideoEvent extends MessageEvent {
  final String? filePath;

  const UploadVideoEvent({@required this.filePath}) : super();
}

class UploadVideoBytesEvent extends MessageEvent {
  final String? fileName;
  final List<int>? fileBytes;
  final String? mimeType;

  const UploadVideoBytesEvent(
      {@required this.fileName,
      @required this.fileBytes,
      @required this.mimeType})
      : super();
}

