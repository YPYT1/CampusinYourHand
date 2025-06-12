import router from '@ohos.router'
import { CommonCard } from '../../common/components/CommonCard'
import dataPreferences from '@ohos.data.preferences'
import prompt from '@ohos.prompt'

interface Activity {
  id: string
  title: string
  time: string
  location: string
  image: Resource
  status: string
  type: string
  participants: number
  maxParticipants: number
  description: string
  isRegistered?: boolean  // 添加报名状态
}

interface Record {
  title: string
  time: string
  location: string
  status: '已预约' | '已参加' | '已取消' | '已过期'
  showQRCode?: boolean
  canRate?: boolean
  canCancel?: boolean
}

@Entry
@Component
export struct ActivityPage {
  @State activities: Activity[] = [
    {
      id: '1',
      title: 'HarmonyOS 技术分享会',
      time: '今天 19:00 - 21:00',
      location: '教学楼 B201',
      image: $r('app.media.img'),
      status: '火热报名中',
      type: '技术讲座',
      participants: 23,
      maxParticipants: 100,
      description: '深入了解HarmonyOS开发技术，分享实际项目经验',
      isRegistered: false
    },
    {
      id: '2',
      title: '校园摄影大赛作品展',
      time: '周三至周五 全天',
      location: '图书馆一楼大厅',
      image: $r('app.media.img'),
      status: '进行中',
      type: '艺术展览',
      participants: 156,
      maxParticipants: 200,
      description: '展示学生优秀摄影作品，感受艺术之美',
      isRegistered: false
    },
    {
      id: '3',
      title: '王者荣耀校园联赛',
      time: '周六至周天 全天',
      location: '电竞馆一楼',
      image: $r('app.media.img'),
      status: '火热报名中',
      type: '电竞比赛',
      participants: 89,
      maxParticipants: 128,
      description: '校园电竞盛事，展现你的游戏技巧',
      isRegistered: false
    },
    {
      id: '4',
      title: '创业分享交流会',
      time: '下周二 14:00 - 16:00',
      location: '创新创业中心',
      image: $r('app.media.img'),
      status: '即将开始',
      type: '创业讲座',
      participants: 45,
      maxParticipants: 80,
      description: '优秀校友分享创业经验和心得',
      isRegistered: false
    },
    {
      id: '5',
      title: '春季运动会',
      time: '下周五-六 08:00 - 18:00',
      location: '学校田径场',
      image: $r('app.media.img'),
      status: '火热报名中',
      type: '体育赛事',
      participants: 234,
      maxParticipants: 500,
      description: '展现青春活力，挑战运动极限',
      isRegistered: false
    },
    {
      id: '6',
      title: '音乐节演出',
      time: '下周日 19:00 - 22:00',
      location: '学校大礼堂',
      image: $r('app.media.img'),
      status: '火热报名中',
      type: '文艺演出',
      participants: 167,
      maxParticipants: 300,
      description: '精彩的音乐演出，感受艺术魅力',
      isRegistered: false
    }
  ]
  
  @State selectedCategory: string = '全部'
  @State filteredActivities: Activity[] = this.activities.slice()
  
  private categories: string[] = ['全部', '技术讲座', '艺术展览', '电竞比赛', '创业讲座', '体育赛事', '文艺演出']
  private preferences: dataPreferences.Preferences | null = null

  async aboutToAppear() {
    try {
      this.preferences = await dataPreferences.getPreferences(getContext(), 'activity_preferences')
      this.filterActivities()
    } catch (err) {
      console.error('Failed to get preferences:', err)
    }
  }

  filterActivities() {
    if (this.selectedCategory === '全部') {
      this.filteredActivities = this.activities.slice()
    } else {
      this.filteredActivities = this.activities.filter(activity => activity.type === this.selectedCategory)
    }
  }

  getStatusColor(status: string): string {
    switch (status) {
      case '火热报名中':
        return '#FF6B6B'
      case '进行中':
        return '#4ECDC4'
      case '即将开始':
        return '#45B7D1'
      case '已结束':
        return '#96CEB4'
      default:
        return '#DEDEDE'
    }
  }

