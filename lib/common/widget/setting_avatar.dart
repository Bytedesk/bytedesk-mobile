import 'package:flutter/material.dart';

//头像布局
class SettingAvatar extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? avatar;

  const SettingAvatar({super.key, this.onPressed, this.avatar});

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Colors.white,
      child: InkWell(
          onTap: onPressed,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: const Text('头像',),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(avatar!),
                          radius: 20.0,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5.0, right: 15),
                        child: InkWell(
                          child: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            // TODO(implement)
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 0.5,
                color: Colors.black12,
                //  margin: EdgeInsets.only(left: 60),
              ),
            ],
          )),
    );
  }
}
