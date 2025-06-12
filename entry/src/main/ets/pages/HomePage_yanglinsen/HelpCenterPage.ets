import router from '@ohos.router'

interface HelpItem {
  title: string
  description: string
  icon: string
}

@Component
export struct HelpCenterPage {
  private helpItems: HelpItem[] = [
    {
      title: '如何预约活动',
      description: '了解如何在平台上预约各种校园活动',
      icon: '📅'
    },
    {
      title: '签到功能使用',
      description: '学习如何使用定位签到功能',
      icon: '📍'
    },
    {
      title: '收藏管理',
      description: '管理你的活动收藏列表',
      icon: '⭐'
    },
    {
      title: '账户设置',
      description: '修改个人信息和偏好设置',
      icon: '⚙️'
    },
    {
      title: '常见问题',
      description: '查看常见问题的解答',
      icon: '❓'
    },
    {
      title: '联系我们',
      description: '获取技术支持和客服帮助',
      icon: '📞'
    }
  ]

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
        
        Text('帮助中心')
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
      .backgroundColor('#007AFF')
      .linearGradient({
        angle: 135,
        colors: [['#007AFF', 0.0], ['#00C6FF', 1.0]]
      })

      Scroll() {
        Column() {
          // 搜索框
          Row() {
            Image($r('app.media.search'))
              .width(20)
              .height(20)
              .margin({ right: 12 })
            
            TextInput({ placeholder: '搜索帮助内容...' })
              .layoutWeight(1)
              .backgroundColor('transparent')
              .fontSize(14)
          }
          .width('100%')
          .height(44)
          .backgroundColor('#F5F5F5')
          .borderRadius(22)
          .padding({ left: 16, right: 16 })
          .margin({ top: 16, bottom: 24 })

          // 帮助分类
          Text('帮助分类')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .alignSelf(ItemAlign.Start)
            .margin({ bottom: 16 })

          ForEach(this.helpItems, (item: HelpItem) => {
            Row() {
              Text(item.icon)
                .fontSize(24)
                .margin({ right: 16 })

              Column() {
                Text(item.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .alignSelf(ItemAlign.Start)
                  .margin({ bottom: 4 })

                Text(item.description)
                  .fontSize(14)
                  .fontColor('#666666')
                  .alignSelf(ItemAlign.Start)
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Image($r('app.media.arrow_right'))
                .width(16)
                .height(16)
                .fillColor('#CCCCCC')
            }
            .width('100%')
            .height(72)
            .padding(16)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .margin({ bottom: 12 })
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .shadow({
              radius: 4,
              color: 'rgba(0,0,0,0.1)',
              offsetX: 0,
              offsetY: 2
            })
            .onClick(() => {
              // 这里可以跳转到具体的帮助详情页
              router.pushUrl({
                url: 'pages/HomePage_yanglinsen/HelpDetailPage',
                params: {
                  helpItem: item
                }
              })
            })
          })

          // 联系信息
          Column() {
            Text('需要更多帮助？')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .margin({ bottom: 16 })

            Row() {
              Column() {
                Text('📧')
                  .fontSize(24)
                  .margin({ bottom: 8 })
                Text('邮箱联系')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .margin({ bottom: 4 })
                Text('support@campus.edu')
                  .fontSize(12)
                  .fontColor('#666666')
              }
              .layoutWeight(1)
              .backgroundColor('#F0F8FF')
              .borderRadius(12)
              .padding(16)

              Column() {
                Text('📱')
                  .fontSize(24)
                  .margin({ bottom: 8 })
                Text('客服电话')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .margin({ bottom: 4 })
                Text('400-123-4567')
                  .fontSize(12)
                  .fontColor('#666666')
              }
              .layoutWeight(1)
              .backgroundColor('#F0FFF0')
              .borderRadius(12)
              .padding(16)
              .margin({ left: 12 })
            }
            .width('100%')
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ top: 24, bottom: 32 })
        }
        .padding(16)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
} 