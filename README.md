# HarmonyOS 掌上校园活动预约系统

[![HarmonyOS](https://img.shields.io/badge/HarmonyOS-NEXT-blue.svg)](https://developer.harmonyos.com)
[![ArkTS](https://img.shields.io/badge/Language-ArkTS-green.svg)](https://developer.harmonyos.com/cn/docs/documentation/doc-guides/ts-based-syntax-0000001127164115)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 📖 项目简介

**掌上校园** 是一款专为高校学生设计的活动预约App，基于最新的 **HarmonyOS NEXT** 平台，并采用 **ArkTS** 语言和 **ArkUI** 声明式UI框架进行开发。

本应用旨在为学生提供一个便捷的校园活动信息聚合与报名平台，通过现代化的UI设计和流畅的用户体验，简化活动发现、报名和管理流程。项目采用模块化架构，职责清晰，具有良好的可维护性和扩展性。

## ✨ 主要功能

- **丰富首页**：聚合展示最新的热门活动，提供活动搜索和分类快捷入口。
- **活动预约**：查看活动详细信息，填写并提交预约表单，完成在线报名。
- **记录管理**：以时间轴形式清晰展示用户的预约记录，并按状态（已预约、已参加、已取消）分类。
- **个人中心**：管理个人资料、查看参与活动统计、进行应用设置。
- **沉浸式体验**：无边框的UI设计，提供优异的视觉和交互体验。

## 📸 应用截图

| 首页 | 活动预约 |
| :---: | :---: |
| *在此处添加截图* | *在此处添加截图* |
| **预约记录** | **个人中心** |
| *在此处添加截图* | *在此处添加截图* |

## 🛠️ 技术栈

- **开发平台**: HarmonyOS NEXT
- **开发语言**: ArkTS
- **UI框架**: ArkUI (声明式开发范式)
- **状态管理**: @State, @Prop, @Link, AppStorage
- **项目架构**: 分层模块化架构
- **开发工具**: DevEco Studio

## 🏗️ 项目结构

项目采用模块化开发，结构清晰，便于团队协作和后期维护。

```
entry/src/main/ets/
├── pages/                    # 页面文件
│   ├── Index.ets            # 主框架页面（底部导航 + 路由管理）✅ 已完成
│   ├── HomePage.ets         # 首页模块 ✅ 已完成
│   ├── ActivityPage.ets     # 活动预约模块 ✅ 已完成
│   ├── RecordsPage.ets      # 预约记录模块 ✅ 已完成
│   └── ProfilePage.ets      # 个人中心模块 ✅ 已完成
├── common/                  # 公共资源
│   ├── components/          # 公共组件库
│   ├── constants/           # 常量定义
│   └── utils/               # 工具函数
└── model/                   # 数据模型
    └── DataModels.ets       # 数据结构定义
```

## 🚀 快速上手

### 环境要求
- **DevEco Studio**: 推荐使用最新版本
- **SDK**: HarmonyOS NEXT (API 10+)

### 安装与运行
1. **克隆项目到本地**:
   ```bash
   git clone https://github.com/your-username/your-repository-name.git
   ```
2. **打开项目**:
   - 启动 DevEco Studio。
   - 选择 `File > Open`，然后选择克隆下来的项目文件夹。
3. **运行项目**:
   - 等待项目同步和构建完成。
   - 连接真机或启动模拟器。
   - 点击 `Run > Run 'entry'` 即可在设备上运行本应用。

## 📋 开发规范

为保证代码质量和项目可维护性，开发过程遵循以下规范：

### 设计规范
- **主色调**: `#007AFF` (HarmonyOS蓝)
- **成功色**: `#34C759` (绿色)
- **警告色**: `#FF3B30` (红色)
- **背景色**: `#F2F2F7` (浅灰)
- **圆角**: 卡片12px, 按钮8px
- **间距**: 8px, 16px, 24px, 32px
- **字体**: 10px(小), 14px(常规), 16px(中), 18px(大), 24px(标题)

### 编码规范
- **命名规范**: 遵循ArkTS官方推荐的命名约定，使用有意义的变量和函数名。
- **注释标准**: 对核心业务逻辑和复杂组件添加必要的注释。
- **代码结构**: 保持模块化和组件化，高内聚、低耦合。
- **公共资源**: 优先使用 `common` 目录下的公共组件、常量和工具函数，避免重复造轮子。

## 🤝 贡献指南

我们欢迎所有形式的贡献，无论是报告问题、提交代码还是提出改进建议。

1. **Fork 本仓库**
2. **创建您的特性分支**: `git checkout -b feature/AmazingFeature`
3. **提交您的更改**: `git commit -m 'Add some AmazingFeature'`
4. **推送到分支**: `git push origin feature/AmazingFeature`
5. **创建 Pull Request**

## 📄 许可证

本项目采用 [MIT License](LICENSE) 许可证。

## 🙏 致谢

感谢每一位为项目做出贡献的开发者，也感谢开源社区提供的优秀资源。

---

**祝您使用愉快！🎉** 