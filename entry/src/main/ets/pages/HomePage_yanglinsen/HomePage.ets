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
  image: Resource
  status: string
}

interface TabItem {
  icon: string
  text: string
  isActive: boolean
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
  
  // 持久化收藏数据
  private storageKey = 'favorite_activities'

  // 模拟活动数据
  private activities: Activity[] = [
    {
      id: '1',
      title: 'HarmonyOS 技术分享会',
      time: '今天 19:00 - 21:00',
      location: '教学楼 B201',
      image: $r('app.media.start'),
      status: '火热报名中'
    },
    {
      id: '2',
      title: '校园摄影大赛作品展',
      time: '周三至周五 全天',
      location: '图书馆一楼大厅',
      image: $r('app.media.activity'),
      status: '已结束'
    },
    {
      id: '3',
      title: '王者荣耀比赛',
      time: '周六至周天 全天',
      location: '电竞一楼大厅',
      image: $r('app.media.good'),
      status: '火热报名中'
    },
    {
      id: '4',
      title: '校园摇滚音乐节',
      time: '下周五 19:30',
      location: '学校操场',
      image: $r('app.media.speaker'),
      status: '火热报名中'
    }
  ]

  aboutToAppear() {
    this.getCurrentLocation()
    this.loadFavorites()
  }

  // 加载收藏数据
  loadFavorites() {
    try {
      const storedFavorites = AppStorage.get<Activity[]>(this.storageKey)
      if (storedFavorites && Array.isArray(storedFavorites)) {
        this.favoriteActivities = storedFavorites
        // 重建收藏状态Map
        this.favoriteStates.clear()
        this.favoriteActivities.forEach(activity => {
          this.favoriteStates.set(activity.id, true)
        })
      }
    } catch (error) {
      console.error('加载收藏数据失败:', JSON.stringify(error))
    }
  }

  // 保存收藏数据
  saveFavorites() {
    try {
      AppStorage.setOrCreate<Activity[]>(this.storageKey, this.favoriteActivities)
    } catch (error) {
      console.error('保存收藏数据失败:', JSON.stringify(error))
    }
  }

  // 切换收藏状态
  toggleFavorite(activity: Activity) {
    const isCurrentlyFavorited = this.favoriteStates.get(activity.id) || false
    
    if (isCurrentlyFavorited) {
      // 取消收藏
      this.favoriteStates.set(activity.id, false)
      this.favoriteActivities = this.favoriteActivities.filter(item => item.id !== activity.id)
    } else {
      // 添加收藏
      this.favoriteStates.set(activity.id, true)
      this.favoriteActivities.push(activity)
    }
    
    // 保存到本地存储
    this.saveFavorites()
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
                  this.toggleFavorite(item)
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
  NormalContentBuilder() {
    Column() {
      // Quick Entry Grid
      Grid() {
        GridItem() {
          Column() {
            Column() {
              Text('📝')
                .fontSize(AppSizes.ICON_BASE)
                .fontColor(AppColors.TEXT_WHITE)
            }
            .width(50)
            .height(50)
            .borderRadius(AppSizes.RADIUS_LG)
            .backgroundColor(AppColors.ENTRY_ORANGE)
            .justifyContent(FlexAlign.Center)

            Text('快捷预约')
              .fontSize(AppSizes.FONT_SM + 1)
              .fontWeight(FontWeight.Medium)
              .margin({ top: AppSizes.SPACING_SM })
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/HomePage_yanglinsen/QuickBookingPageEntry'
            }).catch((error: Error) => {
              console.error('路由跳转失败:', error.message)
            })
          })
        }

        GridItem() {
          Column() {
            Column() {
              Text('\u{1F4CD}') // 📍
                .fontSize(AppSizes.ICON_BASE)
                .fontColor(AppColors.TEXT_WHITE)
            }
            .width(50)
            .height(50)
            .borderRadius(AppSizes.RADIUS_LG)
            .backgroundColor(AppColors.ENTRY_GREEN)
            .justifyContent(FlexAlign.Center)
            Text('定位签到')
              .fontSize(AppSizes.FONT_SM + 1)
              .fontWeight(FontWeight.Medium)
              .margin({ top: AppSizes.SPACING_SM })
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.handleCheckIn()
          })
        }

