import { HomePage } from './HomePage_yanglinsen/HomePage'
import { ActivityPage } from './ActivityPage_wuguixing/ActivityPage'
import { RecordsPage } from './RecordsPage_yangyang/RecordsPage'
import { ProfilePage } from './ProfilePage_luojiaxin/ProfilePage'

type IconType = 'home' | 'activity' | 'records' | 'profile' | 'default'

interface Icons {
  home: string
  activity: string
  records: string
  profile: string
  default: string
}

@Entry
@Component
struct Index {
  @State currentTabIndex: number = 0

  private icons: Icons = {
    home: '🏠',
    activity: '📝',
    records: '📋',
    profile: '👤',
    default: '📱'
  }

  private getIcon(type: IconType): string {
    switch (type) {
      case 'home':
        return this.icons.home
      case 'activity':
        return this.icons.activity
      case 'records':
        return this.icons.records
      case 'profile':
        return this.icons.profile
      default:
        return this.icons.default
    }
  }

  build() {
    Tabs({ 
      index: this.currentTabIndex,
      barPosition: BarPosition.End 
    }) {
      // 首页 - 杨林森
      TabContent() {
        HomePage()
      }
      .tabBar(this.TabBuilder('首页', 0, 'home'))

      // 活动页 - 吴贵兴
      TabContent() {
        ActivityPage()
      }
      .tabBar(this.TabBuilder('活动', 1, 'activity'))

      // 记录页 - 杨洋
      TabContent() {
        RecordsPage()
      }
      .tabBar(this.TabBuilder('记录', 2, 'records'))

      // 个人中心 - 罗嘉欣
      TabContent() {
        ProfilePage()
      }
      .tabBar(this.TabBuilder('我的', 3, 'profile'))
    }
    .onChange((index: number) => {
      this.currentTabIndex = index
    })
    .scrollable(false)
    .animationDuration(300)
    .backgroundColor('#F2F2F7')
  }

  @Builder TabBuilder(title: string, targetIndex: number, iconType: IconType) {
    Column() {
      this.IconBuilder(iconType, this.currentTabIndex === targetIndex)
      Text(title)
        .fontSize(10)
        .fontWeight(500)
        .fontColor(this.currentTabIndex === targetIndex ? '#007AFF' : '#8E8E93')
        .margin({ top: 4 })
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentTabIndex = targetIndex
    })
  }

  @Builder IconBuilder(iconType: IconType, isActive: boolean) {
    Text(this.getIcon(iconType))
        .fontSize(24)
        .fontColor(isActive ? '#007AFF' : '#8E8E93')
  }
}