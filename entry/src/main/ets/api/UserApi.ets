import { session } from '../utils/RequestUtil'

export interface User {
  id?: number,
  role: string,
  phone: string,
  password: string,
  related_phone: string,
};

const USERS = 'users';

export async function getUserById(id: number) {
  return await session.get(`${USERS}/getInformation/${id}`);
}