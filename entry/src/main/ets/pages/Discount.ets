import { getAllDiscountProduct, Product } from '../api/ProductApi'
import { ProductCard } from '../components/ProductCard'
import { GenericResponse } from '../utils/RequestUtil'
import { promptAction } from '@kit.ArkUI'

@Component
export struct Discount {
  @State discountList: Product[] = [];
  router: NavPathStack = new NavPathStack();
  @State isLoading: boolean = false;

  async aboutToAppear() {
    this.isLoading = true
    const response = await getAllDiscountProduct()
    if (response) {
      const parsedResponse = JSON.parse(response.toString()!) as GenericResponse<Product[]>;
      this.discountList = parsedResponse.result;
    }
    this.isLoading = false;
  }

  build() {
    Navigation(this.router) {
      Column() {
        if (this.isLoading) {
          LoadingProgress()
            .width(100).height(100)
        }
        if (this.discountList.length > 0) {
          List({ space: 15 }) {
            ForEach(this.discountList, (item: Product) => {
              ListItem() {
                ProductCard({ product: item })
                  .onClick(() => {
                    this.router.pushPathByName('ProductDetail', item)
                  })
              }
            })
          } // list
          .height('100%')
          .width('100%')
          .lanes(2)
          .alignListItem(ListItemAlign.Center)
          .margin({ top: 10 })
          .layoutWeight(1)
          .scrollBar(BarState.Off)
        } else if (!this.isLoading) {
          Text('暂无商品')
        }
      } // col
      .height('100%')
      .padding({ left: 8, right: 8 })
    } // nav
    .title('热门折扣')
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(true)
    .backgroundColor('#FFFAFA')
  } // build
}