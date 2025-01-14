import { CATEGORIES, Category } from '../api/ProductApi'
import { ProductDetail } from './ProductDetail';
import { ProductList } from './ProductList';

@Component
export struct CategoryPage {
  private categoryList: Category[] = CATEGORIES;
  @Provide('router') router: NavPathStack = new NavPathStack();

  @Builder
  navTo(name: string) {
    if (name === 'ProductList') {
      ProductList();
    } else if (name === 'ProductDetail') {
      ProductDetail();
    }
  }

  build() {
    Navigation(this.router) {
      List({ space: 12 }) {
        ForEach(this.categoryList, (item: Category) => {
          ListItem() {
            CategoryCard({ category: item })
              .onClick(() => {
                this.router.pushPathByName('ProductList', item)
              })
          }
        })
      }.width('100%')
      .height('100%')
      .alignListItem(ListItemAlign.Center)
      .margin({ top: 20 })
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring, {alwaysEnabled: false})
    }.navDestination(this.navTo)
    .hideToolBar(true)
    .padding({bottom: 0})
    .height('100%')
    .title('分类')
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(true)
  }

}

@Component
struct CategoryCard {
  @Prop category: Category;

  build() {
    Row() {
      Image(this.category.categoryImage)
        .width(65).height(65)
        .borderRadius(32.5)
        .margin({ left: 25 })
      Text(this.category.displayName)
        .fontSize(25).fontWeight(FontWeight.Bold)
        .margin({ left: 25 })
    }.width('90%')
    .height(80)
    .backgroundColor('#ffd6d4d4')
    .borderRadius(10)
  }
}