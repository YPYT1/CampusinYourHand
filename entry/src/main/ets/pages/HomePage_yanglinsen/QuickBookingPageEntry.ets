import { QuickBookingPage } from './QuickBookingPage'

@Entry
@Component
struct QuickBookingPageEntry {
  build() {
    Column() {
      QuickBookingPage()
    }
    .width('100%')
    .height('100%')
  }
} 