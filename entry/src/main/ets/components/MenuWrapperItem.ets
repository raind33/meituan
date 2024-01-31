import promptAction from '@ohos.promptAction'
import { FoodItem } from '../models'
import { addCart } from '../utils'
import { CalcBtn } from './CalcBtn'
import { CartItem } from './CartItem'
@Component
export struct MenuWrapperItem {

  item: FoodItem

  build() {
    Row(){
      Image(this.item.picture)
        .width(90)
        .aspectRatio(1)
      Column({ space: 5 }){
        Text(this.item.name)
          .fontWeight(600)
          .textOverflow({
            overflow: TextOverflow.Ellipsis
          })
          .maxLines(2)
        Text(this.item.description)
          .fontSize(12)
          .textOverflow({
            overflow: TextOverflow.Ellipsis
          })
          .maxLines(1)

        ForEach(this.item.food_tag_list, (tag) => {
          Text(tag)
            .fontSize(10)
            .backgroundColor('#fff5e2')
            .fontColor('#ff8000')
            .padding({ top: 2, bottom: 2, left: 5, right: 5 })
            .borderRadius(2)
        })

        Text(){
          Span(`月销量${this.item.month_saled} `)
          Span(`好评度${this.item.like_ratio_desc}`)
        }
        .fontSize(12)
        .fontColor('#999')
        Row(){
          Text(){
            Span('¥ ')
              .fontSize(10)
              .fontColor('#ff8000')
            Span(this.item.price.toFixed(2))
              .fontWeight(600)
              .fontColor('#ff8000')
          }

          // 加
          CalcBtn({ icon: $r('app.media.ic_public_add_filled') })
            .onClick(() => {
              addCart(this.item)
              promptAction.showToast({ message: '加入购物车成功' })
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .layoutWeight(1)
      .padding({ left: 10 })
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(VerticalAlign.Top)
    .padding(15)
  }
}