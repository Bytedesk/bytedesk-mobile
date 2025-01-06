import 'package:azlistview/azlistview.dart';
import 'package:bytedesk_common/blocs/cubit/theme_cubit.dart';
import 'package:bytedesk_common/blocs/cubit/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import '../../chat/util/chat_consts.dart';
import '../../common/util/common_utils.dart';
import '../../utils/constants.dart';
import '../bloc/bloc.dart';
import '../model/contact.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage>
    with AutomaticKeepAliveClientMixin<ContactsPage>, WidgetsBindingObserver {
  late bool _isLoading;
  late int page;
  List<ContactInfo> contactList = [];
  List<ContactInfo> topList = [];
  late Brightness _brightness;

  @override
  void initState() {
    super.initState();
    page = 0;
    _isLoading = false;
    if (SpUtil.getBool(ChatConsts.isDarkMode)!) {
      _brightness = Brightness.dark;
    } else {
      _brightness = Brightness.light;
    }
    //
    topList.add(ContactInfo(
        id: Constants.contactNewFriend,
        name: 'i18n.contact.new.friend'.tr,
        tagIndex: '↑',
        bgColor: Colors.orange,
        iconData: Icons.person_add));
    topList.add(ContactInfo(
        id: Constants.contactGroupChat,
        name: 'i18n.contact.group.chat'.tr,
        tagIndex: '↑',
        bgColor: Colors.green,
        iconData: Icons.people));
    topList.add(ContactInfo(
        id: Constants.contactTags,
        name: 'i18n.contact.tags'.tr,
        tagIndex: '↑',
        bgColor: Colors.blue,
        iconData: Icons.local_offer));
    topList.add(ContactInfo(
        id: Constants.contactMps,
        name: 'i18n.contact.mps'.tr,
        tagIndex: '↑',
        bgColor: Colors.blueAccent,
        iconData: Icons.person));
    // topList.add(ContactInfo(
    //  id: 'local',
    //     name: 'Local'.tr,
    //     tagIndex: '↑',
    //     bgColor: Colors.blueAccent,
    //     iconData: Icons.person));
    // add topList.
    // contactList.insertAll(0, topList);
    loadFirstPage();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.3,
          // backgroundColor: const Color(0xFFEDEDED),
          title: Text(
            'i18n.contact.title'.tr,
            // style: const TextStyle(color: Color(0xFF171717)),
          ),
        ),
        body: MultiBlocListener(
            listeners: [
              BlocListener<ContactBloc, ContactState>(
                  listener: (context, state) {
                debugPrint(
                    "contact page contactBloc: ${state.status} ${state.contactData}");
                if (state.status.isSuccess) {
                  _isLoading = false;
                  debugPrint("contact page success: ${state.status}");
                  if (state.contactData!.contactList!.isNotEmpty) {
                    // 一次性拉取下来所有联系人
                    debugPrint("contact not empty");
                    // contactList.clear();
                    for (Contact contact in state.contactData!.contactList!) {
                      ContactInfo contactInfo =
                          ContactInfo.fromContact(contact);
                      if (!contactList.contains(contactInfo)) {
                        contactList.add(contactInfo);
                      }
                    }
                    _handleList(contactList);
                  }
                  EasyLoading.dismiss();
                } else if (state.status.isFailure) {
                  _isLoading = false;
                  EasyLoading.showError('i18n.contact.load.error'.tr);
                } else if (state.status.isLoading) {
                  _isLoading = true;
                  // EasyLoading.show();
                }
              }),
              BlocListener<ThemeCubit, ThemeState>(listener: (context, state) {
                debugPrint("thread page themeCubit: ${state.brightness}");
                setState(() {
                  _brightness = state.brightness!;
                });
              })
            ],
            child: AzListView(
              data: contactList,
              itemCount: contactList.length,
              itemBuilder: (BuildContext context, int index) {
                ContactInfo model = contactList[index];
                return CommonUtils.getWeChatItem(
                  context,
                  model,
                  _brightness,
                  // defHeaderBgColor: Colors.white,
                );
              },
              physics: const BouncingScrollPhysics(),
              susItemBuilder: (BuildContext context, int index) {
                ContactInfo model = contactList[index];
                if ('↑' == model.getSuspensionTag()) {
                  return Container();
                }
                return CommonUtils.getSusItem(
                    context, model.getSuspensionTag(), _brightness);
              },
              indexBarData: const ['↑', '☆', ...kIndexBarData],
              indexBarOptions: IndexBarOptions(
                needRebuild: true,
                ignoreDragCancel: true,
                downTextStyle:
                    const TextStyle(fontSize: 12, color: Colors.white),
                downItemDecoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green),
                indexHintWidth: 120 / 2,
                indexHintHeight: 100 / 2,
                indexHintDecoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(CommonUtils.getImgPath(
                        'contact/ic_index_bar_bubble_gray')),
                    fit: BoxFit.contain,
                  ),
                ),
                indexHintAlignment: Alignment.centerRight,
                indexHintChildAlignment: const Alignment(-0.25, 0.0),
                indexHintOffset: const Offset(-20, 0),
              ),
            )));
  }

  void _handleList(List<ContactInfo> list) {
    if (list.isEmpty) return;
    debugPrint("contact handleList");
    //
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(contactList);
    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(contactList);
    // add topList.
    if (!contactList.contains(topList.first)) {
      contactList.insertAll(0, topList);
    }
    setState(() {});
  }

  void loadFirstPage() {
    // EasyLoading.show();
    if (_isLoading) {
      debugPrint('is loading');
      return;
    }
    _isLoading = true;
    page = 0;
    //
    String? orgUid = SpUtil.getString(ChatConsts.orgUid);
    debugPrint("contact page:$orgUid");
    // debugPrint("Loading first page $page, type ${widget.category!.slug}");
    // TODO: 暂时仅拉取前100人，后续再优化
    BlocProvider.of<ContactBloc>(context)
        .add(GetContactEvent(page: page, size: 100));
  }

  @override
  bool get wantKeepAlive => true;

  // void loadMore() {
  //   // EasyLoading.show();
  //   if (_isLoading) {
  //     debugPrint('is loading');
  //     return;
  //   }
  //   _isLoading = true;
  //   page += 1;
  //   // debugPrint("Loading more $page, type ${widget.category!.slug}");
  //   BlocProvider.of<ContactBloc>(context)
  //       .add(GetContactEvent(page: page, size: 100));
  // }
}
