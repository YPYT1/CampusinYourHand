import { AppColors, AppSizes } from '../../common/constants/AppConstants'
import router from '@ohos.router'

interface UserType{
  id:number,
  studentId:string,
  name:string,
  avatar:Resource
  class:string
}

interface NewUser{
  name:string,
  avatar:Resource,
  class:string
}

@Entry
@Component

export struct ProfilePage {
  @State UserList:UserType[] = [
    {id:1, studentId:"114514", name:"MOMO", class:"软件工程2022级", avatar:$r('app.media.img')}
  ]

  aboutToAppear(): void {
    const params = router.getParams() as Record<string, string | number | UserType>;
    if (params && params.userInfo) {
      const userInfo = params.userInfo as UserType;
      this.UserList[0].name = userInfo.name;
      this.UserList[0].avatar = userInfo.avatar;
      this.UserList[0].class = userInfo.class;
    }
  }
  build() {
    List() {
      ListItem() {
        Column() {
          // Text('个人中心模块')
          //   .fontSize(24)
          //   .fontWeight(FontWeight.Bold)
          //   .fontColor('#1C1C1E')
          //   .margin({ bottom: 16 })
          //
          // Text('负责人：罗嘉欣')
          //   .fontSize(18)
          //   .fontColor('#007AFF')
          //   .fontWeight(FontWeight.Medium)
          //   .margin({ bottom: 8 })
          //
          // Text('ProfilePage.ets')
          //   .fontSize(14)
          //   .fontColor('#8E8E93')
          //   .margin({ bottom: 32 })
          //
          // Text('待开发功能：')
          //   .fontSize(16)
          //   .fontWeight(FontWeight.Medium)
          //   .fontColor('#1C1C1E')
          //   .margin({ bottom: 16 })
          Column({ space: 8 }) {
            //1   头像名称展示
            Row() {
              //头像图片
              Image(this.UserList[0].avatar)
                .width(70)
                .height(70)
                .borderRadius(35)
                .margin({ left: 30 })
              Column() {
                //名称
                Text(this.UserList[0].name)
                  .fontSize(AppSizes.FONT_XL)
                  .fontWeight(FontWeight.Bold)
                Text(this.UserList[0].class)
                  .margin({ top: 5 })
                  .fontSize(AppSizes.FONT_XS)
                  .fontColor("#dd9d9d9d")
              }
              .width("80%")
              .alignItems(HorizontalAlign.Start)
              .margin({ left: 10 })
            }
            .width("100%")
            .height("15%")
            .backgroundColor("#ffffffff")
            .borderRadius(20)

            //2    Text('• 活动参与统计和积分系统')
            Row({ space: 19 }) {
              //参与活动
              Column() {
                Text("12")
                  .fontSize(AppSizes.FONT_XL)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AppColors.PRIMARY)
                Text("参与活动")
                  .margin({ top: 3 })
                  .fontSize(AppSizes.FONT_XS)
                  .fontColor("#dd9d9d9d")
              }
              .justifyContent(FlexAlign.Center)
              .backgroundColor("#ffffffff")
              .width("47%")
              .height("10%")
              .borderRadius(20)

              //累计积分
              Column() {
                Text("860")
                  .fontSize(AppSizes.FONT_XL)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AppColors.PRIMARY)
                Text("累计积分")
                  .margin({ top: 3 })
                  .fontSize(AppSizes.FONT_XS)
                  .fontColor("#dd9d9d9d")
              }
              .justifyContent(FlexAlign.Center)
              .backgroundColor("#ffffffff")
              .width("47%")
              .height("10%")
              .borderRadius(20)
            }
            .width("100%")
            .margin({ top: 10 })

            //3   Text('• 应用设置（通知、主题、语言）')
            ColumnSplit() {
              //个人资料
              Row() {
                Image($r("app.media.me"))
                  .width(25)
                Text("个人资料编辑")
                  .margin({ left: 5 })
              }
              .onClick(() => {
                // 跳转到"我的"页面
                router.pushUrl({
                  url: "pages/ProfilePage_luojiaxin/MePage",
                  params: {
                    userInfo: this.UserList[0]
                  }
                }, router.RouterMode.Single)
              })
              .height("33%")

              //消息通知
              Row() {
                Image($r("app.media.message"))
                  .width(25)
                Text("消息通知设置")
                  .margin({ left: 5 })
              }
              .height("33%")
              .onClick(()=>{
                router.pushUrl({
                  url:'pages/ProfilePage_luojiaxin/MessagePage'
                })
              })

              //隐私设置
              Row() {
                Image($r("app.media.privacy"))
                  .width(25)
                Text("隐私设置")
                  .margin({ left: 5 })
              }
              .height("33%")
              .onClick(()=> {
                router.pushUrl({
                  url: 'pages/ProfilePage_luojiaxin/PrivacyPage'
                })
              })
            }
            .padding({
              left: 10,
              right: 10,
              top: 10,
              bottom: 10
            })
            .width("100%")
            .height("25%")
            .backgroundColor("#ffffffff")
            .borderRadius(20)
            .margin({ top: 20 })

            //Text('• 帮助中心和意见反馈')Text('• 关于应用和版本信息')
            ColumnSplit() {
              //帮助与反馈
              Row() {
                Image($r("app.media.ask"))
                  .width(25)
                Text("帮助与反馈")
                  .margin({ left: 5 })
              }.height("50%")
              .onClick(()=> {
                router.pushUrl({
                  url: 'pages/ProfilePage_luojiaxin/HelpPage'
                })
              })


              //关于我们
              Row() {
                Image($r("app.media.about"))
                  .width(25)
                Text("关于我们")
                  .margin({ left: 5 })
              }.height("50%")
              .onClick(()=> {
                router.pushUrl({
                  url: 'pages/ProfilePage_luojiaxin/AboutPage'
                })
              })

            }
            .width("100%")
            .height("15%")
            .backgroundColor("#ffffffff")
            .borderRadius(20)
            .margin({ top: 25 })
            .padding({
              left: 10,
              right: 10,
              top: 10,
              bottom: 10
            })

            //退出
            Button("退出登录")
              .width("100%")
              .height(50)
              .backgroundColor("#ffef3939")
              .type(ButtonType.Normal)
              .borderRadius(8)
              .margin({ top: 30 })


            //待完成项目
            // Text('• 用户头像上传和更换')
          }
          .width('100%')
          .padding({ left: 16, right: 16 })

          // Text('请在此文件中实现个人中心的具体功能')
          //   .fontSize(12)
          //   .fontColor('#8E8E93')
          //   .margin({ top: 32 })
          //   .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F2F2F7')
      }
    }
  }
}
