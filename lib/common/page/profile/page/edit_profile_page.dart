import 'package:bytedesk_common/blocs/profile_bloc/bloc.dart';
import 'package:bytedesk_common/widgets/head_choose_widget.dart';
import 'package:im/common/page/profile/provider/profile_qr_provider.dart';
import 'package:sp_util/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../../../../chat/util/chat_consts.dart';
import '../../../widget/setting_avatar.dart';
import '../../../widget/setting_common.dart';
import '../provider/edit_description_provider.dart';
import '../provider/edit_nickname_provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with
        AutomaticKeepAliveClientMixin<EditProfilePage>,
        WidgetsBindingObserver {
  //
  var userUid = '';
  var nickname = '';
  var avatar = '';
  var description = '';
  //
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    //
    userUid = SpUtil.getString(ChatConsts.uid)!;
    nickname = SpUtil.getString(ChatConsts.nickname)!;
    avatar = SpUtil.getString(ChatConsts.avatar)!;
    description = SpUtil.getString(ChatConsts.description)!;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //
    return Scaffold(
        appBar: AppBar(
          title: Text('i18n.profile.title'.tr),
        ),
        body:
            BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
          //
          if (state is UploadImageSuccess) {
            //
            BlocProvider.of<ProfileBloc>(context)
                .add(UpdateAvatarEvent(avatar: state.uploadJsonResult.url));
            //
            setState(() {
              avatar = state.uploadJsonResult.url!;
            });
          } else if (state is UpdateAvatarSuccess) {
            //
            setState(() {
              avatar = state.user.avatar!;
            });
          } else if (state is UpdateNicknameSuccess) {
            //
            setState(() {
              nickname = state.user.nickname!;
            });
          } else if (state is UpdateDescriptionSuccess) {
            //
            setState(() {
              description = state.user.description!;
            });
          }
        }, builder: (context, state) {
          return ListView(
              children: ListTile.divideTiles(context: context, tiles: [
            SettingAvatar(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return HeadChooseWidget(
                          chooseImgCallBack: (XFile mHeadFile) {
                        //
                        BlocProvider.of<ProfileBloc>(context)
                            .add(UploadImageEvent(filePath: mHeadFile.path));
                      });
                    });
              },
              avatar: avatar,
            ),
            SettingCommon(
                title: "i18n.profile.nickname".tr,
                content: nickname,
                onPressed: () async {
                  final nicknameEdit = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditNicknameProvider(),
                    ),
                  );
                  setState(() {
                    nickname = nicknameEdit ?? nickname;
                  });
                }),
            SettingCommon(
                title: "i18n.profile.description".tr,
                content: description.tr,
                onPressed: () async {
                  final discriptionEdit = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditDescriptionProvider(),
                    ),
                  );
                  setState(() {
                    description = discriptionEdit ?? description;
                  });
                }),
            SettingCommon(
                title: "i18n.profile.qrcode".tr,
                content: 'qrcode',
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileQrProvider(
                        userUid: userUid,
                      ),
                    ),
                  );
                }),
          ]).toList());
        }));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("didChangeAppLifecycleState:$state");
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
        setState(() {
          nickname = SpUtil.getString(ChatConsts.nickname)!;
          description = SpUtil.getString(ChatConsts.description)!;
        });
        break;
      case AppLifecycleState.detached: // 申请将暂时暂停
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
