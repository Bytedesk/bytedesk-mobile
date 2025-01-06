/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2023-04-12 10:14:56
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-09-14 12:33:56
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
// import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../chat/mqtt/events.dart';
import '../../chat/util/chat_utils.dart';
import '../../chat/view/chat_provider.dart';
import '../model/thread.dart';

class ThreadItemWidget extends StatefulWidget {
  final Thread? thread;
  const ThreadItemWidget({super.key, this.thread});

  @override
  State<ThreadItemWidget> createState() => _ThreadItemWidgetState();
}

class _ThreadItemWidgetState extends State<ThreadItemWidget> {
  // late int selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // selectedIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: const EdgeInsets.only(bottom: 0.2),
      child: ListTile(
        // leading: CachedNetworkImage(
        //   imageUrl: widget.thread!.user!.avatar!,
        //   width: 45,
        //   height: 45,
        // ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            width: 45,
            height: 45,
            child: CachedNetworkImage(
              imageUrl: widget.thread!.user!.avatar!,
              placeholder: (context, url) =>
                  Container(color: Colors.grey.shade400),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        title: Row(
          children: <Widget>[
            Text(
              widget.thread!.user!.nickname!.tr.length > 10
                  ? '${widget.thread!.user!.nickname!.tr.substring(0, 10)}...'
                  : widget.thread!.user!.nickname!.tr,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // Offstage(
            //   offstage: thread.wid == Constants.WORKGROUP_WID_LIANGSHIBAO
            //       ? false
            //       : true,
            //   child: Container(
            //       margin: const EdgeInsets.only(left: 5),
            //       child: BorderTextWidget('官方')),
            // )
          ],
        ),
        subtitle: Text(
          widget.thread!.content!.tr,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        // selected: selectedIndex == index,
        // tileColor: Colors.red,
        // isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              ChatUtils.shortTimeFormat(widget.thread!.updatedAt!),
              style: const TextStyle(color: Color(0xffbdbdbd), fontSize: 12),
            ),
            Offstage(
              offstage: widget.thread!.unreadCount == 0 ? true : false,
              child: Container(
                margin: const EdgeInsets.only(top: 13),
                child: Badge(
                  label: Text(
                    widget.thread!.unreadCount.toString(),
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
        onTap: () {
          debugPrint("chooseThread ${widget.thread!.toJson()}");
          // bytedeskEventBus.fire(ChooseTikuEvent(thread));
          bytedeskEventBus
              .fire(ReceiveThreadClearUnreadCountEventBus(widget.thread!));
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return ChatProvider(
                thread: widget.thread,
              );
            },
          ));
        },
      ),
    );
  }
}
