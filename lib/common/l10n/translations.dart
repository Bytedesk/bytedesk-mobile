/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 07:24:58
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2025-01-06 16:00:30
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  技术/商务联系：270580156@qq.com
 * Copyright (c) 2025 by bytedesk.com, All Rights Reserved. 
 */
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'translations/en.dart';
import 'translations/zh_cn.dart';
import 'translations/zh_tw.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {'en': en, 'zh_CN': zhCN, 'zh_TW': zhTW};

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('zh', 'CN'),
  ];

  static const fallbackLocale = Locale('en');

  static const localizationsDelegates = [
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate
  ];
}
