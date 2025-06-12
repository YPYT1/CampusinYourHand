import { AppColors, AppSizes } from '../constants/AppConstants'

interface GlobalStorage {
  statusBarHeight?: number;
}

@Component
export struct StatusBar {
  @State barHeight: number = 44

  aboutToAppear() {
    // 从global获取状态栏高度，如果没有则使用默认值
    const height = (globalThis as GlobalStorage).statusBarHeight;
    if (height) {
      this.barHeight = height;
    } else {
      this.barHeight = 44; // 默认状态栏高度
    }
  }

  build() {
    // 只保留高度占位，不显示任何内容
    Row()
    .width('100%')
      .height(this.barHeight)
      .backgroundColor('transparent')
  }
} 