import { AddressInfo, getAllAddressInfo } from '../api/UserApi'
import { GenericResponse } from '../utils/RequestUtil';
import { AddressCard } from '../components/AddressCard';
import { promptAction } from '@kit.ArkUI';

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
    Column() {
      if (this.isGettingAddress) {
        LoadingProgress().width(100).height(100)
      }
      List({ space: 15 }) {
        ForEach(this.addressList, (item: AddressInfo, index: number) => {
          ListItem() {
            // AddressCard({ address: item, index: index, handleEdit: this.editAddress })
            AddressCard({ address: item, index: index})
          }
        })
      }.width('100%').height('100%')
      .padding(15)
      .divider({ strokeWidth: 1, color: '#ffd9d9d9' })

      Row() {
          Text('添加地址')
            .textAlign(TextAlign.Center)
            .width('100%')
            .fontColor(Color.White).fontWeight(FontWeight.Bold)

      }.width(200).height(50)
      .position({ bottom: 10, right: 10 })
      .borderRadius(25)
    }
  }

  // editAddress(index: number): void {
  //   promptAction.showToast({ message: 'edit: ' + index.toString() })
  // }
}