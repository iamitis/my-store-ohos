
import {Orders} from './Orders'
import { AddressPage } from './AddressPage'

@Component
export struct UserPage {
  build() {
    Tabs({ barPosition: BarPosition.Start }) {
      TabContent() {
        Orders()
      }.tabBar('我的订单')

      TabContent() {
        AddressPage()
      }.tabBar('地址管理')
    }.scrollable(false)
  }
}