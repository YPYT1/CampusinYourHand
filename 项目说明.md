# 掌上校园活动预约 HarmonyOS App 项目

## 📱 项目概述

这是一个基于 HarmonyOS 开发的校园活动预约应用，采用模块化开发方式，支持多人协作开发。

## 🏗️ 项目结构

```
entry/src/main/ets/
├── pages/                    # 页面文件
│   ├── Index.ets            # 主框架页面（底部导航 + 路由管理）✅ 已完成
│   ├── HomePage.ets         # 首页模块（负责人：杨林森）🚧 待开发
│   ├── ActivityPage.ets     # 活动预约模块（负责人：吴贵兴）🚧 待开发
│   ├── RecordsPage.ets      # 预约记录模块（负责人：杨洋）🚧 待开发
│   └── ProfilePage.ets      # 个人中心模块（负责人：罗嘉欣）🚧 待开发
├── common/                  # 公共资源
│   ├── components/          # 公共组件库
│   │   ├── CommonCard.ets   # 通用卡片组件 ✅
│   │   └── CommonButton.ets # 通用按钮组件 ✅
│   ├── constants/           # 常量定义
│   │   └── AppConstants.ets # 应用常量（颜色、尺寸等）✅
│   └── utils/              # 工具函数
│       └── CommonUtils.ets  # 通用工具函数 ✅
└── model/                   # 数据模型
    └── DataModels.ets       # 数据结构定义 ✅
```

## 🎨 设计规范

### 颜色规范
- **主色调**: `#007AFF` (HarmonyOS蓝)
- **成功色**: `#34C759` (绿色)
- **警告色**: `#FF3B30` (红色)
- **背景色**: `#F2F2F7` (浅灰)
- **卡片背景**: `#FFFFFF` (白色)
- **主要文字**: `#1C1C1E` (深色)
- **次要文字**: `#8E8E93` (灰色)

### 尺寸规范
- **圆角**: 卡片12px, 按钮8px
- **间距**: 8px, 16px, 24px, 32px
- **字体**: 10px(小), 14px(常规), 16px(中), 18px(大), 24px(标题)

## 👥 团队分工

| 成员 | 负责模块 | 文件名 | 核心功能 |
|------|----------|---------|----------|
| **杨林森** | 首页模块 | `HomePage.ets` | 活动展示、搜索、快捷入口 |
| **吴贵兴** | 活动预约 | `ActivityPage.ets` | 活动详情、预约表单、确认流程 |
| **杨洋** | 预约记录 | `RecordsPage.ets` | 记录管理、状态更新、二维码 |
| **罗嘉欣** | 个人中心 | `ProfilePage.ets` | 用户资料、设置、统计信息 |

## 🚀 快速开始

### 1. 当前项目状态
- ✅ 主框架已完成（底部导航栏 + 页面路由）
- ✅ 公共组件库已建立
- ✅ 设计规范已统一
- ✅ 数据模型已定义
- 🚧 4个页面模块等待各成员开发

### 2. 开发流程
1. **各成员克隆项目**到本地
2. **只修改自己负责的页面文件**（如 `HomePage.ets`）
3. **使用公共组件和常量**，保持界面一致性
4. **提交代码前测试**页面功能和跳转
5. **合并代码**，完成最终项目

### 3. 使用公共组件示例

```typescript
import { CommonCard } from '../common/components/CommonCard'
import { CommonButton, ButtonType } from '../common/components/CommonButton'
import { AppColors, AppSizes } from '../common/constants/AppConstants'

// 使用通用卡片
CommonCard({ title: '活动信息' }) {
  Text('活动内容')
    .fontSize(AppSizes.FONT_BASE)
    .fontColor(AppColors.TEXT_PRIMARY)
}

// 使用通用按钮
CommonButton({
  text: '确认预约',
  type: ButtonType.PRIMARY,
  onClickCallback: () => {
    // 点击处理逻辑
  }
})
```

## 📋 开发指南

### 页面开发要点

#### HomePage.ets（杨林森）
- 实现渐变色头部背景
- 添加搜索框和快捷入口网格
- 显示热门活动卡片列表
- 处理活动点击跳转到详情页

#### ActivityPage.ets（吴贵兴）
- 显示活动详情信息
- 实现预约表单（姓名、学号、联系方式）
- 添加表单验证逻辑
- 处理预约提交确认

#### RecordsPage.ets（杨洋）
- 实现Tab切换（已预约、已参加、已取消、过期）
- 显示时间轴样式的记录列表
- 添加操作按钮（取消预约、查看二维码）
- 处理状态更新逻辑

#### ProfilePage.ets（罗嘉欣）
- 显示用户信息头部
- 实现统计数据展示
- 添加设置菜单列表
- 支持子页面跳转和返回

### 注意事项
1. **只修改自己的页面文件**，不要改动其他文件
2. **使用已定义的常量**，保持设计一致性
3. **参考原型图设计**，确保界面效果
4. **添加必要的注释**，便于代码维护
5. **测试页面功能**，确保无错误

## 🔧 技术要点

### 底部导航实现
- 使用 `Tabs` 组件实现页面切换
- 自定义 `TabBar` 样式匹配设计稿
- SVG图标支持状态变色
- 页面切换动画效果

### 状态管理
- 使用 `@State` 管理页面状态
- 使用 `@Prop` 传递组件属性
- 合理使用 `@Builder` 构建复用组件

### 样式规范
- 统一使用 `AppColors` 和 `AppSizes` 常量
- 保持组件样式一致性
- 响应式布局适配不同屏幕

## 📞 联系方式

如有开发问题，请及时沟通交流，确保项目进度和质量。

---

**祝开发顺利！🎉** 