import { getAllDiscountProduct, Product } from '../api/ProductApi'
import { ProductCard } from '../components/ProductCard'
import { GenericResponse } from '../utils/RequestUtil'
import { promptAction } from '@kit.ArkUI'
import { ProductDetail } from './ProductDetail'

@Component
export struct Discount {
  @State discountList: Product[] = []
  @Provide('router') router: NavPathStack = new NavPathStack()

  async aboutToAppear() {
    const response = await getAllDiscountProduct()
    if (response) {
      const parsedResponse = JSON.parse(response.toString()!) as GenericResponse<Product[]>;
      this.discountList = parsedResponse.result;
    } else { // TODO: delete me
      promptAction.showToast({ message: '请求数据失败' });
    }
  }

  @Builder
  navTo(name: string) {
    if (name === 'ProductDetail') {
      ProductDetail()
    }
  }

  build() {
    Navigation(this.router) {
      Column() {
        if (this.discountList.length > 0) {
          List({ space: 15 }) {
            ForEach(this.discountList, (item: Product) => {
              ListItem() {
                ProductCard({ product: item })
              }
            })
          } // list
          .height('100%').width('100%')
          .lanes(2)
          .alignListItem(ListItemAlign.Center)
          .margin({ top: 10 })
          .layoutWeight(1)
          .scrollBar(BarState.Off)
        } else {
          Text('暂无商品')
        }
      } // col
      .height('100%')
      .padding({left: 8, right: 8})
    } // nav
    .navDestination(this.navTo)
    .title('热门折扣')
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(true)
  } // build
}