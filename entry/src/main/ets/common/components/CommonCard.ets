import { AppColors, AppSizes } from '../constants/AppConstants'

/**
 * 通用卡片组件
 * 提供一致的卡片样式和布局
 */
@Component
export struct CommonCard {
  @Prop title: string = ''
  @Prop cardPadding: number | Padding = AppSizes.SPACING_LG;
  @Prop cardMargin: number | Margin = 0;
  @Prop cardBackgroundColor: string = AppColors.BG_CARD;
  @Prop cardBorderRadius: number | BorderRadiuses = AppSizes.RADIUS_LG;
  @BuilderParam content: () => void

  build() {
    Column() {
      if (this.title) {
        Text(this.title)
          .fontSize(AppSizes.FONT_XL)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.TEXT_PRIMARY)
          .margin({ bottom: AppSizes.SPACING_BASE })
          .width('100%')
          .textAlign(TextAlign.Start)
      }

      this.content()
    }
    .backgroundColor(this.cardBackgroundColor)
    .borderRadius(this.cardBorderRadius)
    .padding(this.cardPadding)
    .margin(this.cardMargin)
    .width('100%')
    .shadow({
      radius: 8,
      color: 'rgba(0,0,0,0.08)',
      offsetX: 0,
      offsetY: 2
    })
  }
} 