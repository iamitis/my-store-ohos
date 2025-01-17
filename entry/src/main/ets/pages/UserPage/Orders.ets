import {getAllOrders} from '../../api/OrderApi'
import {Order} from '../../api/OrderApi'
import {OrderCard} from '../../components/OrderCard'
import { GenericResponse } from '../../utils/RequestUtil';
import { promptAction } from '@kit.ArkUI';

@Component
export struct Orders {
  @State orderList: Order[] = [];
  @Provide('router') router: NavPathStack = new NavPathStack();

  async aboutToAppear(){
    const  response = await getAllOrders(1);
    if(response) {
      const parsedResponse = JSON.parse(response.toString()!) as GenericResponse<Order[]>;
      this.orderList = parsedResponse.result;
    } else {
      promptAction.showToast({message: '请求数据失败'});
    }
  }

  build() {
    if(this.orderList.length > 0) {
      List({space : 10}) {
        ForEach(this.orderList, (item: Order) => {
          ListItem(){
            OrderCard({order : item})
          }
        })
      }.padding({left: 8, right: 8})
      .width('100%').height('100%')
      .scrollBar(BarState.Off)
    } else {
      Text('暂无订单').fontSize(30)
    }
  }
}