  getStatusBgColor(status: string): string {
    switch (status) {
      case '火热报名中':
        return '#FFE8E8'
      case '进行中':
        return '#E8F8F7'
      case '即将开始':
        return '#E8F4FD'
      case '已结束':
        return '#F0F8F4'
      default:
        return '#F5F5F5'
    }
  }

  // 修改报名处理函数
  async handleRegistration(activity: Activity) {
    if (activity.status === '火热报名中' && !activity.isRegistered) {
      // 创建新的活动数组以触发状态更新
      const updatedActivities = this.activities.map(a => {
        if (a.id === activity.id) {
          const updatedActivity: Activity = {
            id: a.id,
            title: a.title,
            time: a.time,
            location: a.location,
            image: a.image,
            status: a.status,
            type: a.type,
            participants: a.participants + 1,
            maxParticipants: a.maxParticipants,
            description: a.description,
            isRegistered: true
          }
          return updatedActivity
        }
        return a
      })
      
      // 更新活动列表
      this.activities = updatedActivities.slice()
      
      // 更新过滤后的活动列表
      this.filterActivities()

      // 添加到预约记录
      const newRecord: Record = {
        title: activity.title,
        time: activity.time,
        location: activity.location,
        status: '已预约',
        canCancel: true,
        showQRCode: true
      }

      try {
        if (this.preferences) {
          // 获取现有记录
          let records: Record[] = []
          const storedRecords = await this.preferences.get('user_records', '[]')
          if (storedRecords && storedRecords !== '[]') {
            try {
              records = JSON.parse(storedRecords as string)
            } catch (e) {
              console.error('Failed to parse stored records:', e)
              records = []
            }
          }

          // 添加新记录
          records.unshift(newRecord)

          // 保存记录
          await this.preferences.put('user_records', JSON.stringify(records))
          await this.preferences.flush()

          // 显示成功提示
          prompt.showToast({
            message: '报名成功！',
            duration: 2000
          })
        }
      } catch (err) {
        console.error('Failed to save record:', err)
        prompt.showToast({
          message: '保存记录失败',
          duration: 2000
        })
      }
    }
  }

