import { getAllDiscountProduct, Product } from '../api/ProductApi'
import { ProductCard } from '../components/ProductCard'
import { GenericResponse } from '../utils/RequestUtil'
import { promptAction } from '@kit.ArkUI'
import { ProductDetail } from './ProductDetail'

@Component
export struct Discount {
  @State private discountList: Product[] = []
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
        Row() {
          Text('近期折扣').fontSize(30).fontWeight(FontWeight.Bold)
        }.margin({ top: 10 })

        if (this.discountList.length > 0) {
          List({ space: 10 }) {
            ForEach(this.discountList, (item: Product) => {
              ListItem() {
                ProductCard({ product: item })
                  .onClick(() => {
                    this.router.pushPathByName('ProductDetail', item)
                  })
              }
            })
          } // list
          .lanes({ minLength: 160, maxLength: 160 })
          .alignListItem(ListItemAlign.Center)
          .margin({ top: 10 })
          .layoutWeight(1)
        } else {
          Text('暂无商品')
        }
      } // col
      .justifyContent(FlexAlign.Start)
      .height('100%')
    } // nav
    .navDestination(this.navTo)
  } // build
}