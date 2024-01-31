@Component
export struct Footer {
  @Link
  showCart: boolean

  build() {
    Row(){
      Row(){
        Badge({
          value: '2',
          position: BadgePosition.Right,
          style: { badgeSize: 18 }
        }){
          Image('https://zqran.gitee.io/images/waimai/cart-2.png')
            .width(47)
            .height(69)
            .position({ y: -19 })
        }
        .margin({ left: 20 })
        .onClick(() => {
          this.showCart = !this.showCart
        })

        Column(){
          Text(){
            Span('¥')
              .fontColor('#fff')
              .fontSize(12)
            Span('12')
              .fontColor('#fff')
              .fontSize(24)
          }
          Text('预估另需配送费 ¥5')
            .fontSize(12)
            .fontColor('#999')
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 15 })
        .layoutWeight(1)

        Text('去结算')
          .width(80)
          .height(50)
          .backgroundColor('#f8c74e')
          .textAlign(TextAlign.Center)
          .borderRadius({
            topRight: 25,
            bottomRight: 25
          })
      }
      .height(50)
      .width('100%')
      .backgroundColor('black')
      .borderRadius(25)
    }
    .width('100%')
    .padding(15)
    .height(80)
  }
}