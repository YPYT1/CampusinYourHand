import { AppColors, AppSizes } from '../constants/AppConstants'

@Component
export struct StatusBar {
  @State currentTime: string = '10:24'
  @State barHeight: number = 44

  aboutToAppear() {
    // 从global获取状态栏高度，如果没有则使用默认值
    if (globalThis.AppStorage && globalThis.AppStorage['statusBarHeight']) {
      this.barHeight = globalThis.AppStorage['statusBarHeight'];
    } else {
      this.barHeight = 44; // 默认状态栏高度
    }
  }

  build() {
    Row() {
      Text(this.currentTime)
        .fontSize(AppSizes.FONT_BASE)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.TEXT_PRIMARY)
      
      Blank()
      
      Row() {
        Text('📶')
          .fontSize(AppSizes.ICON_XS)
          .fontColor(AppColors.TEXT_PRIMARY)
        Text('🔋')
          .fontSize(AppSizes.ICON_XS)
          .fontColor(AppColors.TEXT_PRIMARY)
      }
    }
    .width('100%')
    .height(this.barHeight)
    .padding({ left: AppSizes.SPACING_LG, right: AppSizes.SPACING_LG })
    .backgroundColor('transparent')
  }
} 