import router from '@ohos.router'
import { AppColors, AppSizes } from '../../common/constants/AppConstants'

interface Activity {
  id: string
  title: string
  time: string
  location: string
  image: string
  status: string
}

@Entry
@Component
export struct FavoritesPage {
  @State favoriteActivities: Activity[] = []
  private storageKey = 'favorite_activities'

  aboutToAppear() {
    this.loadFavorites()
  }

  // 加载收藏数据
  loadFavorites() {
    try {
      const storedFavorites = AppStorage.get<Activity[]>(this.storageKey)
      if (storedFavorites && Array.isArray(storedFavorites)) {
        this.favoriteActivities = storedFavorites
      }
    } catch (error) {
      console.error('加载收藏数据失败:', JSON.stringify(error))
    }
  }

  // 移除收藏
  removeFavorite(activityId: string) {
    this.favoriteActivities = this.favoriteActivities.filter(activity => activity.id !== activityId)
    // 更新存储
    try {
      AppStorage.setOrCreate<Activity[]>(this.storageKey, this.favoriteActivities)
    } catch (error) {
      console.error('保存收藏数据失败:', JSON.stringify(error))
    }
  }

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
        
        Text('我的收藏')
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

      if (this.favoriteActivities.length === 0) {
        // 空状态
        Column() {
          Text('⭐')
            .fontSize(64)
            .margin({ bottom: 16 })
          
          Text('暂无收藏')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 8 })
          
          Text('去首页看看有什么有趣的活动吧')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ bottom: 24 })
          
          Button('去首页看看')
            .fontSize(14)
            .fontColor(Color.White)
            .backgroundColor('#007AFF')
            .borderRadius(20)
            .height(40)
            .width(120)
            .onClick(() => {
              router.back()
            })
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else {
        // 收藏列表
        Scroll() {
          Column() {
            // 统计信息
            Row() {
              Text('共收藏了')
                .fontSize(14)
                .fontColor('#666666')
              Text(` ${this.favoriteActivities.length} `)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#007AFF')
              Text('个活动')
                .fontSize(14)
                .fontColor('#666666')
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .margin({ top: 16, bottom: 16 })

            ForEach(this.favoriteActivities, (item: Activity) => {
              Row() {
                Image(item.image)
                  .width(100)
                  .height(100)
                  .borderRadius(8)
                  .objectFit(ImageFit.Cover)

                Column() {
                  Text(item.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .margin({ bottom: 4 })
                    .maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })

                  Row() {
                    Text('\u{1F550}')  // 🕐
                      .fontSize(14)
                      .fontColor('#8E8E93')
                    Text(item.time)
                      .fontSize(13)
                      .fontColor('#8E8E93')
                      .margin({ left: 4 })
                  }
                  .margin({ bottom: 4 })

                  Row() {
                    Text('\u{1F4CD}')  // 📍
                      .fontSize(14)
                      .fontColor('#8E8E93')
                    Text(item.location)
                      .fontSize(13)
                      .fontColor('#8E8E93')
                      .margin({ left: 4 })
                  }
                  .margin({ bottom: 8 })

                  Row() {
                    Text(item.status)
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(item.status === '火热报名中' ? '#34C759' : '#8E8E93')
                      .backgroundColor(item.status === '火热报名中' ? '#EAF7ED' : '#F2F2F7')
                      .borderRadius(16)
                      .padding({ left: 10, right: 10, top: 4, bottom: 4 })

                    Blank()

                    // 取消收藏按钮
                    Button() {
                      Text('💔')
                        .fontSize(16)
                    }
                    .width(32)
                    .height(32)
                    .borderRadius(16)
                    .backgroundColor('#FFE8E8')
                    .onClick(() => {
                      this.removeFavorite(item.id)
                    })
                  }
                  .width('100%')
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ left: 16 })
                .layoutWeight(1)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(12)
              .margin({ left: 16, right: 16, top: 8 })
              .shadow({
                radius: 4,
                color: 'rgba(0,0,0,0.1)',
                offsetX: 0,
                offsetY: 2
              })
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/ActivityPage_wuguixing/ActivityPage',
                  params: {
                    activity: item
                  }
                })
              })
            })
          }
          .padding({ bottom: 20 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
} 