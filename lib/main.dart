/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-11 18:26:32
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-11-30 16:24:21
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:im/chat/util/chat_consts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'common/app/app.dart';
import 'common/app/app_bloc_observer.dart';
import 'thread/api/thread_repository.dart';

void main() async {
  //设置debugPaintSizeEnabled为true来更直观的调试布局问题
  // debugPaintSizeEnabled = ChatConsts.isDebug;
  // 显示顶部导航时间
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  // Bloc状态持久化
  Bloc.observer = const AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  // 启动
  runApp(App(
    threadRepository: ThreadRepository(),
  ));
  AssetPicker.registerObserve();
  // Enables logging with the photo_manager.
  PhotoManager.setLog(ChatConsts.isDebug);
}
