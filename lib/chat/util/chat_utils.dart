/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-14 15:07:59
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-11-28 19:37:31
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
import 'dart:convert';
import 'dart:io';

// import 'package:bytedesk_kefu/blocs/profile_bloc/bloc.dart';
import 'package:bytedesk_common/blocs/profile_bloc/bloc.dart';
import 'package:bytedesk_kefu/util/bytedesk_uuid.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/auth/view/auth_provider.dart';
import '../model/user.dart';
import '../mqtt/bytedesk_mqtt.dart';
import 'chat_consts.dart';
// import 'package:intl/intl.dart';

class ChatUtils {
  static bool shouldSendReceipt(String type) {
    if (ChatConsts.MESSAGE_TYPE_TEXT == type ||
        ChatConsts.MESSAGE_TYPE_IMAGE == type ||
        ChatConsts.MESSAGE_TYPE_FILE == type ||
        ChatConsts.MESSAGE_TYPE_AUDIO == type ||
        ChatConsts.MESSAGE_TYPE_VIDEO == type ||
        ChatConsts.MESSAGE_TYPE_STREAM == type) {
      return true;
    }
    return false;
  }

  static bool isSystemMessage(String type) {
    if (ChatConsts.MESSAGE_TYPE_SYSTEM == type ||
        ChatConsts.MESSAGE_TYPE_CONTINUE == type ||
        ChatConsts.MESSAGE_TYPE_AUTO_CLOSED == type ||
        ChatConsts.MESSAGE_TYPE_AGENT_CLOSED == type) {
      return true;
    }
    return false;
  }

  static String shortTimeFormat(String value) {
    DateTime now = DateTime.now(); // 获取当前时间
    DateTime parsedDate = DateTime.parse(value); // 解析给定的时间字符串

    // 检查给定时间是否为今天
    if (parsedDate.year == now.year &&
        parsedDate.month == now.month &&
        parsedDate.day == now.day) {
      // 如果是今天，则只返回小时和分钟
      return "${parsedDate.hour.toString().padLeft(2, '0')}:${parsedDate.minute.toString().padLeft(2, '0')}";
    } else {
      // 否则，返回月-日和小时:分钟
      return "${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')} ${parsedDate.hour.toString().padLeft(2, '0')}:${parsedDate.minute.toString().padLeft(2, '0')}";
    }
  }

