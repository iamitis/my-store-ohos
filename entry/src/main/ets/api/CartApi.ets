import { session } from '../utils/RequestUtil';
import { Product } from './ProductApi'

export interface Cart {
  cartItemId?: number,
  userId: number,
  quantity: number,
  product: Product,
  // ...
}

const CARTS = "users";

export async function getShoppingCart(userId: number) {
  return await session.get(`${CARTS}/getShoppingCart/${userId}`);
}