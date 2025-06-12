import { router } from '@kit.ArkUI'

@Entry
@Component

struct HelpPage{
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

      Row({space:10}){
        Image($r("app.media.shu"))
          .width(10)
          .height(50)
        Text("其它")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
      .width("100%")
      .padding(10)

      Row({space:25}){
        Column(){
          Image($r("app.media.1"))
            .width(50)
          Text("常见问题")
        }
        Column(){
          Image($r("app.media.2"))
            .width(50)
          Text("问题反馈")
        }
        Column(){
          Image($r("app.media.3"))
            .width(50)
          Text("联系学校")
        }
        Column(){
          Image($r("app.media.4"))
            .width(50)
          Text("联系平台")
        }

      }


      Row({space:10}){
        Image($r("app.media.shu"))
          .width(10)
          .height(50)
        Text("导航")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
      .width("100%")
      .padding(10)
      Column({space:10}){
        Text("联系学校:")
        Text("1.账号基本信息修改(如专业、学院、年级、手机号码等)")
          .fontSize(14)
          .fontColor("#ff757575")
        Text("2.账号忘记密码或者旧手机号无法使用导致无法登陆")
          .fontSize(14)
          .fontColor("#ff757575")
        Text("3.账号进入黑名单")
          .fontSize(14)
          .fontColor("#ff757575")
        Text("4.账号被停用")
          .fontSize(14)
          .fontColor("#ff757575")
      }
      .width("100%")
      .alignItems(HorizontalAlign.Start)



      Column({space:10}){
        Text("联系校内活动管理员:")
        Text("1.活动签到码问题(如无签到码、活动被签退)")
          .fontSize(14)
          .fontColor("#ff757575")
        Text("2.活动学分/积分/学时发放")
          .fontSize(14)
          .fontColor("#ff757575")
      }
      .margin({top:30})
      .width("100%")
      .alignItems(HorizontalAlign.Start)



      Column({space:10}){
        Text("联系平台:")
        Text("1.账号注册使用或被他人误注册使用导致身份信息被占用")
          .fontSize(14)
          .fontColor("#ff757575")
        Text("2.升学或转校，激活账号时无法正常关联")
          .fontSize(14)
          .fontColor("#ff757575")
        Text("3.系统bug(如白屏、闪退等)")
          .fontSize(14)
          .fontColor("#ff757575")
      }
      .margin({top:30})
      .width("100%")
      .alignItems(HorizontalAlign.Start)
    }
    .padding(5)
    .width("100%")
    .height("100%")
  }
}