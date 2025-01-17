import { CartListPage } from './CartListPage';
import { CategoryPage } from './CategoryPage';
import { Discount } from './Discount';
import { UserPage } from './UserPage';

export const tabsController: TabsController = new TabsController();

@Entry
@Component
struct Index {
  @State currIndex: number = 0;

  build() {
    Tabs({ barPosition: BarPosition.End, controller: tabsController }) {
      TabContent() {
        Discount()
      }.tabBar('折扣')

      TabContent() {
        CategoryPage()
      }.tabBar('分类')

      TabContent() {
        CartListPage({currTabIndex: this.currIndex})
      }.tabBar('购物车')

      TabContent() {
        UserPage()
      }.tabBar('我的')
    }.scrollable(false)
    .height('100%')
    .onChange((index: number) => {
      this.currIndex = index;
    })
  }
}