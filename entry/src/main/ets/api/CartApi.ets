import { session } from '../utils/RequestUtil';
import { Product } from './ProductApi'

const CARTS = "users";

export interface Cart {
  cartItemId?: number,
  userId: number,
  quantity: number,
  product: Product,
  productOptionValues?: ProductOptionValue[],
  cartItemDate?: Date,
  // ...
}

export interface ProductOptionValue {
    productOptionValueId?:number,
    productId?: number,
    productOptionName?:string,
    value?: string
}

export async function getShoppingCart(userId: number) {
  return await session.get(`${CARTS}/getShoppingCart/${userId}`);
}

export async function addToShoppingCart(cartItem: Cart) {
  return await session.post(`${CARTS}/addCartItem`, cartItem)
}