  build() {
    Column() {
      // 头部渐变背景
      Column() {
        Row() {
          Image($r('app.media.back'))
            .width(24)
            .height(24)
            .fillColor(Color.White)
            .onClick(() => {
              router.back()
            })
          
          Text('校园活动')
            .fontSize(20)
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
      }
      .width('100%')
      .padding({ top: 44, bottom: 16 })
      .linearGradient({
        angle: 135,
        colors: [['#667eea', 0.0], ['#764ba2', 1.0]]
      })

      Scroll() {
        Column() {
          // 分类选择器
          Column() {
            Text('活动分类')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .alignSelf(ItemAlign.Start)
              .margin({ bottom: 12 })

            List() {
              ForEach(this.categories, (category: string) => {
                ListItem() {
                  Text(category)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.selectedCategory === category ? Color.White : '#667eea')
                    .backgroundColor(this.selectedCategory === category ? '#667eea' : '#F0F2FF')
                    .borderRadius(20)
                    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                    .margin({ right: 12 })
                    .onClick(() => {
                      this.selectedCategory = category
                      this.filterActivities()
                    })
                }
              })
            }
            .listDirection(Axis.Horizontal)
            .width('100%')
            .height(40)
            .padding({ right: 16 })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(16)
          .margin({ top: 16, bottom: 16 })
          .shadow({
            radius: 8,
            color: 'rgba(0,0,0,0.1)',
            offsetX: 0,
            offsetY: 4
          })

          // 活动统计
          Row() {
            Column() {
              Text(`${this.filteredActivities.length}`)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#667eea')
              Text('活动总数')
                .fontSize(12)
                .fontColor('#999999')
            }
            .layoutWeight(1)

            Column() {
              Text(`${this.filteredActivities.filter(a => a.status === '火热报名中').length}`)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FF6B6B')
              Text('报名中')
                .fontSize(12)
                .fontColor('#999999')
            }
            .layoutWeight(1)

            Column() {
              Text(`${this.filteredActivities.filter(a => a.status === '进行中').length}`)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#4ECDC4')
              Text('进行中')
                .fontSize(12)
                .fontColor('#999999')
            }
            .layoutWeight(1)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(16)
          .margin({ bottom: 16 })
          .shadow({
            radius: 8,
            color: 'rgba(0,0,0,0.1)',
            offsetX: 0,
            offsetY: 4
          })

          // 活动列表
          ForEach(this.filteredActivities, (activity: Activity) => {
            Column() {
              // 活动图片
              Image(activity.image)
                .width('100%')
                .height(180)
                .borderRadius({ topLeft: 16, topRight: 16 })
                .objectFit(ImageFit.Cover)

              // 活动信息
              Column() {
                // 标题和状态
                Row() {
                  Text(activity.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#333333')
                    .layoutWeight(1)
                    .maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })

                  Text(activity.status)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.getStatusColor(activity.status))
                    .backgroundColor(this.getStatusBgColor(activity.status))
                    .borderRadius(12)
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                }
                .width('100%')
                .margin({ bottom: 8 })
                .alignItems(VerticalAlign.Top)

                // 类型标签
                Text(activity.type)
                  .fontSize(12)
                  .fontColor('#667eea')
                  .backgroundColor('#F0F2FF')
                  .borderRadius(8)
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  .alignSelf(ItemAlign.Start)
                  .margin({ bottom: 8 })

                // 时间和地点
                Row() {
                  Text('🕐')
                    .fontSize(14)
                  Text(activity.time)
                    .fontSize(13)
                    .fontColor('#666666')
                    .margin({ left: 4 })
                }
                .margin({ bottom: 4 })

                Row() {
                  Text('📍')
                    .fontSize(14)
                  Text(activity.location)
                    .fontSize(13)
                    .fontColor('#666666')
                    .margin({ left: 4 })
                }
                .margin({ bottom: 8 })

                // 参与人数进度条
                Column() {
                  Row() {
                    Text('报名进度')
                      .fontSize(12)
                      .fontColor('#666666')
                    Blank()
                    Text(`${activity.participants}/${activity.maxParticipants}`)
                      .fontSize(12)
                      .fontColor('#667eea')
                      .fontWeight(FontWeight.Medium)
                  }
                  .width('100%')
                  .margin({ bottom: 4 })

                  Progress({
                    value: activity.participants,
                    total: activity.maxParticipants,
                    type: ProgressType.Linear
                  })
                    .width('100%')
                    .height(4)
                    .backgroundColor('#F0F0F0')
                    .color('#667eea')
                    .borderRadius(2)
                }
                .width('100%')
                .margin({ bottom: 8 })

                // 描述
                Text(activity.description)
                  .fontSize(13)
                  .fontColor('#888888')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .margin({ bottom: 12 })

                // 操作按钮
                Row() {
                  Button('查看详情')
                    .fontSize(14)
                    .fontColor('#667eea')
                    .backgroundColor('#F0F2FF')
                    .borderRadius(20)
                    .height(36)
                    .layoutWeight(1)
                    .margin({ right: 8 })
                    .onClick(() => {
                      router.pushUrl({
                        url: 'pages/ActivityDetailPage',
                        params: { activity: activity }
                      })
                    })

                  Button(activity.isRegistered ? '已报名' : 
                    (activity.status === '火热报名中' ? '立即报名' : 
                    (activity.status === '进行中' ? '进行中' : 
                    (activity.status === '即将开始' ? '即将开始' : '已结束'))))
                    .fontSize(14)
                    .fontColor(Color.White)
                    .backgroundColor(activity.isRegistered ? '#4ECDC4' : 
                      (activity.status === '火热报名中' ? '#FF6B6B' : 
                      (activity.status === '进行中' ? '#4ECDC4' : 
                      (activity.status === '即将开始' ? '#45B7D1' : '#96CEB4'))))
                    .borderRadius(20)
                    .height(36)
                    .layoutWeight(1)
                    .onClick(() => {
                      if (activity.status === '火热报名中' && !activity.isRegistered) {
                        this.handleRegistration(activity)
                      }
                    })
                }
                .width('100%')
              }
              .width('100%')
              .padding(16)
            }
            .width('100%')
            .backgroundColor(Color.White)
            .borderRadius(16)
            .margin({ bottom: 16 })
            .shadow({
              radius: 8,
              color: 'rgba(0,0,0,0.1)',
              offsetX: 0,
              offsetY: 4
            })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ActivityDetailPage',
                params: { activity: activity }
              })
            })
          })
        }
        .padding(16)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F9FF')
  }
}
