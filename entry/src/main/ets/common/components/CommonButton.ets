import { AppColors, AppSizes } from '../constants/AppConstants'

/**
 * 按钮类型枚举
 */
export enum ButtonType {
  PRIMARY = 'primary',
  SECONDARY = 'secondary',
  WARNING = 'warning',
  SUCCESS = 'success'
}

/**
 * 通用按钮组件
 * 提供多种样式的按钮选择
 */
@Component
export struct CommonButton {
  label: string | Resource = '';
  type: string = 'default';
  @Prop buttonWidth: string | number = '100%';
  @Prop buttonHeight: number = 48;
  @Prop buttonBorderRadius: number = 24;
  @Prop disabled: boolean = false;
  onClickCallback?: () => void;

  build() {
    Button(this.label)
      .width(this.buttonWidth)
      .height(this.buttonHeight)
      .borderRadius(this.buttonBorderRadius)
      .backgroundColor(this.getBackgroundColor())
      .fontColor(this.getTextColor())
      .fontSize(this.getFontSize())
      .fontWeight(this.getFontWeight())
      .stateEffect(true)
      .enabled(!this.disabled)
      .onClick(() => {
        if (this.onClickCallback) {
          this.onClickCallback();
        }
      })
  }

  private getBackgroundColor(): string {
    if (this.disabled) {
      return AppColors.TEXT_PLACEHOLDER;
    }

    switch (this.type) {
      case 'primary':
        return AppColors.PRIMARY;
      case 'danger':
        return AppColors.WARNING;
      case 'secondary':
        return AppColors.BG_SECONDARY;
      case 'link':
        return 'transparent';
      default:
        return AppColors.PRIMARY;
    }
  }

  private getTextColor(): string {
    switch (this.type) {
      case 'secondary':
        return this.disabled ? AppColors.TEXT_PLACEHOLDER : AppColors.TEXT_PRIMARY;
      case 'link':
        return AppColors.PRIMARY;
      default:
        return AppColors.TEXT_WHITE;
    }
  }

  private getFontSize(): number {
    return AppSizes.FONT_LG;
  }

  private getFontWeight(): number | FontWeight {
    return FontWeight.Medium;
  }
} 