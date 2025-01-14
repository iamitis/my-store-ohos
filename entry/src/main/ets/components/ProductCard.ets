import { Product } from '../api/ProductApi';

@Component
export struct ProductCard {
  @Prop private product: Product;

  build() {
    Column() {
      Text(this.product.productName)
    }.width(160)
    .height(160)
    .backgroundColor(Color.Gray)
    .borderRadius(10)
  }
}