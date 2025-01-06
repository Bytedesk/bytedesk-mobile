// 
import 'package:bytedesk_kefu/ui/widget/empty_widget.dart';
import 'package:flutter/material.dart';

// TODO: 聊天详情页面
class ChatProfilePage extends StatefulWidget {
  const ChatProfilePage({super.key});

  @override
  State<ChatProfilePage> createState() => _ChatProfilePageState();
}

class _ChatProfilePageState extends State<ChatProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Profile'),
      ),
      body: EmptyWidget(
        tapCallback: () {

        },
      ),
    );
  }
}