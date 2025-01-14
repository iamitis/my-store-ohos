import { CartListPage } from './CartListPage';
import { CategoryPage } from './CategoryPage';
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
        CategoryPage()
      }.tabBar('分类')

      TabContent() {
        CartListPage()
      }.tabBar('购物车')

      TabContent() {
        UserPage()
      }.tabBar('我的')
    }.scrollable(false)
    .height('100%')
  }
}