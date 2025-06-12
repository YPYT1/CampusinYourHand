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

interface RouterParams {
  favorites?: Activity[]
}

@Entry
@Component
export struct FavoritesPage {
  @State favorites: Activity[] = []

  aboutToAppear() {
    const params = router.getParams()
    if (params && (params as RouterParams).favorites) {
      this.favorites = (params as RouterParams).favorites as Activity[]
    }
  }

  build() {
    Column() {
      // 头部
      Row() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        
        Text('我的收藏')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 16 })
        
        Blank()
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      if (this.favorites.length === 0) {
        // 空状态
        Column() {
          Image($r('app.media.ic_my_favorites'))
            .width(80)
            .height(80)
            .opacity(0.3)
          
          Text('暂无收藏的活动')
            .fontSize(16)
            .fontColor('#8E8E93')
            .margin({ top: 16 })
          
          Text('去首页看看有什么精彩活动吧')
            .fontSize(14)
            .fontColor('#8E8E93')
            .margin({ top: 8 })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else {
        // 收藏列表
        Scroll() {
          Column() {
            ForEach(this.favorites, (item: Activity) => {
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

                  Row() {
                    Text('\u{1F550}')  // 🕐
                      .fontSize(16)
                      .fontColor('#8E8E93')
                    Text(item.time)
                      .fontSize(13)
                      .fontColor('#8E8E93')
                  }
                  .margin({ bottom: 4 })

                  Row() {
                    Text('\u{1F4CD}')  // 📍
                      .fontSize(16)
                      .fontColor('#8E8E93')
                    Text(item.location)
                      .fontSize(13)
                      .fontColor('#8E8E93')
                  }

                  Text(item.status)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(item.status === '火热报名中' ? '#34C759' : '#8E8E93')
                    .backgroundColor(item.status === '火热报名中' ? '#EAF7ED' : '#F2F2F7')
                    .borderRadius(16)
                    .padding({ left: 10, right: 10, top: 4, bottom: 4 })
                    .margin({ top: 8 })
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
          .padding({ top: 16, bottom: 80 })
        }
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .width('100%')
        .layoutWeight(1)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F2F7')
  }
} 