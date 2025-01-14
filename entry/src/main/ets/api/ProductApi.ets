import { session } from '../utils/RequestUtil';

export interface Product {
  productId: number,
  productCategory: string,
  productName: string,
  productOriginalPrice: number,
  productNowPrice: number,
  productImages: string[],
  productDescription: string,
  productScore: number,
  productScoreCount: number,
};

const PRODUCTS = 'newProducts';

export async function getAllDiscountProduct() {
  return await session.get(`${PRODUCTS}/getAllDiscountProduct`);
}