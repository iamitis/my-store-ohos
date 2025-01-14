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