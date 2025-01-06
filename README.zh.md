<!--
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-11 21:31:02
 * @LastEditors: jack ning github@bytedesk.com
 * @LastEditTime: 2025-01-06 12:43:11
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
-->
# 微语

- 微语是一款基于Flutter开发的聊天工具，支持iOS、Android、Web端。
  
## 功能点

## 工具

- 下载图标：<https://www.iconfont.cn/>
<!-- - 蒲公英制作图标：<https://www.pgyer.com/tools/appIcon> -->
- 美图自己制作图标：<https://pc.meitu.com/image/edit/?from=icon>
- 图标生成各种尺寸：<https://icon.wuruihong.com/>
- 微信分享申请：<https://open.weixin.qq.com/>

## 打包发布

- apple store: <https://apps.apple.com/app/id6446348460>
- uniLinks: <https://www.chaty.cn/links/>

## 设置代理

```bash
# flutter 与最新android studio ladybug不兼容，修改其sdk版本
flutter config --jdk-dir="/Library/Java/JavaVirtualMachines/jdk-17.0.4.jdk/Contents/Home"
# 设置代理
export http_proxy=http://127.0.0.1:10818
export https_proxy=http://127.0.0.1:10818
# 创建项目
flutter create --org com.kefux im
# 本地测试
flutter run
# 真机测试：
flutter run --release
# 升级
flutter upgrade
# 升级依赖包
flutter pub upgrade
flutter pub upgrade --major-versions
# 截图
flutter screenshot
# 增加linux平台支持
flutter create -t plugin --platforms linux .
```

## 安卓

```bash
# vscode安装扩展插件Android iOS Emulator，快捷键：
# Cmd-Shift-P and type Emulator，选择 Android Emulator
# 
# https://docs.flutter.dev/deployment/android
# 打包发布
# https://docs.flutter.dev/deployment/android#review-the-gradle-build-configuration
# flutter run
# flutter run -d android --release
# [打包apk](https://flutterchina.club/android-release/)
# 手动删除build文件夹
flutter build apk
# AppBundle for Google Play
# flutter build appbundle
cd android 
# then
# fastlane [name of the lane you created].
# 或 使用android studio打开项目，然后打包apk
# 测试安装：
# adb install ./build/app/outputs/apk/release/app-release.apk
flutter install
# 自动打包并上传服务器：
sh cicd/scripts/build-and-upload-android.sh
sh cicd/scripts/upload-android.sh
# fastlane
# https://docs.flutter.dev/deployment/cd#fastlane
# [18:44:18]: ------------------------------
# [18:44:18]: --- Where to go from here? ---
# [18:44:18]: ------------------------------
# [18:44:18]: 📸  Learn more about how to automatically generate localized Google Play screenshots:
# [18:44:18]:             https://docs.fastlane.tools/getting-started/android/screenshots/
# [18:44:18]: 👩‍✈️  Learn more about distribution to beta testing services:
# [18:44:18]:             https://docs.fastlane.tools/getting-started/android/beta-deployment/
# [18:44:18]: 🚀  Learn more about how to automate the Google Play release process:
# [18:44:18]:             https://docs.fastlane.tools/getting-started/android/release-deployment/
# [18:44:18]: 
# [18:44:18]: To try your new fastlane setup, just enter and run
# [18:44:18]: $ fastlane test
```

### iOS

```bash
# vscode安装扩展插件Android iOS Emulator，快捷键：
# Cmd-Shift-P and type Emulator，选择 iOS Emulator
# https://docs.flutter.dev/deployment/ios
# 手机上运行：
flutter run --release
# [打包ios](https://flutter.cn/docs/deployment/ios)
# 自动打包：sh cicd/scripts/release-ios.sh
#  调整截图尺寸：https://www.yunedit.com/update/jietu/index -->
#  screenshots: https://developer.apple.com/app-store/product-page/ -->
#  flutter build ios -->
#  打开xcode, 生成archive, 验证&上传 -->
flutter build ipa
# cd ios 
# then 
# fastlane [name of the lane you created].
# 在 Xcode 中打开: 
open build/ios/archive/Runner.xcarchive
# 点击 Validate App
# 点击 Distribute App
# 通过以下命令启动模拟器，并进行截图上传APP store：
# 直接在程序坞中打开模拟器, 如果没有相应模拟器，打开xcode，添加相应模拟器
#  屏幕尺寸大全：https://uiiiuiii.com/screen/ -->
# 6.7 英寸：13 pro max
# 6.5 英寸：11 pro max
# 5.5 英寸：8 plus
# 12.9 ipad 直接使用 ipad 第6代即可
# 在模拟器运行程序，截图
# fastlane 
# https://docs.flutter.dev/deployment/cd#fastlane
# [18:44:33]: ------------------------------
# [18:44:33]: --- Where to go from here? ---
# [18:44:33]: ------------------------------
# [18:44:33]: 📸  Learn more about how to automatically generate localized App Store screenshots:
# [18:44:33]:             https://docs.fastlane.tools/getting-started/ios/screenshots/
# [18:44:33]: 👩‍✈️  Learn more about distribution to beta testing services:
# [18:44:33]:             https://docs.fastlane.tools/getting-started/ios/beta-deployment/
# [18:44:33]: 🚀  Learn more about how to automate the App Store release process:
# [18:44:33]:             https://docs.fastlane.tools/getting-started/ios/appstore-deployment/
# [18:44:33]: 👩‍⚕️  Learn more about how to setup code signing with fastlane
# [18:44:33]:             https://docs.fastlane.tools/codesigning/getting-started/
# [18:44:33]: 
# [18:44:33]: To try your new fastlane setup, just enter and run
# [18:44:33]: $ fastlane release
```

### Web

```bash
# https://docs.flutter.dev/deployment/web
# 其余两种会导致图片跨域，加载报错问题，只能使用 --web-renderer html -->
flutter build web --web-renderer html
flutter build web
flutter build web --web-renderer canvaskit
# 然后修改build/web/index.html中 <base href="/flutter/"> 指向具体路径
```

### macos

```bash
# https://docs.flutter.dev/deployment/macos
# 运行：
flutter run -d macos
# 发布：
flutter build macos
# 然后到 build/macos/Build/Products/Release 文件夹复制 微同步.app文件即可
```

### windows

```bash
# https://docs.flutter.dev/deployment/windows
flutter build windows
```

## 其他

```bash
如何解决iOS打包上架问题？
# SDK直接运行无问题，但发布时报错“Unsupported Architecture. Your executable contains unsupported architecture '[x86_64]...”。
cd Pods/ScanKitFrameWork/ScanKitFrameWork.framework
# 使用lipo -info 可以查看包含的架构
lipo -info ScanKitFrameWork  # Architectures in the fat file: ScanKitFrameWork are: x86_64 arm64
# 移除x86_64
lipo -remove x86_64 ScanKitFrameWork -o ScanKitFrameWork
# 再次查看
lipo -info  ScanKitFrameWork # Architectures in the fat file: ScanKitFrameWork are: arm64
```
