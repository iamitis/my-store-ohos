import { formatPrice, Product } from '../api/ProductApi';
import { promptAction } from '@kit.ArkUI';

@Component
export struct ProductDetail {
  @Consume('router') router: NavPathStack;
  @State product: Product | null = null;

  async aboutToAppear() {
    this.product = await this.router.getParamByName('ProductDetail')[0] as Product;
  }

  build() {
    NavDestination() {
      Stack() {
        Swiper() {
          ForEach(this.product?.productImages, (item: string) => {
            Image(item)
              .width('100%').height(300)
              .objectFit(ImageFit.Cover)
          })
        }

        // back button
        Button({ type: ButtonType.Circle }) {
          Image($r('sys.media.ohos_ic_public_arrow_left')).width(30).height(30)
        }
        .width(40)
        .height(40)
        .backgroundColor('#ffd7d6d6')
        .opacity(0.8)
        .position({ top: 10, left: 20 })
        .onClick(() => {
          this.router.pop()
        })
      }

      // price and name
      Column() {
        // price
        Row() {
          Text(formatPrice(this.product?.productNowPrice!))
            .fontSize(23).fontWeight(FontWeight.Bold)
            .fontColor('#fff54242')
          if (this.product?.productNowPrice! < this.product?.productOriginalPrice!) {
            Text(formatPrice(this.product?.productOriginalPrice!))
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#ff818080')
              .decoration({ type: TextDecorationType.LineThrough, color: '#ff818080' })
              .margin({ left: 15 })
          }
          Text('已售' + this.product?.productScoreCount.toString())
            .fontSize(18)
            .fontColor('#ff818080')
            .position({ right: 0, bottom: 1 })
        }.width('100%')
        .alignItems(VerticalAlign.Bottom)

        // name
        Text(this.product?.productName)
          .width('100%')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 10 })
      }.backgroundColor(Color.White)
      .padding(15)

      // description
      Column() {
        Text('商品详情')
          .width('100%')
          .fontSize(20).fontWeight(FontWeight.Bold)
        Text(this.product?.productDescription)
          .margin({top: 10})
          .lineHeight(30)
          .letterSpacing(1)
      }.margin({top: 10})
      .backgroundColor(Color.White)
      .padding(15)

    }.hideTitleBar(true)
    .backgroundColor('#ffdddcdc')
  }
}