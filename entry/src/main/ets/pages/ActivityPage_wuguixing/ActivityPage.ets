import router from '@ohos.router'
import { CommonButton } from '../../common/components/CommonButton'

@Entry
@Component
export struct ActivityPage {
  @State name: string = ''
  @State studentId: string = ''
  @State phone: string = ''
  
  build() {
    Scroll() {
      Column() {
        // 顶部活动封面和标题
        Stack({ alignContent: Alignment.Bottom }) {
          // 使用蓝色渐变背景替代图片
          Row()
            .width('100%')
            .height(200)
            .borderRadius({ topLeft: 16, topRight: 16 })
            .linearGradient({
              angle: 135,
              colors: [['#007AFF', 0.0], ['#00C6FF', 1.0]]
            })
          
          Column() {
            Text('HarmonyOS 技术分享会')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
            
            Row() {
              Image('https://cdn-icons-png.flaticon.com/128/2784/2784459.png')
                .width(16)
                .height(16)
              Text('今天 19:00 - 21:00')
                .fontSize(14)
                .fontColor(Color.White)
                .margin({ left: 4 })
            }
            .margin({ top: 8, bottom: 8 })

            Row() {
              Image('https://cdn-icons-png.flaticon.com/128/2838/2838912.png')
                .width(16)
                .height(16)
              Text('教学楼 B201')
                .fontSize(14)
                .fontColor(Color.White)
                .margin({ left: 4 })
            }
          }
          .width('100%')
          .padding(16)
          .backgroundImage('linear-gradient(180deg, rgba(0,0,0,0) 0%, rgba(0,0,0,0.7) 100%)')
        }
        .margin({ bottom: 16 })

        // 剩余名额显示
        Row() {
          Text('剩余名额')
            .fontSize(16)
            .fontColor('#666666')
          Text('23/100')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#007AFF')
            .margin({ left: 8 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: 20 })

        // 主办方信息
        Column() {
          Row() {
            Image('https://cdn-icons-png.flaticon.com/128/1068/1068727.png')
              .width(24)
              .height(24)
            Text('主办方')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .margin({ left: 8 })
          }
          .margin({ bottom: 12 })

          Text('计算机学院 & HarmonyOS 技术俱乐部')
            .fontSize(15)
            .fontColor('#333333')
        }
        .width('100%')
        .padding(16)
        .backgroundColor(Color.White)
        .borderRadius(12)
        .margin({ bottom: 16 })

        // 特邀嘉宾
        Column() {
          Row() {
            Image('https://cdn-icons-png.flaticon.com/128/1828/1828884.png')
              .width(24)
              .height(24)
            Text('特邀嘉宾')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .margin({ left: 8 })
          }
          .margin({ bottom: 16 })

          Row() {
            Column() {
              Image('https://cdn-icons-png.flaticon.com/128/4140/4140048.png')
                .width(64)
                .height(64)
                .borderRadius(32)
              Text('王教授')
                .fontSize(14)
                .margin({ top: 8 })
              Text('系统架构专家')
                .fontSize(12)
                .fontColor('#666666')
                .margin({ top: 4 })
            }

            Column() {
              Image('https://cdn-icons-png.flaticon.com/128/4140/4140047.png')
                .width(64)
                .height(64)
                .borderRadius(32)
              Text('李学姐')
                .fontSize(14)
                .margin({ top: 8 })
              Text('资深开发者')
                .fontSize(12)
                .fontColor('#666666')
                .margin({ top: 4 })
            }
            .margin({ left: 32, right: 32 })

            Column() {
              Image('https://cdn-icons-png.flaticon.com/128/4140/4140051.png')
                .width(64)
                .height(64)
                .borderRadius(32)
              Text('张学长')
                .fontSize(14)
                .margin({ top: 8 })
              Text('技术总监')
                .fontSize(12)
                .fontColor('#666666')
                .margin({ top: 4 })
            }
          }
        }
        .width('100%')
        .padding(16)
        .backgroundColor(Color.White)
        .borderRadius(12)
        .margin({ bottom: 16 })

        // 活动流程
        Column() {
          Row() {
            Image('https://cdn-icons-png.flaticon.com/128/3652/3652191.png')
              .width(24)
              .height(24)
            Text('活动流程')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .margin({ left: 8 })
          }
          .margin({ bottom: 16 })

          Column({ space: 24 }) {
            Row() {
              Circle({ width: 12, height: 12 })
                .fill('#007AFF')
              Column() {
                Text('19:00 - 19:15')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                Text('开场与介绍')
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ left: 12 })
            }

            Row() {
              Circle({ width: 12, height: 12 })
                .fill('#007AFF')
              Column() {
                Text('19:15 - 20:30')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                Text('HarmonyOS 核心技术分享')
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ left: 12 })
            }

            Row() {
              Circle({ width: 12, height: 12 })
                .fill('#007AFF')
              Column() {
                Text('20:30 - 21:00')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                Text('Q&A 互动环节')
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ left: 12 })
            }
          }
        }
        .width('100%')
        .padding(16)
        .backgroundColor(Color.White)
        .borderRadius(12)
        .margin({ bottom: 16 })

        // 注意事项
        Column() {
          Row() {
            Image('https://cdn-icons-png.flaticon.com/128/1827/1827301.png')
              .width(24)
              .height(24)
            Text('注意事项')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .margin({ left: 8 })
          }
          .margin({ bottom: 16 })

          Column({ space: 12 }) {
            Row() {
              Circle({ width: 4, height: 4 })
                .fill('#666666')
              Text('请提前10分钟到场签到')
                .fontSize(14)
                .fontColor('#666666')
                .margin({ left: 8 })
            }

            Row() {
              Circle({ width: 4, height: 4 })
                .fill('#666666')
              Text('现场提供免费纪念品')
                .fontSize(14)
                .fontColor('#666666')
                .margin({ left: 8 })
            }

            Row() {
              Circle({ width: 4, height: 4 })
                .fill('#666666')
              Text('请将手机调至静音模式')
                .fontSize(14)
                .fontColor('#666666')
                .margin({ left: 8 })
            }
          }
        }
        .width('100%')
        .padding(16)
        .backgroundColor(Color.White)
        .borderRadius(12)
        .margin({ bottom: 16 })

        // 填写信息
        Column() {
          Row() {
            Image('https://cdn-icons-png.flaticon.com/128/3064/3064155.png')
              .width(24)
              .height(24)
            Text('填写信息')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .margin({ left: 8 })
          }
          .margin({ bottom: 16 })

          TextInput({ placeholder: '请输入您的真实姓名' })
            .width('100%')
            .height(48)
            .margin({ bottom: 12 })
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
            .padding({ left: 16, right: 16 })
            .fontSize(14)
            .onChange((value: string) => {
              this.name = value
            })

          TextInput({ placeholder: '请输入您的学号' })
            .width('100%')
            .height(48)
            .margin({ bottom: 12 })
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
            .padding({ left: 16, right: 16 })
            .fontSize(14)
            .onChange((value: string) => {
              this.studentId = value
            })

          TextInput({ placeholder: '请输入您的手机号' })
            .width('100%')
            .height(48)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
            .padding({ left: 16, right: 16 })
            .fontSize(14)
            .onChange((value: string) => {
              this.phone = value
            })

          Button() {
            Text('提交预约')
              .fontSize(16)
              .fontColor(Color.White)
          }
          .width('100%')
          .height(48)
          .margin({ top: 24 })
          .backgroundColor('#007AFF')
          .borderRadius(24)
          .onClick(() => {
            this.handleSubmit()
          })
        }
        .width('100%')
        .padding(16)
        .backgroundColor(Color.White)
        .borderRadius(12)
        .margin({ bottom: 24 })
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F2F7')
    .scrollBar(BarState.Off)
  }

  handleSubmit() {
    if (!this.name || !this.studentId || !this.phone) {
      AlertDialog.show({
        title: '提示',
        message: '请填写完整信息',
        confirm: {
          value: '确定',
          action: () => {
            console.info('Dialog confirmed')
          }
        }
      })
      return
    }

    AlertDialog.show({
      title: '预约成功',
      message: '您已成功预约活动',
      confirm: {
        value: '确定',
        action: () => {
          router.pushUrl({ url: 'pages/RecordsPage_yangyang/RecordsPage' })
        }
      }
    })
  }
}
