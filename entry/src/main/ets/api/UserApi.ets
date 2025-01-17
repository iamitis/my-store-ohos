import { session } from '../utils/RequestUtil'

const USERS = 'users';

export interface User {
  id?: number,
  role: string,
  phone: string,
  password: string,
  related_phone: string,
};

export async function getUserById(id: number) {
  return await session.get(`${USERS}/getInformation/${id}`);
}

export interface AddressInfo {
  addressInfoId?: number,
  userId: number,
  areaAddress: string[], // 省市区
  detailAddress: string, // 详细地址
  phone: string,
  receiver: string, // 收件人
  isDefault: boolean, // 是否为默认地址
}

export async function getAllAddressInfo(userId: number) {
  return await session.get(`users/getAllAddressInfo/${userId}`);
}
export interface LoginInfo {
  phone: string,
  password: string,
};

export async function login(thePhone: string,thePassword: string) {
  const loginInfo: LoginInfo = {
    phone: thePhone,
    password: thePassword,
  }
  return await session.post(`${USERS}/login`, loginInfo)
}

export async function register(user:User) {
  return await session.post(`${USERS}/register`,user);
}
export async function deleteAddressInfo(addressInfoId: number) {
  return await session.delete(`${USERS}/deleteAddressInfo/${addressInfoId}`);
}