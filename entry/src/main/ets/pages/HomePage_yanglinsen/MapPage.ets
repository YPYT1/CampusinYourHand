import router from '@ohos.router'
import geolocation from '@ohos.geolocation'
import { webview } from '@kit.ArkWeb'
import prompt from '@ohos.prompt'

@Entry
@Component
export struct MapPage {
  @State latitude: number = 0
  @State longitude: number = 0
  @State address: string = '获取位置中...'
  @State isLoading: boolean = true
  private webController: webview.WebviewController = new webview.WebviewController()
  private baiduMapAK: string = '7ux82LTzFhRIFm7cOL4Yp9fg7eBttGsh'

  aboutToAppear() {
    // 获取传递的参数
    const params = router.getParams()
    if (params && typeof params === 'object') {
      const locationParams = params as Record<string, number>
      if (locationParams['latitude'] && typeof locationParams['latitude'] === 'number') {
        this.latitude = locationParams['latitude']
      }
      if (locationParams['longitude'] && typeof locationParams['longitude'] === 'number') {
        this.longitude = locationParams['longitude']
      }
    }
    
    // 如果没有传递位置参数，则获取当前位置
    if (this.latitude === 0 && this.longitude === 0) {
      this.getCurrentLocation()
    } else {
      this.isLoading = false
      this.getAddressFromLocation()
    }
  }

  async getCurrentLocation() {
    try {
      let requestInfo: geolocation.LocationRequest = {
        priority: geolocation.LocationRequestPriority.ACCURACY,
        scenario: geolocation.LocationRequestScenario.NAVIGATION,
        timeInterval: 0,
        distanceInterval: 0,
        maxAccuracy: 0
      }
      
      geolocation.on('locationChange', requestInfo, (location: geolocation.Location) => {
        this.latitude = location.latitude
        this.longitude = location.longitude
        this.isLoading = false
        this.getAddressFromLocation()
        geolocation.off('locationChange')
      })
    } catch (err) {
      console.error('获取位置异常：' + JSON.stringify(err))
      this.isLoading = false
      prompt.showToast({
        message: '获取位置失败，请检查定位权限',
        duration: 3000
      })
    }
  }

  async getAddressFromLocation() {
    try {
      // 使用百度地图逆地理编码API获取地址信息
      const reverseGeoUrl = `https://api.map.baidu.com/reverse_geocoding/v3/?ak=${this.baiduMapAK}&output=json&coordtype=wgs84ll&location=${this.latitude},${this.longitude}`
      
      // 注意：在实际应用中，需要配置网络权限并处理跨域问题
      // 这里我们设置一个默认地址
      this.address = '当前位置'
    } catch (err) {
      console.error('获取地址异常：' + JSON.stringify(err))
      this.address = '位置获取失败'
    }
  }

  handleCheckIn() {
    if (this.latitude === 0 && this.longitude === 0) {
      prompt.showToast({
        message: '正在获取位置信息...',
        duration: 2000
      })
      return
    }

    // 这里可以添加签到逻辑，比如上传到服务器
    prompt.showToast({
      message: '签到成功！',
      duration: 2000
    })
    
    // 返回上一页
    setTimeout(() => {
      router.back()
    }, 1000)
  }

