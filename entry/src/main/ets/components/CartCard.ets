import { Cart } from '../api/CartApi'

@Component
export struct CartCard {
  @Prop cart: Cart;

  build() {
    Row() {
      Image(this.cart.product.productImages[0]).width(100).height(100)
      Text(this.cart.product.productName)
    }.width('100%')
    .height(100)
    .backgroundColor('#ffd6d4d4')
    .borderRadius(10)
  }
}i