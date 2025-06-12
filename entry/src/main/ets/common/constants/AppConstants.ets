/**
 * 应用常量定义
 * 包含颜色、尺寸、间距等设计规范
 */

export class AppColors {
  // 主色调
  static readonly PRIMARY = '#007AFF'        // HarmonyOS蓝
  static readonly SUCCESS = '#34C759'        // 成功绿
  static readonly WARNING = '#FF3B30'        // 警告红
  static readonly INFO = '#5856D6'           // 信息紫

  // 背景色
  static readonly BG_PRIMARY = '#F2F2F7'     // 主背景色
  static readonly BG_CARD = '#FFFFFF'        // 卡片背景色
  static readonly BG_SECONDARY = '#EFEFF4'   // 次要背景色

  // 文字颜色
  static readonly TEXT_PRIMARY = '#1C1C1E'   // 主要文字
  static readonly TEXT_SECONDARY = '#8E8E93' // 次要文字
  static readonly TEXT_PLACEHOLDER = '#C7C7CC' // 占位符文字
  static readonly TEXT_WHITE = '#FFFFFF'     // 白色文字

  // 分割线颜色
  static readonly DIVIDER = '#E5E5EA'        // 分割线

  // 快捷入口背景色
  static readonly ENTRY_ORANGE = '#FF9500'
  static readonly ENTRY_GREEN = '#34C759'
  static readonly ENTRY_BLUE = '#5856D6'
  static readonly ENTRY_TEAL = '#5AC8FA'
}

export class AppSizes {
  // 字体大小
  static readonly FONT_XS = 10
  static readonly FONT_SM = 12
  static readonly FONT_BASE = 14
  static readonly FONT_LG = 16
  static readonly FONT_XL = 18
  static readonly FONT_2XL = 20
  static readonly FONT_3XL = 22
  static readonly FONT_4XL = 24

  // 圆角大小
  static readonly RADIUS_XS = 4
  static readonly RADIUS_SM = 6
  static readonly RADIUS_BASE = 8
  static readonly RADIUS_LG = 12
  static readonly RADIUS_XL = 16
  static readonly RADIUS_FULL = 999

  // 间距大小
  static readonly SPACING_XS = 4
  static readonly SPACING_SM = 8
  static readonly SPACING_BASE = 12
  static readonly SPACING_LG = 16
  static readonly SPACING_XL = 20
  static readonly SPACING_2XL = 24
  static readonly SPACING_3XL = 32
  static readonly SPACING_4XL = 40

  // 图标大小
  static readonly ICON_XS = 16
  static readonly ICON_SM = 20
  static readonly ICON_BASE = 24
  static readonly ICON_LG = 28
  static readonly ICON_XL = 32

  // TabBar相关
  static readonly TAB_BAR_HEIGHT = 83
  static readonly TAB_ICON_SIZE = 24
  static readonly TAB_FONT_SIZE = 10
}

export class AppStrings {
  // Tab标题
  static readonly TAB_HOME = '首页'
  static readonly TAB_ACTIVITY = '活动'
  static readonly TAB_RECORDS = '记录'
  static readonly TAB_PROFILE = '我的'

  // 通用文字
  static readonly LOADING = '加载中...'
  static readonly NO_DATA = '暂无数据'
  static readonly NETWORK_ERROR = '网络错误'
  static readonly CONFIRM = '确认'
  static readonly CANCEL = '取消'
} 