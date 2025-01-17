import { AddressPage } from './AddressPage'

@Component
export struct UserPage {
  build() {
    Tabs({ barPosition: BarPosition.Start }) {
      TabContent() {
        Text('Profile')
      }.tabBar('总览')

      TabContent() {
        Text('订单')
      }.tabBar('订单')

      TabContent() {
        Text('历史')
      }.tabBar('历史')

      TabContent() {
        AddressPage()
      }.tabBar('地址')
    }.scrollable(false)
  }
}