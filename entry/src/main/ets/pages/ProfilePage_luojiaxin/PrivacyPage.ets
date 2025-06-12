import { router } from '@kit.ArkUI'

@Entry
@Component

struct PrivacyPage{
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

      Row(){
        Text("基本资料")
          .fontSize(20)
        Blank()
        Image($r("app.media.right"))
          .width(20)
          .fillColor("#dd6b6969")
      }
      .padding({bottom:20})
      .margin({top:20, bottom:20})
      .width("95%")
      .border({
        width:{bottom:1},
        color: "#ffc6c3c3"
      })

      Row(){
        Text("字体大小")
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
        Text("清空缓存")
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
        Text("更改密码")
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


    }
    .width("100%")
    .height("100%")
  }
}