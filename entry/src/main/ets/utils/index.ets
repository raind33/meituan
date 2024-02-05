import { CartItemModel, FoodItem } from '../models'

export const KEY = 'meituan-cart'

// 加入购物车的函数
export const addCart = (food: FoodItem | CartItemModel) => {
  const json = AppStorage.Get<string>(KEY) || '[]'
  const list = JSON.parse(json) as CartItemModel[]
  const f = list.find(item => item.id === food.id)
  // 之前已经有商品
  if (f) {
    f.count ++
  }
  // 之前没有
  else {
    const id = food.id
    const price = food.price
    const picture = food.picture
    const name = food.name

    const cartFood: CartItemModel = {  id, price, picture, name , count: 1}
    list.push(cartFood)
  }
  AppStorage.Set(KEY, JSON.stringify(list))
}

export const delCart = ( id: number ) => {
  const json = AppStorage.Get<string>(KEY) || '[]'
  const list = JSON.parse(json) as CartItemModel[]
  const f = list.find(item => item.id === id)
  if ( f && f.count > 0) {
    f.count --
  }
  AppStorage.Set(KEY, JSON.stringify(list))
}

export const clearCart = () => {
  AppStorage.Set(KEY, '[]')
}