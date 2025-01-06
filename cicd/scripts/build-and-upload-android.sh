#!/usr/bin/bash
###
 # @Author: jackning 270580156@qq.com
 # @Date: 2024-08-07 21:01:08
 # @LastEditors: jackning 270580156@qq.com
 # @LastEditTime: 2024-11-30 08:30:57
 # @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 #   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 #  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 #  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 #  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 #  contact: 270580156@qq.com 
 # 联系：270580156@qq.com
 # Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
### 
# 打包并上传web版到服务器
# 本地路径
DIST=build/app/outputs/flutter-apk
# 服务器地址
SERVER_HOST=124.222.102.45
# 服务器路径
TARGET_DIST=/var/www/html/weiyuai/download/

OUTPUT_FILE=app-release.apk
# 打包，然后上传到服务器
flutter build apk && \
mv ./$DIST/app-release.apk ./$DIST/weiyu-android.apk && \
scp -r ./$DIST/weiyu-android.apk root@$SERVER_HOST:$TARGET_DIST
