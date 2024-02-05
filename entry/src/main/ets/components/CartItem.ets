import { CartItemModel } from '../models'
import { addCart, delCart } from '../utils'
import { CalcBtn } from './CalcBtn'
@Component
export struct CartItem {

  @Prop item: CartItemModel

  build() {
    Row(){
      Image(this.item.picture)
        .width(60)
        .aspectRatio(1)
      Column({ space: 10 }){
        Text(this.item.name)
          .textOverflow({
            overflow: TextOverflow.Ellipsis
          })
          .maxLines(2)
          .fontWeight(500)
        Row(){
          Text(){
            Span('¥ ')
              .fontSize(10)
              .fontColor('#ff8000')
            Span(this.item.price.toFixed(2))
              .fontSize(18)
              .fontWeight(600)
              .fontColor('#ff8000')
          }

          Row({ space: 10 }){
            CalcBtn({ icon: $r('app.media.ic_screenshot_line'), plain: true })
              .onClick(() => {
                delCart(this.item.id)
              })
            Text(this.item.count.toString())
              .fontSize(14)
            CalcBtn({ icon: $r('app.media.ic_public_add_filled') })
              .onClick(() => {
                addCart(this.item)
              })
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 10 })
    }
    .padding({ top: 15, bottom: 15 })
    .alignItems(VerticalAlign.Top)
  }
}