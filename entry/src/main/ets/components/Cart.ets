import { CartItemModel } from '../models'
import { clearCart } from '../utils'
import { CartItem } from './CartItem'


@Component
export struct Cart {

  @Link
  cartList: CartItemModel[]

  build() {
    Column(){
      Column(){
        Row(){
          Text('购物车')
            .fontSize(14)
          Text('清空购物车')
            .fontSize(14)
            .fontColor('#999')
            .onClick(() => {
              clearCart()
            })
        }
        .width('100%')
        .height(40)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 15, right: 15 })
        .border({ width: { bottom: 0.5 }, color: '#e4e4e4' })
        // 购物车列表
        List(){
          ForEach(this.cartList, (item: CartItemModel) => {
            ListItem(){
              CartItem({ item })
            }
          })
        }
        .divider({
          strokeWidth: 0.5,
          color: '#e4e4e4'
        })
        .padding({ left: 15, right: 15 })
      }
      .width('100%')
      .padding({ bottom: 100 })
      .backgroundColor('#fff')
      .borderRadius({
        topLeft: 16,
        topRight: 16
      })
    }
    .height('100%')
    .width('100%')
    .backgroundColor('rgba(0,0,0,0.5)')
    .justifyContent(FlexAlign.End)
  }
}