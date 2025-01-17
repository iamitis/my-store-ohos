import {session} from '../utils/RequestUtil'
import { Cart } from './CartApi';
import  {Product} from  './ProductApi'

const ORDER = "users";

export interface Order{
  orderInfoId?: number,
  userId?: number,
  products: Cart[],
  addressInfoId?: number,
  orderStatus?: OrderStatus,
  totalPrice?:number,
  createDate: Date,
}

export enum OrderStatus {
  UNPAID = 'UNPAID',
  UNSEND = 'UNSEND',
  UNGET = 'UNGET',
  UNCOMMENT = 'UNCOMMENT',
  DONE = 'DONE',
}

export async function getAllOrders(userId:number) {
  return await session.get(`${ORDER}/getAllOrders/${userId}`);
}