import { session } from '../utils/RequestUtil';
import { Product } from './ProductApi'

const CARTS = "users";

export interface Cart {
  cartItemId?: number,
  userId: number,
  quantity: number,
  product: Product,
  // ...
}

export interface ProductOptionValue {
    productOptionValueId?:number,

}

export async function getShoppingCart(userId: number) {
  return await session.get(`${CARTS}/getShoppingCart/${userId}`);
}