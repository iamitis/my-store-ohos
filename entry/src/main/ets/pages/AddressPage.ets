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
            AddressCard({ address: item, index: index, handleEdit: this.editAddress })
          }
        })
      }.width('100%').height('100%')
      .padding(15)
      .divider({ strokeWidth: 1, color: '#ffd9d9d9' })
    }
  }

  editAddress(index: number): void {
    promptAction.showToast({ message: 'edit: ' + index.toString() })
  }
}