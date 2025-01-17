import {Orders} from './Orders'

@Component
export struct UserPage {
  build() {
    Tabs({barPosition: BarPosition.Start}) {
      TabContent() {
        Orders()
      }.tabBar('订单')

      TabContent() {
        Text('地址')
      }.tabBar('地址')
    }.scrollable(false)
  }
}