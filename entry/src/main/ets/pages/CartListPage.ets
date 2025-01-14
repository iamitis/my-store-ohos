import { getShoppingCart } from '../api/CartApi';
import { promptAction } from '@kit.ArkUI';
import { GenericResponse } from '../utils/RequestUtil';
import { CartCard } from '../components/CartCard';
import { Cart } from '../api/CartApi'

@Component
export struct CartListPage {
  @State cartList: Cart[] = []
  @Provide('router') router: NavPathStack = new NavPathStack()

  async aboutToAppear() {
    const response = await getShoppingCart(1);
    if (response) {
      const parsedResponse = JSON.parse(response.toString()!) as GenericResponse<Cart[]>;
      this.cartList = parsedResponse.result;
    } else { // TODO: delete me
      promptAction.showToast({ message: '请求数据失败' });
    }
  }

  build() {
    Column() {
      if (this.cartList.length > 0) {
        List({ space: 10 }) {
          ForEach(this.cartList, (item: Cart) => {
            ListItem() {
              CartCard({ cart: item })
            }
          })
        }
      } else {
        Text('暂无购物车商品').fontSize(30)
      }
    }
  }
}