  // 生成百度地图HTML内容
  generateMapHtml(): string {
    return `
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>百度地图</title>
        <style>
            * { margin: 0; padding: 0; }
            html, body { width: 100%; height: 100%; overflow: hidden; }
            #map { width: 100%; height: 100%; }
        </style>
        <script type="text/javascript" src="https://api.map.baidu.com/api?v=3.0&ak=${this.baiduMapAK}"></script>
    </head>
    <body>
        <div id="map"></div>
        <script type="text/javascript">
            var map = new BMap.Map("map");
            var point = new BMap.Point(${this.longitude}, ${this.latitude});
            map.centerAndZoom(point, 18);
            map.enableScrollWheelZoom(true);
            
            // 添加当前位置标记
            var marker = new BMap.Marker(point);
            map.addOverlay(marker);
            
            // 添加圆形覆盖物表示签到范围
            var circle = new BMap.Circle(point, 100, {
                strokeColor: "#007AFF",
                strokeWeight: 2,
                strokeOpacity: 0.8,
                fillColor: "#007AFF",
                fillOpacity: 0.2
            });
            map.addOverlay(circle);
            
            // 添加信息窗口
            var infoWindow = new BMap.InfoWindow("当前位置<br/>签到范围：100米");
            marker.addEventListener("click", function(){
                map.openInfoWindow(infoWindow, point);
            });
            
            // 自动打开信息窗口
            setTimeout(function() {
                map.openInfoWindow(infoWindow, point);
            }, 1000);
        </script>
    </body>
    </html>
    `
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .fillColor(Color.White)
          .onClick(() => {
            router.back()
          })
        
        Text('定位签到')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
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

      if (this.isLoading) {
        // 加载中状态
        Column() {
          LoadingProgress()
            .width(60)
            .height(60)
            .margin({ bottom: 16 })
          
          Text('正在获取位置信息...')
            .fontSize(16)
            .fontColor('#666666')
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#F5F5F5')
      } else {
        // 地图容器
        Stack() {
          // 百度地图WebView
          Web({ src: 'data:text/html;charset=utf-8,' + encodeURIComponent(this.generateMapHtml()), controller: this.webController })
            .width('100%')
            .height('100%')
            .onPageEnd(() => {
              console.log('地图加载完成')
            })
            .onErrorReceive((event) => {
              console.error('地图加载错误：', JSON.stringify(event))
            })

          // 底部信息卡片
          Column() {
            // 位置信息
            Row() {
              Column() {
                Text('📍')
                  .fontSize(24)
                  .margin({ bottom: 8 })
                Text('当前位置')
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ bottom: 4 })
                Text(this.address)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#333333')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Column() {
                Text('🎯')
                  .fontSize(24)
                  .margin({ bottom: 8 })
                Text('坐标信息')
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ bottom: 4 })
                Text(`${this.latitude.toFixed(6)}, ${this.longitude.toFixed(6)}`)
                  .fontSize(12)
                  .fontColor('#999999')
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .margin({ bottom: 16 })

            // 签到说明
            Column() {
              Text('签到说明')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .alignSelf(ItemAlign.Start)
                .margin({ bottom: 8 })

              Column() {
                Row() {
                  Text('•')
                    .fontSize(14)
                    .fontColor('#007AFF')
                    .margin({ right: 8 })
                  Text('请确保您在活动现场附近')
                    .fontSize(13)
                    .fontColor('#666666')
                }
                .alignItems(VerticalAlign.Top)
                .margin({ bottom: 4 })

                Row() {
                  Text('•')
                    .fontSize(14)
                    .fontColor('#007AFF')
                    .margin({ right: 8 })
                  Text('签到范围：活动地点周围100米')
                    .fontSize(13)
                    .fontColor('#666666')
                }
                .alignItems(VerticalAlign.Top)
                .margin({ bottom: 4 })

                Row() {
                  Text('•')
                    .fontSize(14)
                    .fontColor('#007AFF')
                    .margin({ right: 8 })
                  Text('每个活动只能签到一次')
                    .fontSize(13)
                    .fontColor('#666666')
                }
                .alignItems(VerticalAlign.Top)
              }
            }
            .width('100%')
            .margin({ bottom: 20 })

            // 签到按钮
            Button('签到')
              .width('100%')
              .height(48)
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .backgroundColor('#007AFF')
              .borderRadius(24)
              .onClick(() => {
                this.handleCheckIn()
              })
              .shadow({
                radius: 8,
                color: 'rgba(0, 122, 255, 0.3)',
                offsetX: 0,
                offsetY: 4
              })
          }
          .width('100%')
          .padding(20)
          .backgroundColor(Color.White)
          .borderRadius({ topLeft: 20, topRight: 20 })
          .position({ x: 0, y: '100%' })
          .translate({ y: -200 })
          .shadow({
            radius: 16,
            color: 'rgba(0,0,0,0.1)',
            offsetX: 0,
            offsetY: -4
          })
        }
        .width('100%')
        .layoutWeight(1)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
} 