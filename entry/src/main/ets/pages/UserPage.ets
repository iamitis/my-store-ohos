
import {Orders} from './Orders'
import { AddressPage } from './AddressPage'
import { CartListPage } from './CartListPage';

export let userTabsController: TabsController = new TabsController();

@Component
export struct UserPage {
  @State currIndex: number = 0;

  build() {
    Tabs({ barPosition: BarPosition.Start, controller: userTabsController }) {
      TabContent() {
        Orders({currTabIndex: this.currIndex})
      }.tabBar('我的订单')

      TabContent() {
        AddressPage()
      }.tabBar('地址管理')
    }.scrollable(false)
    .onChange((index: number) => {
      this.currIndex = index;
    })
  }
}