/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-09-14 11:49:46
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2025-01-06 16:43:05
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
import 'package:bytedesk_kefu/ui/widget/empty_widget.dart';
import 'package:flutter/material.dart';

class ThreadSearchPage extends StatefulWidget {
  final Brightness brightness;
  const ThreadSearchPage({super.key, required this.brightness});

  @override
  State<ThreadSearchPage> createState() => _ThreadSearchPageState();
}

class _ThreadSearchPageState extends State<ThreadSearchPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Hero(
                    tag: "search",
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        width: MediaQuery.of(context).size.width,
                        height: 46,
                        // decoration:  BoxDecoration(
                        //         border: Border.all(
                        //             color: Colors.grey, width: 1), // 设置灰色边框及其宽度
                        //         borderRadius:
                        //             BorderRadius.circular(6), // 设置边框的圆角半径
                        //       ),
                        // color: widget.brightness == Brightness.dark
                        //     ? Colors.grey
                        //     : Colors.grey.shade100,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 10),
                            Image.asset("assets/images/common/search.png",
                                width: 20, height: 20),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Material(
                                child: TextField(
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: "i18n.thread.search.hint".tr,
                                    // hintStyle: TextStyle(
                                    //     color: widget.brightness ==
                                    //             Brightness.dark
                                    //         ? Colors.white
                                    //         : const Color(0xFFbfbfbf),
                                    //     fontSize: 16)
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                          ],
                        )),
                  ),
                ),
                InkResponse(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "i18n.thread.search.cancel".tr,
                        style: TextStyle(
                            fontSize: 16,
                            color: widget.brightness == Brightness.dark
                                ? Colors.white
                                : const Color(0xFF4589E6)),
                      )),
                )
              ],
            ),
            Expanded(
              child: EmptyWidget(
                tapCallback: () {
                  debugPrint('点击了空白区域');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
