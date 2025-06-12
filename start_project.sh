#!/bin/bash

# 设置环境变量
export DEVECO_SDK_HOME=/Applications/DevEco-Studio.app/Contents/sdk

# 运行项目
/Applications/DevEco-Studio.app/Contents/tools/node/bin/node /Applications/DevEco-Studio.app/Contents/tools/hvigor/bin/hvigorw.js --mode module -p module=entry@default -p product=default -p pageType=page -p compileResInc=true -p requiredDeviceType=phone -p previewMode=true -p buildRoot=.preview PreviewBuild --watch --analyze=normal --parallel --incremental --daemon

echo "项目启动完成！" 