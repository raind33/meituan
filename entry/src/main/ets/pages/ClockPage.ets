@Entry
@Component
struct ClockPage {
  @State message: string = '闹钟';

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Text(this.message)
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .width('100%')


      }
      .padding(15)
      .width('100%')
      .height('100%')


      Row(){
        Text('+')
          .fontColor('white')
          .width(50)
          .height(50)
          .borderRadius(25)
          .backgroundColor('blue')
          .textAlign(TextAlign.Center)
      }
        .padding({bottom:15})
    }
    .width('100%')
    .height('100%')
  }
}