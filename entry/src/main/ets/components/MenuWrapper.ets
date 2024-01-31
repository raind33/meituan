import { Category, FoodItem } from '../models'
import { MenuWrapperItem } from './MenuWrapperItem'
@Component
export struct MenuWrapper {

  @Link
  categoryList: Category[]

  @State
  activeIndex: number = 0

  build() {
    Row() {
      Column() {
        ForEach(this.categoryList, (item: Category, index) => {
          Text(item.name)
            .height(50)
            .width('100%')
            .textAlign(TextAlign.Center)
            .fontSize(14)
            .backgroundColor(this.activeIndex === index ? '#fff': 'transparent')
            .onClick(() => {
              this.activeIndex = index
            })
        })
      }
      .width(90)

      // List 可以有 scroll 功能，嵌套组件必须 ListItem
      List(){
        ForEach(this.categoryList[this.activeIndex]?.foods, (item: FoodItem) => {
          ListItem(){
            // MenuWrapperItem
            MenuWrapperItem({ item })
          }
        })
      }
      .layoutWeight(1)
      .height('100%')
      .backgroundColor('#fff')
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
    .layoutWeight(1)
    .backgroundColor('#eee')
  }
}