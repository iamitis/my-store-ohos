import { Cart } from '../api/CartApi'
import { formatPrice } from '../api/ProductApi';

@Component
export struct CartCard {
  @Prop cart: Cart;

  build() {
    Row() {
      Image(this.cart.product.productImages[0]).width(100).height(100)
      Column(){
        Text(this.cart.product?.productName)
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .margin(10)
        Row() {
          Text(formatPrice(this.cart.product.productNowPrice)).margin({left:25}).fontColor('#fff54242')
          Text("数量：" + this.cart.quantity.toString()).margin({left:50})
        }
      }
    }.width('100%')
    .height(100)
    .backgroundColor('#ffd6d4d4')
    .borderRadius(10)
  }
}