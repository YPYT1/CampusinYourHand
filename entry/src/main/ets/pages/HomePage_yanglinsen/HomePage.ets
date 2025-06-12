import { AppColors, AppSizes } from '../../common/constants/AppConstants'
import { StatusBar } from '../../common/components/StatusBar'
import geolocation from '@ohos.geolocation'
import router from '@ohos.router'
import prompt from '@ohos.prompt'

interface Activity {
  id: string
  title: string
  time: string
  location: string
  image: string
  status: string
}

@Entry
@Component
export struct HomePage {
  @State currentTime: string = '10:24'
  @State location: string = ''
  @State latitude: number = 0
  @State longitude: number = 0
  @State searchText: string = ''
  @State showSearchHistory: boolean = false
  @State searchHistory: string[] = []
  @State searchResults: Activity[] = []
  @State isSearching: boolean = false
  @State favoriteStates: Map<string, boolean> = new Map()
  @State favoriteActivities: Activity[] = []

  // 模拟活动数据
  private activities: Activity[] = [
    {
      id: '1',
      title: 'HarmonyOS 技术分享会',
      time: '今天 19:00 - 21:00',
      location: '教学楼 B201',
      image: 'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=200&h=200&fit=crop',
      status: '火热报名中'
    },
    {
      id: '2',
      title: '校园摄影大赛作品展',
      time: '周三至周五 全天',
      location: '图书馆一楼大厅',
      image: 'https://images.unsplash.com/photo-1505373877841-8d25f7d46678?w=200&h=200&fit=crop',
      status: '已结束'
    },
    {
      id: '3',
      title: '王者荣耀比赛',
      time: '周六至周天 全天',
      location: '电竞一楼大厅',
      image: 'https://images.unsplash.com/photo-1505373877841-8d25f7d46678?w=200&h=200&fit=crop',
      status: '火热报名中'
    },
    {
      id: '4',
      title: '校园摇滚音乐节',
      time: '下周五 19:30',
      location: '学校操场',
      image: 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=200&h=200&fit=crop',
      status: '火热报名中'
    }
  ]

