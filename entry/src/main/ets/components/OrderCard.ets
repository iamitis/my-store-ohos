import {Order} from  '../api/OrderApi'
import {formatDate} from '../utils/CommonUtil'
import { formatPrice } from '../api/ProductApi'


@Component
export struct OrderCard {
  @Prop order: Order;

  build() {
      Column(){
        Row(){
          Text("订单编号：" + this.order.orderInfoId?.toString()).margin({right:15}).fontSize(15)
          Text("完成日期：" + formatDate(this.order.createDate)).fontSize(15)
        }
        Row(){
          Text("实付：" + formatPrice(this.order.totalPrice!)).margin({left:25, right:25, top:50}).fontSize(15);
          Text("订单状态：" + this.order.orderStatus).margin({top:50}).fontSize(15);
        }
      }.width('100%')
      .height(100)
      .backgroundColor('#ffd6d4d4')
      .borderRadius(10)
    }
}
