import { Product } from '../api/ProductApi';
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
      Text(this.product?.productName)
      Image(this.product?.productImages[0])
        .width(200)
        .height(200)
        .objectFit(ImageFit.Cover)
    }
  }
}