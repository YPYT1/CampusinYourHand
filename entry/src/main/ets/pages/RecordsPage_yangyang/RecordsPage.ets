import router from '@ohos.router'

// 定义预约记录的数据结构
interface Record {
  title: string,
  time: string,
  location: string,
  status: '已预约' | '已参加' | '已取消' | '已过期',
  showQRCode?: boolean,
  canRate?: boolean,
  canCancel?: boolean
}

@Entry
@Component
export struct RecordsPage {
  @State currentIndex: number = 0
  @State records: Array<Record> = [
    {
      title: 'HarmonyOS 技术分享会',
      time: '2月1日 13:00',
      location: '教学楼 B201',
      status: '已预约',
      canCancel: true,
      showQRCode: true
    },
    {
      title: '"黑客之夜" Hackathon',
      time: '6月1日 18:00',
      location: '大学生活动中心',
      status: '已预约',
      canCancel: true,
      showQRCode: true
    },
    {
      title: '毕业季音乐节',
      time: '5月20日 18:30',
      location: '学校大礼堂',
      status: '已参加',
      canRate: true
    },
    {
      title: '英语角交流活动',
      time: '5月18日 19:00',
      location: '外语院咖啡厅',
      status: '已取消'
    },
    {
      title: '春季校园招聘会',
      time: '3月15日 09:00',
      location: '体育馆',
      status: '已过期'
    }
  ]

  @Builder TabBuilder(title: string, index: number) {
    Column() {
      Text(title)
        .fontColor(this.currentIndex === index ? '#007AFF' : '#8E8E93')
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? FontWeight.Medium : FontWeight.Regular)
        .padding({ top: 12, bottom: 12, left: 16, right: 16 })

      if (this.currentIndex === index) {
        Row()
          .width(32)
          .height(3)
          .backgroundColor('#007AFF')
          .borderRadius(1.5)
      } else {
        Row()
          .width(32)
          .height(3)
          .backgroundColor('transparent')
      }
    }
    .onClick(() => {
      this.currentIndex = index
    })
  }

  @Builder RecordItem(record: Record) {
    Column() {
      Row() {
        Column() {
          Text(record.title)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1C1C1E')
            .margin({ bottom: 12 })

          Text('时间: ' + record.time)
            .fontSize(14)
            .fontColor('#666666')
            .margin({ bottom: 6 })

          Text('地点: ' + record.location)
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column() {
          if (record.status === '已预约') {
            Row() {
              Button('取消预约')
                .fontSize(14)
                .fontColor('#FF3B30')
                .backgroundColor('#FFF')
                .borderRadius(20)
                .borderWidth(1)
                .borderColor('#FF3B30')
                .height(36)
                .padding({ left: 20, right: 20 })
                .margin({ right: 12 })
                .shadow({ radius: 1, color: '#FF3B3020', offsetX: 0, offsetY: 1 })

              Button('表二维码')
                .fontSize(14)
                .fontColor('#FFFFFF')
                .backgroundColor('#007AFF')
                .borderRadius(20)
                .height(36)
                .padding({ left: 20, right: 20 })
                .shadow({ radius: 2, color: '#007AFF20', offsetX: 0, offsetY: 2 })
            }
          } else if (record.status === '已参加') {
            Button('评价活动')
              .fontSize(14)
              .fontColor('#FFFFFF')
              .backgroundColor('#34C759')
              .borderRadius(20)
              .height(36)
              .padding({ left: 20, right: 20 })
              .shadow({ radius: 2, color: '#34C75920', offsetX: 0, offsetY: 2 })
          } else if (record.status === '已取消') {
            Text('已取消')
              .fontSize(14)
              .fontColor('#8E8E93')
              .backgroundColor('#F2F2F7')
              .borderRadius(12)
              .padding(8)
          } else if (record.status === '已过期') {
            Text('已过期')
              .fontSize(14)
              .fontColor('#8E8E93')
              .backgroundColor('#F2F2F7')
              .borderRadius(12)
              .padding(8)
          }
        }
        .alignItems(HorizontalAlign.End)
        .justifyContent(FlexAlign.Start)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
    }
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .margin({ bottom: 12, left: 16, right: 16 })
    .shadow({ radius: 8, color: '#00000008', offsetX: 0, offsetY: 2 })
  }

  build() {
    Column() {
      Text('我的预约')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1C1E')
        .width('100%')
        .padding({ left: 20, top: 12, bottom: 20 })

      Row() {
        this.TabBuilder('已预约', 0)
        this.TabBuilder('已参加', 1)
        this.TabBuilder('已取消', 2)
        this.TabBuilder('已过期', 3)
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .borderRadius({ topLeft: 20, topRight: 20 })
      .shadow({ radius: 16, color: '#00000008', offsetX: 0, offsetY: -4 })
      .justifyContent(FlexAlign.SpaceAround)

      List() {
        ForEach(this.records.filter((record: Record) => {
          if (this.currentIndex === 0) return record.status === '已预约'
          if (this.currentIndex === 1) return record.status === '已参加'
          if (this.currentIndex === 2) return record.status === '已取消'
          if (this.currentIndex === 3) return record.status === '已过期'
          return false
        }), (record: Record) => {
          ListItem() {
            this.RecordItem(record)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ top: 20 })
      .backgroundColor('#F7F7F7')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F7F7')
  }
}
