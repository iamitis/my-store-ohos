import { AddressInfo } from '../api/UserApi';

@Component
export struct AddressCard {
  @Prop address: AddressInfo;
  @State backColor: string = '#ffffff';

  build() {
    if (this.address) {
      Row({ space: 10 }) {
        Image($r('app.media.ic_statusbar_gps')).width(30).height(30)
        Column({ space: 5 }) {
          Text(this.address.areaAddress.join(' '))
            .fontColor('#ff605f5f')
            .width('100%')
          Text(this.address.detailAddress)
            .fontSize(18).fontWeight(FontWeight.Bold)
            .maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
          Row({ space: 10 }) {
            Text(this.address.receiver)
              .fontColor('#ff605f5f')
            Text(this.address.phone)
              .fontColor('#ff605f5f')
          }.width('100%')
        }
      }.width('100%')
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
}


