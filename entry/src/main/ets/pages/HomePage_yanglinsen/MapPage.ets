import router from '@ohos.router'
import prompt from '@ohos.prompt'

interface RouterParams {
  latitude?: number
  longitude?: number
}

@Entry
@Component
export struct MapPage {
  @State latitude: number = 0
  @State longitude: number = 0
  @State currentLocation: string = ''

  aboutToAppear() {
    const params = router.getParams()
    if (params) {
      this.latitude = (params as RouterParams).latitude || 0
      this.longitude = (params as RouterParams).longitude || 0
      this.currentLocation = `纬度: ${this.latitude.toFixed(6)}, 经度: ${this.longitude.toFixed(6)}`
    }
  }

  handleCheckIn() {
    // 模拟签到成功
    prompt.showToast({
      message: '签到成功！',
      duration: 2000
    })
    
    setTimeout(() => {
      router.back()
    }, 1000)
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
        
        Text('定位签到')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 16 })
        
        Blank()
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // 地图区域
      Column() {
        // 模拟地图
        Column() {
          Text('📍')
            .fontSize(48)
            .margin({ bottom: 16 })
          
          Text('当前位置')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 8 })
          
          Text(this.currentLocation || '获取位置中...')
            .fontSize(14)
            .fontColor('#8E8E93')
            .textAlign(TextAlign.Center)
            .margin({ bottom: 32 })
          
          Button('签到')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .backgroundColor('#007AFF')
            .fontColor(Color.White)
            .width(120)
            .height(44)
            .borderRadius(22)
            .onClick(() => {
              this.handleCheckIn()
            })
        }
        .width('100%')
        .height(400)
        .backgroundColor('#F8F8F8')
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .margin({ top: 20 })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .layoutWeight(1)

      // 说明文字
      Column() {
        Text('签到说明')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 8 })
        
        Text('• 请确保您在活动现场附近')
          .fontSize(14)
          .fontColor('#8E8E93')
          .margin({ bottom: 4 })
        
        Text('• 签到范围：活动地点周围100米')
          .fontSize(14)
          .fontColor('#8E8E93')
          .margin({ bottom: 4 })
        
        Text('• 每个活动只能签到一次')
          .fontSize(14)
          .fontColor('#8E8E93')
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 20 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F2F7')
  }
} 