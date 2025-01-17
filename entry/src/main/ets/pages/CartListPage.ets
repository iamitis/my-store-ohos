import { getShoppingCart } from '../api/CartApi';
import { promptAction, router } from '@kit.ArkUI';
import { GenericResponse } from '../utils/RequestUtil';
import { CartCard } from '../components/CartCard';
import { Cart } from '../api/CartApi'
import { formatPrice } from '../api/ProductApi';

@Component
export struct CartListPage {
  @State cartList: Cart[] = []
  @Provide('router') router: NavPathStack = new NavPathStack()
  @State buyButtonColor: string = '#fff54242';
  @State totalPrice:number = 0

  async aboutToAppear() {
    const response = await getShoppingCart(1);
    if (response) {
      const parsedResponse = JSON.parse(response.toString()!) as GenericResponse<Cart[]>;
      this.cartList = parsedResponse.result;
      for(let i = 0; i < this.cartList.length; i++ ) {
        this.totalPrice += this.cartList[i].quantity * this.cartList[i].product.productNowPrice
      }
    } else { // TODO: delete me
      promptAction.showToast({ message: '请求数据失败' });
    }
  }

  build() {
    Navigation(this.router) {
      if (this.cartList.length > 0) {
        List({ space: 10 }) {
          ForEach(this.cartList, (item: Cart) => {
            ListItem() {
              CartCard({ cart: item })
                .onClick(()=>{
                  this.router.pushPathByName('ProductDetail', item.product)
                })
            }
          })
        }.padding({left: 8, right: 8})
        .width('100%').height('100%')
        .scrollBar(BarState.Off)

        // 结算按钮
        Row() {
          Text('总计：' + formatPrice(this.totalPrice)).margin(15).fontSize(15).fontWeight(FontWeight.Bold)
          Button('立即结算', {type: ButtonType.Capsule, stateEffect:false})
            .backgroundColor(this.buyButtonColor)
            .width(90)
            .height('100%').position({right:0})
            .onClick(()=>{

            })
        }.width('100%').height(50)
        .backgroundColor(Color.White)
        .position({ bottom: 1, right: 10 })
      } else {
        Text('暂无购物车商品').fontSize(30)
      }
    }.title('购物车列表')
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(true)
  }
}