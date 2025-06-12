import  router  from '@ohos.router'
import { promptAction } from '@kit.ArkUI'

interface UserType{
  name:string,
  avatar:string,
  class:string,

}


@Entry
@Component
struct MePage{
  @State myName:string=''
  @State myAvatar:string=''
  @State myClass:string=''

  build() {
    Column() {
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
      // Text(this.myName)
      // Text(this.myAvatar)
      // Text(this.myClass)
      TextInput({placeholder:"输入要更改的姓名"})
        .fontSize(25)
        .margin({left:25, right:25, top:30})
        .onChange((value:string)=>{
            this.myName = value
          })
      TextInput({placeholder:"输入要更改的图片"})
        .fontSize(25)
        .margin({left:25, right:25, top:30})
        .onChange((value:string)=>{
          this.myAvatar = value
        })
      TextInput({placeholder:"输入要更改的班级"})
        .fontSize(25)
        .margin({left:25, right:25, top:30})
        .onChange((value:string)=>{
          this.myClass = value
        })

      Button("修改完成返回")
        .margin({left:25, right:25, top:30})
        .onClick(()=>{
          router.replaceUrl({
            url:"pages/Index",
            params:{
              name:this.myName,
              avatar:this.myAvatar,
              class:this.myClass,
            }
          })
        })

    }
  }
}