  static String getFileType(String filePath) {
    // 获取文件扩展名
    String extension =
        filePath.split('.').last.toLowerCase(); // 转换为小写以确保匹配不受大小写影响

    // 根据扩展名判断文件类型
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'mp4':
        return 'video/mp4';
      case 'webm':
        return 'video/webm';
      case 'ogv':
        return 'video/ogg';
      // 可以继续添加其他文件类型的判断逻辑
      default:
        return 'application/octet-stream'; // 对于未知的文件类型，可以使用这个通用的MIME类型
    }
  }

  //
  static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);
  static bool get isMobile => isAndroid || isIOS;
  static bool get isWeb => kIsWeb;
  static bool get isWindows => Platform.isWindows;
  static bool get isLinux => Platform.isLinux;
  static bool get isMacOS => Platform.isMacOS;
  static bool get isAndroid => Platform.isAndroid;
  static bool get isFuchsia => Platform.isFuchsia;
  static bool get isIOS => Platform.isIOS;

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static String getClient() {
    if (isWeb) {
      return ChatConsts.CLIENT_TYPE_FLUTTER_WEB;
    } else if (isAndroid) {
      return ChatConsts.CLIENT_TYPE_FLUTTER_ANDROID;
    } else if (isIOS) {
      return ChatConsts.CLIENT_TYPE_FLUTTER_IOS;
    } else if (isMacOS) {
      return ChatConsts.CLIENT_TYPE_FLUTTER_MACOS;
    } else if (isWindows) {
      return ChatConsts.CLIENT_TYPE_FLUTTER_WINDOWS;
    } else if (isLinux) {
      return ChatConsts.CLIENT_TYPE_FLUTTER_LINUX;
    } else {
      return ChatConsts.CLIENT_TYPE_FLUTTER;
    }
  }

  static Uri getHostUri(
    String path, [
    Map<String, dynamic>? queryParameters,
  ]) {
    if (ChatConsts.isDebug) {
      return Uri.http(ChatConsts.httpBaseUrl, path, queryParameters);
    } else {
      return Uri.https(ChatConsts.httpBaseUrl, path, queryParameters);
    }
  }

  // 登录
  static bool? isLogin() {
    return SpUtil.getBool(ChatConsts.isLogin);
  }

  //
  static String? getAccessToken() {
    return SpUtil.getString(ChatConsts.accessToken);
  }

  static String? getUid() {
    return SpUtil.getString(ChatConsts.uid);
  }

  static String? getNickname() {
    return SpUtil.getString(ChatConsts.nickname);
  }

  static String? getAvatar() {
    return SpUtil.getString(ChatConsts.avatar);
  }

  static String? getDescription() {
    return SpUtil.getString(ChatConsts.description);
  }

  static bool mqttConnect() {
    var isLogin = SpUtil.getBool(ChatConsts.isLogin);
    if (isLogin!) {
      BytedeskMqtt().connect();
      return true;
    }
    return false;
  }

  static bool mqttReConnect() {
    bool isConnected = BytedeskMqtt().isConnected();
    if (!isConnected) {
      BytedeskMqtt().connect();
      return true;
    }
    return false;
  }

  static bool isMqttConnected() {
    return BytedeskMqtt().isConnected();
  }

  static void mqttDisconnect() {
    BytedeskMqtt().disconnect();
  }

  static String formattedDateNow() {
    var format = DateFormat('yyyy-MM-dd HH:mm:ss');
    return format.format(DateTime.now());
  }

  static String formattedTimestampNow() {
    var format = DateFormat('yyyyMMddHHmmss');
    return format.format(DateTime.now());
  }

  static int currentTimeMillis() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static String getTimeDuration(String comTime) {
    var nowTime = DateTime.now();
    var compareTime = DateTime.parse(comTime);
    if (nowTime.isAfter(compareTime)) {
      if (nowTime.year == compareTime.year) {
        if (nowTime.month == compareTime.month) {
          if (nowTime.day == compareTime.day) {
            // if (nowTime.hour == compareTime.hour) {
            //   if (nowTime.minute == compareTime.minute) {
            //
            return '${compareTime.hour}:${(compareTime.minute < 10) ? '0${compareTime.minute}' : compareTime.minute.toString()}';
            //   }
            //   return (nowTime.minute - compareTime.minute).toString() + '分钟前';
            // }
            // return (nowTime.hour - compareTime.hour).toString() + '小时前';
          }
          return '${nowTime.day - compareTime.day}天前';
        }
        return '${nowTime.month - compareTime.month}月前';
      }
      return '${nowTime.year - compareTime.year}年前';
    }
    return 'time error';
  }

  static Future<void> mylaunchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  // https://pub.dev/packages/url_launcher/example
  static Future<void> launchInBrowserString(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  // 退出登录
  static void exitLogin(BuildContext context) {
    // 友盟统计：取消用户账号
    // UmengCommonSdk.onProfileSignOff();
    // 清空本地
    // SpUtil.putBool(ChatConsts.isLogin, false);
    // SpUtil.clear();
    // NavigatorUtils.push(context, LoginRouter.loginPage, clearStack: true);
  }

  // 显示登录界面
  static void showAuth(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const AuthProvider();
      }));
    });
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //   return const AuthProvider();
    // }));
  }

  static void getProfile(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
  }

  static void saveUserCache(User user) {
    SpUtil.putString(ChatConsts.uid, user.uid!);
    SpUtil.putString(ChatConsts.username, user.username!);
    SpUtil.putString(ChatConsts.nickname, user.nickname!);
    SpUtil.putString(ChatConsts.avatar, user.avatar!);
    SpUtil.putString(ChatConsts.description, user.description!);
    SpUtil.putString(ChatConsts.orgUid, user.currentOrganization!.uid!);
    SpUtil.putString(ChatConsts.deviceUid, BytedeskUuid.uuid());
    SpUtil.putString(ChatConsts.mobile, user.mobile!);
    SpUtil.putString(ChatConsts.userInfo, jsonEncode(user));
  }

  // 清空本地缓存
  static void clearUserCache() {
    //
    SpUtil.putString(ChatConsts.uid, '');
    SpUtil.putString(ChatConsts.username, '');
    SpUtil.putString(ChatConsts.nickname, '');
    SpUtil.putString(ChatConsts.avatar, '');
    SpUtil.putString(ChatConsts.description, '');
    SpUtil.putString(ChatConsts.mobile, '');
    //
    SpUtil.putBool(ChatConsts.isLogin, false);
    SpUtil.putString(ChatConsts.mobile, '');
    SpUtil.putString(ChatConsts.accessToken, '');
  }
}
