import router from '@ohos.router'
import prompt from '@ohos.prompt'

@Entry
@Component
export struct QuickBookingPage {
  @State selectedDate: string = '2024-01-15'
  @State selectedTime: string = '14:00'
  @State selectedService: string = '学术报告厅'
  @State purpose: string = ''

  build() {
    Column() {
      // 头部导航
      Row() {
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        
        Text('快捷预约')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          
        Text('')
          .width(24)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          // 预约类型选择
          Column() {
            Text('预约类型')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .alignSelf(ItemAlign.Start)
              .margin({ bottom: 12 })

            Grid() {
              GridItem() {
                this.ServiceCard('学术报告厅', '🎭', this.selectedService === '学术报告厅')
                  .onClick(() => {
                    this.selectedService = '学术报告厅'
                  })
              }
              
              GridItem() {
                this.ServiceCard('会议室', '💼', this.selectedService === '会议室')
                  .onClick(() => {
                    this.selectedService = '会议室'
                  })
              }
              
              GridItem() {
                this.ServiceCard('实验室', '🔬', this.selectedService === '实验室')
                  .onClick(() => {
                    this.selectedService = '实验室'
                  })
              }
              
              GridItem() {
                this.ServiceCard('体育场馆', '⚽', this.selectedService === '体育场馆')
                  .onClick(() => {
                    this.selectedService = '体育场馆'
                  })
              }
            }
            .columnsTemplate('1fr 1fr')
            .rowsTemplate('1fr 1fr')
            .columnsGap(12)
            .rowsGap(12)
            .height(180)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ bottom: 16 })

          // 日期时间选择
          Column() {
            Text('预约时间')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .alignSelf(ItemAlign.Start)
              .margin({ bottom: 12 })

            Row() {
              Column() {
                Text('日期')
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ bottom: 8 })
                
                Text(this.selectedDate)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                  .backgroundColor('#F5F5F5')
                  .borderRadius(8)
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Column() {
                Text('时间')
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ bottom: 8 })
                
                Text(this.selectedTime)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                  .backgroundColor('#F5F5F5')
                  .borderRadius(8)
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ bottom: 16 })

          // 预约用途
          Column() {
            Text('预约用途')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .alignSelf(ItemAlign.Start)
              .margin({ bottom: 12 })

            TextArea({ placeholder: '请输入预约用途', text: this.purpose })
              .fontSize(14)
              .height(100)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .onChange((value: string) => {
                this.purpose = value
              })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ bottom: 32 })

          // 提交按钮
          Button('提交预约')
            .width('100%')
            .height(48)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .backgroundColor('#007AFF')
            .borderRadius(24)
            .margin({ bottom: 32 })
            .onClick(() => {
              prompt.showToast({
                message: '预约提交成功！',
                duration: 2000
              })
              router.back()
            })
        }
        .padding(16)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  ServiceCard(title: string, icon: string, isSelected: boolean) {
    Column() {
      Text(icon)
        .fontSize(32)
        .margin({ bottom: 8 })
      
      Text(title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? '#007AFF' : '#333333')
    }
    .width('100%')
    .height(80)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(isSelected ? '#E3F2FD' : '#F9F9F9')
    .borderRadius(12)
    .border({
      width: 2,
      color: isSelected ? '#007AFF' : 'transparent'
    })
  }
} 