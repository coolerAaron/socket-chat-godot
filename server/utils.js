import { v4 as uuid } from "uuid";
export const createUserId = (existingUsers) => {
  let newId = uuid();
  while (!!existingUsers[newId]) {
    newId = uuid();
  }
  return newId;
};
