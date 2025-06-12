import { router } from '@kit.ArkUI'

@Entry
@Component

struct AboutPage{
  build() {
    Column(){
      Row(){
        Image($r("app.media.left"))
          .width(50)
          .onClick(()=>{
            router.back()
          })
      }
      .padding(10)
      .width("100%")
      .border({
        width:{bottom:1},
        color: "#ff797474"
      })

      Column(){
        Image($r("app.media.img"))
          .width(200)
          .height(200)
          .borderRadius(100)

        Text("版本号  1008611")
          .fontSize(18)
          .fontColor("#dd8a8787")
          .margin({top:30})
      }
      .margin({top:50, bottom:50})

      Row(){
        Text("检测更新")
          .fontSize(20)
        Blank()
        Image($r("app.media.right"))
          .width(20)
          .fillColor("#dd6b6969")
      }
      .padding({bottom:20})
      .margin({ bottom:20})
      .width("95%")
      .border({
        width:{bottom:1},
        color: "#ffc6c3c3"
      })
      Row(){
        Text("评价我们")
          .fontSize(20)
        Blank()
        Image($r("app.media.right"))
          .width(20)
          .fillColor("#dd6b6969")
      }
      .padding({bottom:20})
      .margin({ bottom:20})
      .width("95%")
      .border({
        width:{bottom:1},
        color: "#ffc6c3c3"
      })
      Row(){
        Text("用户协议")
          .fontSize(20)
        Blank()
        Image($r("app.media.right"))
          .width(20)
          .fillColor("#dd6b6969")
      }
      .padding({bottom:20})
      .margin({ bottom:20})
      .width("95%")
      .border({
        width:{bottom:1},
        color: "#ffc6c3c3"
      })

      Blank()
      Text("增值电信业务经营许可证：京B2-20232334")
        .fontSize(15)
        .fontColor("#ff8c8888")
      Text("App备案号：京ICP备17040552号-6A")
        .fontSize(15)
        .fontColor("#ff8c8888")




    }
    .padding(5)
    .width("100%")
    .height("100%")
  }
}