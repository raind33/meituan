import { vp2vp } from '../utils/Basic'

@CustomDialog
export struct IvLoadingDialog {
  message: string = ''
  controller: CustomDialogController

  build() {
    Column() {
      LoadingProgress()
        .width(vp2vp(48))
        .aspectRatio(1)
        .color('#fff')
      if (this.message) {
        Text(this.message)
          .fontSize(vp2vp(14))
          .fontColor('#fff')
      }
    }
    .width(vp2vp(120))
    .aspectRatio(1)
    .backgroundColor('rgba(0,0,0,0.5)')
    .borderRadius(vp2vp(16))
    .justifyContent(FlexAlign.Center)
  }
}