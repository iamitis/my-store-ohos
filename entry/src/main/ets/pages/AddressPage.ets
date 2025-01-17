import { AddressInfo, getAllAddressInfo } from '../api/UserApi';
import { GenericResponse } from '../utils/RequestUtil';
import { AddressCard } from '../components/AddressCard';
import { promptAction, router } from '@kit.ArkUI';
@Component
export struct AddressPage {
  @State addressList: AddressInfo[] = [];
  @State isGettingAddress: boolean = false;

  async aboutToAppear() {
    this.isGettingAddress = true;
    const response = await getAllAddressInfo(1);
    if (response) {
      const parsedResponse = JSON.parse(response.toString()!) as GenericResponse<AddressInfo[]>;
      this.addressList = parsedResponse.result;
    }
    this.isGettingAddress = false;
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
      if (this.isGettingAddress) {
        LoadingProgress().width(100).height(100);
      }
      List({ space: 15 }) {
        ForEach(this.addressList, (item: AddressInfo, index: number) => {
          ListItem() {
            AddressCard({ address: item, index: index});
          }
        })
      }
      .width('100%')
      .height('100%')
      .padding(15)
      .divider({ strokeWidth: 1, color: '#ffd9d9d9' });

      Flex({ justifyContent: FlexAlign.Center }) { // 包裹 Button 的 Flex 容器
        Button("刷新")
          .fontSize(25)
          .fontColor(Color.White)
          .opacity(0.7)
          .margin({ bottom: 1 })
          .onClick(() => {
            this.aboutToAppear()
          })
          .alignSelf(ItemAlign.End);
      }

      Flex({ justifyContent: FlexAlign.Center }) { // 包裹 Button 的 Flex 容器
        Button("添加地址")
          .fontSize(25)
          .fontColor(Color.White)
          .opacity(0.7)
          .margin({ bottom: 1 })
          .onClick(() => {
            router.pushUrl({
              url: "pages/AddAddress"
            });
          })
          .alignSelf(ItemAlign.End);
      }

      Flex({ justifyContent: FlexAlign.Center }) { // 包裹 Button 的 Flex 容器
        Button("退出登录")
          .fontSize(25)
          .fontColor(Color.White)
          .opacity(0.7)
          .margin({ bottom: 1 })
          .onClick(() => {
            router.pushUrl({
              url: "pages/LoginPage"
            });
          })
          .alignSelf(ItemAlign.End);
      }
    }
  }

  // editAddress(index: number): void {
  //   promptAction.showToast({ message: 'edit: ' + index.toString() });
  // }
}