  aboutToAppear() {
    this.getCurrentLocation()
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
      
      let locationRequest = await geolocation.on('locationChange', requestInfo, (location: geolocation.Location) => {
        this.location = `${location.latitude}, ${location.longitude}`
        this.latitude = location.latitude
        this.longitude = location.longitude
        geolocation.off('locationChange')
      })
    } catch (err) {
      console.error('获取位置异常：' + JSON.stringify(err))
    }
  }

  handleCheckIn() {
    if (!this.location) {
      this.getCurrentLocation()
    }
    
    router.pushUrl({
      url: 'pages/HomePage_yanglinsen/MapPage',
      params: {
        latitude: this.latitude,
        longitude: this.longitude
      }
    })
  }

  handleSearch(text: string) {
    if (!text.trim()) {
      this.searchResults = []
      this.isSearching = false
      return
    }

    // 执行搜索
    this.isSearching = true
    this.searchResults = this.activities.filter(activity => 
      activity.title.toLowerCase().includes(text.toLowerCase()) ||
      activity.location.toLowerCase().includes(text.toLowerCase())
    )
  }

  // 处理搜索提交（按回车）
  handleSearchSubmit(text: string) {
    if (!text.trim()) {
      return
    }

    // 添加到搜索历史
    if (!this.searchHistory.includes(text)) {
      this.searchHistory.unshift(text)
      // 只保留最近10条搜索记录
      if (this.searchHistory.length > 10) {
        this.searchHistory.pop()
      }
    }

    this.showSearchHistory = false
    this.handleSearch(text)
  }

  // 清除搜索历史
  clearSearchHistory() {
    this.searchHistory = []
  }

  deleteSearchHistoryItem(itemToDelete: string) {
    this.searchHistory = this.searchHistory.filter(item => item !== itemToDelete)
  }

  @Builder
  SearchHistoryBuilder() {
    Column() {
      Row() {
        Text('搜索历史')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
        Blank()
        Text('清除')
          .fontSize(14)
          .fontColor('#007AFF')
          .onClick(() => this.clearSearchHistory())
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 8 })

      ForEach(this.searchHistory, (item: string) => {
        Row() {
          Row() {
            Text('\u{1F4C5}')  // 📅
              .fontSize(16)
              .fontColor('#8E8E93')
            Text(item)
              .fontSize(14)
              .fontColor('#333333')
              .margin({ left: 8 })
          }
          .layoutWeight(1)

          Blank()
          Text('\u{2716}') // ✖
            .fontSize(18)
            .fontColor('#8E8E93')
            .onClick(() => this.deleteSearchHistoryItem(item))
        }
        .width('100%')
        .height(44)
        .padding({ left: 16, right: 16 })
        .backgroundColor(Color.White)
        .onClick(() => {
          this.searchText = item
          this.showSearchHistory = false
          this.handleSearch(item)
        })
      })
    }
    .width(330)
    .backgroundColor(Color.White)
    .borderRadius({ topLeft: 0, topRight: 0, bottomLeft: 12, bottomRight: 12 })
    .margin({ top: 4 })
    .shadow({
      radius: 10,
      color: 'rgba(0,0,0,0.1)',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  SearchResultsBuilder() {
    Column() {
      Text('搜索结果')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .padding({ left: 16, right: 16, top: 16, bottom: 8 })

      ForEach(this.searchResults, (item: Activity) => {
        Row() {
          Image(item.image)
            .width(100)
            .height(100)
            .borderRadius(8)
            .objectFit(ImageFit.Cover)

          Column() {
            Text(item.title)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .margin({ bottom: 4 })

            Row() {
              Text('\u{1F550}')  // 🕐
                .fontSize(16)
                .fontColor('#8E8E93')
              Text(item.time)
                .fontSize(13)
                .fontColor('#8E8E93')
            }
            .margin({ bottom: 4 })

            Row() {
              Text('\u{1F4CD}')  // 📍
                .fontSize(16)
                .fontColor('#8E8E93')
              Text(item.location)
                .fontSize(13)
                .fontColor('#8E8E93')
            }

            Row() {
              Text(item.status)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(item.status === '火热报名中' ? '#34C759' : '#8E8E93')
                .backgroundColor(item.status === '火热报名中' ? '#EAF7ED' : '#F2F2F7')
                .borderRadius(16)
                .padding({ left: 10, right: 10, top: 4, bottom: 4 })
                .margin({ top: 8 })

              Image(this.favoriteStates.get(item.id) ? $r('app.media.souc') : $r('app.media.sous'))
                .width(24)
                .height(24)
                .margin({ left: 96, top: 8 })
                .position({ x: 96 })
                .onClick(() => {
                  this.favoriteStates.set(item.id, !this.favoriteStates.get(item.id))
                  if (this.favoriteStates.get(item.id)) {
                    this.favoriteActivities.push(item)
                  } else {
                    this.favoriteActivities = this.favoriteActivities.filter(activity => activity.id !== item.id)
                  }
                })
            }
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 16 })
          .layoutWeight(1)
        }
        .width('100%')
        .padding(16)
        .backgroundColor(Color.White)
        .borderRadius(12)
        .margin({ left: 16, right: 16, top: 8 })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/ActivityPage_wuguixing/ActivityPage',
            params: {
              activity: item
            }
          })
        })
      })
    }
    .width('100%')
  }

  @Builder
  QuickEntryBuilder(title: string, icon: Resource, color: string, onTap: () => void) {
    Column() {
      Column() {
        Image(icon)
          .width(28)
          .height(28)
          .fillColor(Color.White)
      }
      .width(50)
      .height(50)
      .borderRadius(AppSizes.RADIUS_LG)
      .backgroundColor(color)
      .justifyContent(FlexAlign.Center)

      Text(title)
        .fontSize(AppSizes.FONT_SM + 1)
        .fontWeight(FontWeight.Medium)
        .margin({ top: AppSizes.SPACING_SM })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(onTap)
  }

  build() {
    Stack() {
      // 固定头部区域
      Column() {
        // 状态栏占位
        StatusBar()

        // 时间和问候
        Row() {
          Text('10:24')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
          Blank()
          Row({ space: 8 }) {
            Image($r("app.media.souc"))
              .width(16)
              .height(16)
            Image($r("app.media.speaker"))
              .width(16)
              .height(16)
          }
        }
        .width('100%')
        .padding({ top: 5, bottom: 5 })

        // 用户信息
        Row() {
          Image('https://images.unsplash.com/photo-1577202214328-c04b77cefb5d?w=100&h=100&fit=crop')
            .width(48)
            .height(48)
            .borderRadius(24)
            .border({ width: 2, color: Color.White })
          Column() {
            Text('下午好, 同学')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
            Text('今天也是充满活力的一天')
              .fontSize(14)
              .fontColor(Color.White)
              .opacity(0.9)
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 12 })
        }
        .width('100%')
        .margin({ top: 10 })

        // 搜索框
        Row() {
          Image($r("app.media.search"))
            .width(20)
            .height(20)
            .margin({ right: 10 })
          TextInput({ placeholder: '搜索你感兴趣的活动', text: this.searchText })
            .placeholderColor('#99FFFFFF')
            .layoutWeight(1)
            .backgroundColor('transparent')
            .height(40)
            .fontColor(Color.White)
            .onChange((value: string) => {
              this.searchText = value
              this.showSearchHistory = true
              if (!value.trim()) {
                this.isSearching = false
                this.searchResults = []
              }
            })
            .onSubmit((enterKey: EnterKeyType, event: SubmitEvent) => {
              this.handleSearchSubmit(this.searchText)
            })
            .onFocus(() => {
              this.showSearchHistory = true
            })
            .onBlur(() => {
              setTimeout(() => {
                this.showSearchHistory = false
              }, 200)
            })
        }
        .width('100%')
        .height(50)
        .backgroundColor('rgba(255,255,255,0.2)')
        .borderRadius(AppSizes.RADIUS_SM)
        .padding({ left: 16, right: 16 })
        .margin({ top: 16 })

        // 快捷入口
        Grid() {
          GridItem() {
            this.QuickEntryBuilder('快捷预约', $r('app.media.ic_quick_appointment'), AppColors.ENTRY_ORANGE, () => {
              prompt.showToast({
                message: '快捷预约功能',
                duration: 2000
              })
            })
          }

          GridItem() {
            this.QuickEntryBuilder('扫码签到', $r('app.media.ic_scan_checkin'), AppColors.ENTRY_GREEN, () => {
              this.handleCheckIn()
            })
          }

          GridItem() {
            this.QuickEntryBuilder('我的收藏', $r('app.media.ic_my_favorites'), AppColors.ENTRY_BLUE, () => {
              router.pushUrl({
                url: 'pages/HomePage_yanglinsen/FavoritesPage',
                params: {
                  favorites: this.favoriteActivities
                }
              })
            })
          }

          GridItem() {
            this.QuickEntryBuilder('帮助中心', $r('app.media.ic_help_center'), AppColors.ENTRY_TEAL, () => {
              prompt.showToast({
                message: '帮助中心',
                duration: 2000
              })
            })
          }
        }
        .columnsTemplate('1fr 1fr 1fr 1fr')
        .rowsTemplate('1fr')
        .columnsGap(AppSizes.SPACING_LG)
        .rowsGap(AppSizes.SPACING_LG)
        .height(100)
        .padding({
          left: AppSizes.SPACING_LG,
          right: AppSizes.SPACING_LG,
          top: AppSizes.SPACING_LG,
          bottom: AppSizes.SPACING_LG
        })
        .margin({ top: 16 })

        // 热门活动标题
        Row() {
          Text('热门活动')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
          Text('查看全部 >')
            .fontSize(14)
            .fontColor('#8E8E93')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ActivityPage_wuguixing/ActivityPage'
              })
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: AppSizes.SPACING_LG, right: AppSizes.SPACING_LG, top: 16 })
      }
      .width('100%')
      .padding({ top: 16, left: 16, right: 16, bottom: 0 })
      .linearGradient({
        angle: 135,
        colors: [['#007AFF', 0.0], ['#00C6FF', 1.0]]
      })
      .borderRadius({ bottomLeft: 24, bottomRight: 24 })
      .position({ x: 0, y: 0 })
      .zIndex(3)
      .onClick(() => {
        this.showSearchHistory = false
      })

      // 搜索历史
      if (this.showSearchHistory && this.searchHistory.length > 0) {
        Column() {
          this.SearchHistoryBuilder()
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .position({ x: 0, y: 180 })
        .zIndex(7)
      }

      // 可滚动的活动卡片
      Scroll() {
        Column() {
          if (this.isSearching) {
            this.SearchResultsBuilder()
          } else {
            Column() {
              ForEach(this.activities, (item: Activity) => {
                Row() {
                  Image(item.image)
                    .width(100)
                    .height(100)
                    .borderRadius(8)
                    .objectFit(ImageFit.Cover)

                  Column() {
                    Text(item.title)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .margin({ bottom: 4 })

                    Row() {
                      Text('\u{1F550}')  // 🕐
                        .fontSize(16)
                        .fontColor('#8E8E93')
                      Text(item.time)
                        .fontSize(13)
                        .fontColor('#8E8E93')
                    }
                    .margin({ bottom: 4 })

                    Row() {
                      Text('\u{1F4CD}')  // 📍
                        .fontSize(16)
                        .fontColor('#8E8E93')
                      Text(item.location)
                        .fontSize(13)
                        .fontColor('#8E8E93')
                    }

                    Row() {
                      Text(item.status)
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(item.status === '火热报名中' ? '#34C759' : '#8E8E93')
                        .backgroundColor(item.status === '火热报名中' ? '#EAF7ED' : '#F2F2F7')
                        .borderRadius(16)
                        .padding({ left: 10, right: 10, top: 4, bottom: 4 })
                        .margin({ top: 8 })

                      Image(this.favoriteStates.get(item.id) ? $r('app.media.souc') : $r('app.media.sous'))
                        .width(24)
                        .height(24)
                        .margin({ left: 96, top: 8 })
                        .position({ x: 96 })
                        .onClick(() => {
                          this.favoriteStates.set(item.id, !this.favoriteStates.get(item.id))
                          if (this.favoriteStates.get(item.id)) {
                            this.favoriteActivities.push(item)
                          } else {
                            this.favoriteActivities = this.favoriteActivities.filter(activity => activity.id !== item.id)
                          }
                        })
                    }
                  }
                  .alignItems(HorizontalAlign.Start)
                  .margin({ left: 16 })
                  .layoutWeight(1)
                }
                .width('100%')
                .padding(16)
                .backgroundColor(Color.White)
                .borderRadius(12)
                .margin({ left: 16, right: 16, top: 8 })
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/ActivityPage_wuguixing/ActivityPage',
                    params: {
                      activity: item
                    }
                  })
                })
              })
            }
            .padding({ top: 370, bottom: 80 })
          }
        }
      }
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .width('100%')
      .height('100%')
      .zIndex(2)
      .onClick(() => {
        this.showSearchHistory = false
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F2F7')
    .onClick(() => {
      this.showSearchHistory = false
    })
  }
} 