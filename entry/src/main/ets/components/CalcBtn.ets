@Component
export struct CalcBtn {

  // 图标
  @Prop
  icon: Resource
  // 是不是朴素的
  @Prop
  plain: boolean

  build() {
    Row() {
      Image(this.icon)
        .width(10)
        .aspectRatio(1)
    }
    .width(16)
    .height(16)
    .borderRadius(4)
    .backgroundColor(this.plain ? '#fff' : '#f8c74e')
    .border(this.plain ? { width: 0.5, color: '#f8c74e' } : {})
    .justifyContent(FlexAlign.Center)
  }
}