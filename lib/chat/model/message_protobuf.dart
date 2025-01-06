//
import 'package:equatable/equatable.dart';
import 'package:im/chat/model/thread_protobuf.dart';
import 'package:im/chat/model/user_protobuf.dart';

class MessageProtobuf extends Equatable {
  //
  final String? uid;
  final String? type;
  final String? content;
  final String? status;
  final String? createdAt;
  final String? client;
  final String? extra;
  //
  final ThreadProtobuf? thread;
  final UserProtobuf? user;

  const MessageProtobuf(
      {this.uid,
      this.type,
      this.content,
      this.status,
      this.createdAt,
      this.client,
      this.extra,
      //
      this.thread,
      this.user});

  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}
