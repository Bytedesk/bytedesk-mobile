import 'package:flutter/material.dart';

//普通条目布局
class SettingCommon extends StatelessWidget {
  final VoidCallback? onPressed;

  const SettingCommon({super.key, this.title, this.content, this.onPressed});

  final String? title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
      onTap: onPressed,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0),
                      child: Text(title!,),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(content!,
                        style: const TextStyle(
                          fontSize: 14,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5.0, right: 15),
                    child: const Icon(Icons.keyboard_arrow_right),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
