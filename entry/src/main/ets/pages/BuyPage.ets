import { formatPrice, Product } from '../api/ProductApi'
import { AddressCard } from '../components/AddressCard';
import { GenericResponse } from '../utils/RequestUtil';
import { promptAction } from '@kit.ArkUI';
import { AddressInfo } from '../api/UserApi';
import { getAllAddressInfo } from '../api/UserApi';

@Builder
export function BuyPageBuilder(name: string, param: Product) {
  BuyPage({ product: param });
}

@Component
export struct BuyPage {
  router: NavPathStack = new NavPathStack();
  @State product: Product | null = null;
  scroller: Scroller = new Scroller();
  @State totalPrice: number = 0;
  @State count: number = 1;
  @State addressList: AddressInfo[] = [];
  @State selectedAddress: AddressInfo | null = null;
  @State isAddrExpanded: boolean = false;
  @State selectedBorder: BorderOptions = {width: 0, color: '#ffd9d9d9', style: BorderStyle.Solid};

  async aboutToAppear() {
    this.totalPrice = this.product?.productNowPrice ?? 0;

    // 获取用户地址
    const response = await getAllAddressInfo(1);
    if (response) {
      const parsedResponse = JSON.parse(response.toString()!) as GenericResponse<AddressInfo[]>;
      this.addressList = parsedResponse.result;
      this.selectedAddress = this.addressList[0];
    }
  }

  build() {
    NavDestination() {
      Scroll(this.scroller) {
        Column({ space: 10 }) {
          if (this.selectedAddress) {
            AddressCard({ address: this.selectedAddress })
              .width('100%')
              .onClick(() => {
                this.isAddrExpanded = !this.isAddrExpanded;
                this.selectedBorder.width = this.isAddrExpanded ? 1 : 0;
              })
              .border(this.selectedBorder)
          }

          if (this.isAddrExpanded && this.addressList.length > 1) {
            ForEach(this.addressList, (item: AddressInfo) => {
              if (item.addressInfoId !== this.selectedAddress?.addressInfoId) {
                AddressCard({ address: item })
                  .width('100%')
                  .onClick(() => {
                    this.selectedAddress = item;
                    this.selectedBorder.width = 0;
                    this.isAddrExpanded = false;
                  })
              }
            })
          }

          Divider()

          Row({ space: 10 }) {
            Image(this.product?.productImages[0])
              .borderRadius(5)
              .height(130).width(130)
            Column() {
              Text('实付' + formatPrice(this.totalPrice))
                .width('100%')
                .fontSize(18).fontWeight(FontWeight.Bold)
                .fontColor('#fff54242')
              Row() {
                Button('-', { type: ButtonType.Normal })
                  .backgroundColor('#ffe2dede')
                  .onClick(() => {
                    if (this.count > 1) {
                      --this.count
                      this.updatePrice();
                    }
                  })
                TextInput({ text: this.count.toString() })
                  .type(InputType.Number)
                  .width(60)
                  .textAlign(TextAlign.Center)
                  .borderRadius(0)
                  .onChange(() => {
                    if (this.count < 1) {
                      this.count = 1;
                    } else if (this.count > 999) {
                      this.count = 999;
                    }
                    this.updatePrice();
                  })
                Button('+', { type: ButtonType.Normal })
                  .backgroundColor('#ffe2dede')
                  .onClick(() => {
                    if (this.count < 999) {
                      ++this.count;
                      this.updatePrice();
                    }
                  })
              }.alignSelf(ItemAlign.Start)
            }.height(130)
            .padding({ top: 10, bottom: 10 })
            .justifyContent(FlexAlign.SpaceBetween)
          }

          Divider()

          Button('立即支付' + formatPrice(this.totalPrice), { type: ButtonType.Normal })
            .width('100%')
            .backgroundColor('#fff54242')
            .onClick(this.handlePay)
            .fontWeight(FontWeight.Bold)
        }.padding(15)
      }
    }.onReady((context: NavDestinationContext) => {
      this.router = context.pathStack;
    })
  }

  updatePrice() {
    this.totalPrice = this.product?.productNowPrice! * this.count;
  }

  async handlePay() {
    promptAction.showToast({message: '下单成功'})
  }
}