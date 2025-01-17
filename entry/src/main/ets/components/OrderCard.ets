import { CartCard} from './CartCard'
import {Order} from  '../api/OrderApi'
import {formatDate} from '../utils/CommonUtil'


@Component
export struct OrderCard {
  @Prop order: Order;

  build() {
    Column(){
      Row(){
        Text(this.order.orderInfoId?.toString())
        Text(formatDate(this.order.createDate))
      }
      Row(){
        Text(this.order.totalPrice!.toString());
        Text(this.order.orderStatus);
      }
    }.width('100%')
    .height(100)
    .backgroundColor('#ffd6d4d4')
    .borderRadius(10)
  }
}
