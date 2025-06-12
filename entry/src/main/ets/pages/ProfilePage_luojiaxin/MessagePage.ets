import { router } from '@kit.ArkUI'

@Entry
@Component

struct MessagePage{
  @State dateYear:string = new Date().getFullYear().toString()
  @State dateMonth:string = new Date().getMonth().toString()
  @State datDate:string = new Date().getDate().toString()
  build() {
    Column(){
      Row(){
        Image($r("app.media.left"))
          .width(50)
          .onClick(()=>{
            router.back()
          })
        Blank()
        Text("全部已读")
          .fontSize(20)
      }
      .padding(10)
      .width("100%")
      .border({
        width:{bottom:1},
        color: "#ff797474"
      })

      Row(){
        Image($r("app.media.good"))
          .width(50)
          .fillColor("#ffdb3b3b")
        Column(){
          Row(){
            Text("新增加点赞")
              .margin({left:5})
              .width("30%")
          }
          .width("85%")
        }
      }
      .padding(10)
      .width("100%")
      .border({
        width:{bottom:1},
        color:"#ff797474"
      })

      Row(){
        Image($r("app.media.speaker"))
          .width(50)
        Column(){
          Row(){
            Text("系统通知")
              .margin({left:5})
              .width("30%")
            Blank()
            Text(this.dateYear + "/"+ this.dateMonth+ "/"+this.datDate)
          }
          .width("85%")
          Text("叮！你已被列入【经管院系大学生】")
            .margin({left:-20})
            .maxLines(1)
            .textOverflow({overflow:TextOverflow.Ellipsis})
            .width("75%")
            .fontColor("#ff888484")
        }
      }
      .padding(10)
      .width("100%")
      .border({
        width:{bottom:1},
        color:"#ff797474"
      })

      Row(){
        Image($r("app.media.start"))
          .width(50)
        Column(){
          Row(){
            Text("校园通知")
              .margin({left:5})
              .width("30%")
            Blank()
            Text(this.dateYear + "/"+ this.dateMonth+ "/"+this.datDate)
          }
          .width("85%")
        }
      }
      .padding(10)
      .width("100%")
      .border({
        width:{bottom:1},
        color:"#ff797474"
      })

      Row(){
        Image($r("app.media.activity"))
          .width(50)
        Column(){
          Row(){
            Text("活动公告")
              .margin({left:5})
              .width("30%")
            Blank()
            Text(this.dateYear + "/"+ this.dateMonth+ "/"+this.datDate)
          }
          .width("85%")
          Text("你已被移入[传统文化宣传征集行请尽快前往指定地点报道]")
            .margin({left:-20})
            .maxLines(1)
            .textOverflow({overflow:TextOverflow.Ellipsis})
            .width("75%")
            .fontColor("#ff888484")
        }
      }
      .padding(10)
      .width("100%")
      .border({
        width:{bottom:1},
        color:"#ff797474"
      })

    }
    .width("100%")
    .height("100%")
    .backgroundColor("#ffe7d8d8")
  }

}