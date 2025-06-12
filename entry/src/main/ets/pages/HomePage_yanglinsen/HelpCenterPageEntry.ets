import { HelpCenterPage } from './HelpCenterPage'

@Entry
@Component
struct HelpCenterPageEntry {
  build() {
    Column() {
      HelpCenterPage()
    }
    .width('100%')
    .height('100%')
  }
} 