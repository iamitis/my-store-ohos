import { Category, filterProducts, Product } from '../api/ProductApi';
import { ProductCard } from '../components/ProductCard';
import { GenericResponse } from '../utils/RequestUtil';

@Component
export struct ProductList {
  @Consume('router') router: NavPathStack;
  @State category: Category | null = null;
  @State productList: Product[] = [];

  async aboutToAppear() {
    this.category = await this.router.getParamByName('ProductList')[0] as Category;
    const response = await filterProducts(this.category.categoryName, new Map());
    if (response) {
      const parsedResponse: GenericResponse<Product[]> = JSON.parse(response.toString()!);
      if (parsedResponse.code !== '000') {
        console.log('获取商品列表失败' + parsedResponse.msg)
      } else {
        this.productList = parsedResponse.result
      }
    }
  }

  build() {
    NavDestination() {
      if (this.productList.length > 0) {
        List({ space: 15 }) {
          ForEach(this.productList, (item: Product) => {
            ListItem() {
              ProductCard({ product: item })
            }
          })
        } // list
        .width('100%').height('100%')
        .lanes(2)
        .alignListItem(ListItemAlign.Center)
        .margin({ top: 10 })
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      } else {
        Text('暂无商品')
      }
    }.padding({left: 8, right: 8})
    .title(this.category?.displayName)
  }
}