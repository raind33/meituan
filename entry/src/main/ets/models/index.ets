export class Category {
  tag!: string
  name!: string
  foods!: FoodItem[]
}

export class FoodItem {
  id!: number
  name!: string
  like_ratio_desc!: string
  month_saled!: number
  unit!: string
  food_tag_list!: string[]
  price!: number
  picture!: string
  description!: string
  tag!: string
  count!: number
}

export class CartItemModel {
  id!: number
  name!: string
  price!: number
  picture!: string
  count!: number
}