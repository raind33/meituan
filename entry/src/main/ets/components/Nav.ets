@Component
export struct Nav {

  @Builder
  NavItemBuilder(active: boolean, title: string, subTitle?: string) {
    Column(){
      Text(){
        Span(title)
          .fontColor(active ? '#000' : '#666')
          .fontWeight(active? 600: 300)
        if (subTitle) {
          Span(subTitle)
            .fontColor(active ? '#000' : '#666')
            .fontSize(12)
        }
      }
      .layoutWeight(1)

      Text()
        .width(20)
        .height(1)
        .backgroundColor(active ? '#f8c74e' : 'transparent')
        .margin({ left: 6 })
    }
    .width(72)
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Row(){
      this.NavItemBuilder(true, '点菜')
      this.NavItemBuilder(false, '评价', '1796')
      this.NavItemBuilder(false, '商家')
      Row(){
        Image($r('app.media.ic_public_input_search'))
          .width(14)
          .aspectRatio(1)
          .fillColor('#999')
        Text('请输入菜品名称')
          .fontSize(12)
          .fontColor('#999')
      }
      .padding({ left: 5 })
      .layoutWeight(1)
      .height(24)
      .borderRadius(12)
      .backgroundColor('#eee')
    }
    .padding({ left: 15, right: 15 })
    .height(40)
    .border({ width: { bottom: 0.5 }, color: '#e4e4e4' })
  }
}