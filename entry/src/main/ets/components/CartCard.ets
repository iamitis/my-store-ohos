import { Cart } from '../api/CartApi'
import { formatPrice } from '../api/ProductApi';

@Component
export struct CartCard {
  @Prop cart: Cart;
  @State backColor: string = '#fff';

  build() {
    Row() {
      Image(this.cart.product.productImages[0])
        .width(100).height(100)
        .borderRadius(10)
      Column() {
        Text(this.cart.product?.productName)
          .width('100%')
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .padding(10)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Row() {
          Text(formatPrice(this.cart.product.productNowPrice)).margin({ left: 10 }).fontColor('#fff54242')
          Text("数量：" + this.cart.quantity.toString()).margin({ left: 50 })
        }.width('100%')
      }
    }.width('100%')
    .height(100)
    .borderRadius(10)
    .backgroundColor(this.backColor)
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down) {
        this.backColor = '#ffd9d9d9';
      } else if (event.type === TouchType.Up) {
        this.backColor = '#ffffff';
      }
    })
  }
}