        GridItem() {
          Column() {
            Column() {
              Text('⭐')
                .fontSize(AppSizes.ICON_BASE)
                .fontColor(AppColors.TEXT_WHITE)
            }
            .width(50)
            .height(50)
            .borderRadius(AppSizes.RADIUS_LG)
            .backgroundColor(AppColors.ENTRY_BLUE)
            .justifyContent(FlexAlign.Center)

            Text('我的收藏')
              .fontSize(AppSizes.FONT_SM + 1)
              .fontWeight(FontWeight.Medium)
              .margin({ top: AppSizes.SPACING_SM })
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/HomePage_yanglinsen/FavoritesPage'
            })
          })
        }

        GridItem() {
          Column() {
            Column() {
              Text('❓')
                .fontSize(AppSizes.ICON_BASE)
                .fontColor(AppColors.TEXT_WHITE)
            }
            .width(50)
            .height(50)
            .borderRadius(AppSizes.RADIUS_LG)
            .backgroundColor(AppColors.ENTRY_TEAL)
            .justifyContent(FlexAlign.Center)

            Text('帮助中心')
              .fontSize(AppSizes.FONT_SM + 1)
              .fontWeight(FontWeight.Medium)
              .margin({ top: AppSizes.SPACING_SM })
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/HomePage_yanglinsen/HelpCenterPageEntry'
            }).catch((error: Error) => {
              console.error('路由跳转失败:', error.message)
            })
          })
        }
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr')
      .columnsGap(AppSizes.SPACING_LG)
      .rowsGap(AppSizes.SPACING_LG)
      .height(120)
      .padding({
        left: 10,
        right: 10,
        top: AppSizes.SPACING_LG,
        bottom: AppSizes.SPACING_LG
      })
      .backgroundColor(AppColors.BG_CARD)
      .borderRadius({ topLeft: AppSizes.RADIUS_LG, topRight: AppSizes.RADIUS_LG, bottomLeft: 0, bottomRight: 0 })
      .margin({ left: 10, right: 10, top: 0 })
      .shadow({
        radius: 10,
        color: 'rgba(0,0,0,0.05)',
        offsetX: 0,
        offsetY: 4
      })

      // Hot Activities Section
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
      .padding({ left: 10, right: 10, top: 16 })
      .backgroundColor(AppColors.BG_CARD)
      .margin({ left: 10, right: 10 })
      .borderRadius({ bottomLeft: AppSizes.RADIUS_LG, bottomRight: AppSizes.RADIUS_LG })
    }
  }

  build() {
    Stack() {
      // Header Section with gradient background
      Column() {
        // User Info
        Row() {
          Image($r('app.media.img'))
            .width(48)
            .height(48)
            .borderRadius(24)
            .border({ width: 2, color: Color.White })

          Column() {
            Text('下午好, 同学')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
            Text('今天也是充满活力的一天')
              .fontSize(14)
              .fontColor(Color.White)
              .opacity(0.8)
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 12 })
          .layoutWeight(1)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

        // Search Bar
        Row() {
          Text('\u{1F50D}')  // 🔍
            .fontSize(20)
            .fontColor(Color.White)
            .opacity(0.8)
          TextInput({ placeholder: '搜索你感兴趣的活动', text: this.searchText })
            .fontSize(14)
            .fontColor(Color.White)
            .backgroundColor('transparent')
            .placeholderColor('rgba(255,255,255,0.8)')
            .placeholderFont({ size: 14 })
            .layoutWeight(1)
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
              // 延迟关闭搜索历史，以便用户能点击历史记录
              setTimeout(() => {
                this.showSearchHistory = false
              }, 200)
            })
        }
        .width('100%')
        .height(40)
        .backgroundColor('rgba(255,255,255,0.2)')
        .borderRadius(8)
        .padding({ left: 16, right: 16 })
        .margin({ top: 16 })
        .justifyContent(FlexAlign.Start)
      }
      .width('100%')
      .padding({ top: 16, left: 16, right: 16, bottom: 70 })
      .linearGradient({
        angle: 135,
        colors: [['#007AFF', 0.0], ['#00C6FF', 1.0]]
      })
      .borderRadius({ bottomLeft: 24, bottomRight: 24 })
      .position({ x: 0, y: 0 })
      .zIndex(3)
      .onClick(() => {
        // 点击Header区域时，让搜索框失去焦点
        this.showSearchHistory = false
      })

      // Search History
      if (this.showSearchHistory && this.searchHistory.length > 0) {
        Column() {
          this.SearchHistoryBuilder()
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .position({ x: 0, y: 124 }) // Position absolutely within Stack
        .zIndex(7) // Ensure it's above other content
      }

      // Fixed Content Section (Quick Entry Grid + Hot Activities Section)
      Column() {
        this.NormalContentBuilder()
      }
      .width('100%')
      .position({ x: 0, y: 150 })
      .zIndex(5)
      .onClick(() => {
        // 点击Fixed Content区域时，让搜索框失去焦点
        this.showSearchHistory = false
      })

      // Scrollable Activity Cards
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
                          this.toggleFavorite(item)
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
            .padding({ top: 290, bottom: 80 }) // 减少顶部padding，为热门活动标题留出空间
          }
        }
      }
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .width('100%')
      .height('100%')
      .zIndex(2)
      .onClick(() => {
        // 点击Scroll区域时，让搜索框失去焦点
        this.showSearchHistory = false
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F2F7')
    .onClick(() => {
      // 点击Stack区域时，让搜索框失去焦点
      this.showSearchHistory = false
    })
  }
} 