import { vp2vp } from '../utils/Basic'

@Component
export struct IvSearch {

  textAlign: FlexAlign = FlexAlign.Start

  build() {
    Row() {
      Image($r('app.media.icon_public_search'))
        .width(vp2vp(15))
        .aspectRatio(1)
        .fillColor($r('app.color.gray'))

      Text('请输入关键词')
        .fontSize(vp2vp(14))
        .fontColor($r('app.color.gray'))
        .margin({ left: vp2vp(3) })
    }
    .layoutWeight(1)
    .height(vp2vp(28))
    .backgroundColor($r('app.color.gray_bg'))
    .borderRadius(vp2vp(14))
    .padding({ left: vp2vp(10), right: vp2vp(10) })
    .justifyContent(this.textAlign)
  }
}