import { CartListPage } from './CartListPage';
import { Discount } from './Discount';
import { UserPage } from './UserPage';

@Entry
@Component
struct Index {
  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        Discount()
      }.tabBar('折扣')

      TabContent() {
        Text('分类')
      }.tabBar('分类')

      TabContent() {
        CartListPage()
      }.tabBar('购物车')

      TabContent() {
        UserPage()
      }.tabBar('我的')
    }.scrollable(false)
  }
}