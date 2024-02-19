import { vp2vp } from '../utils/Basic'

interface ITag{
  text: string
  color: Resource
}
@Component
export struct IvTag {
  text!: string
  difficulty: number = 1

  getTag() {
    if (this.difficulty === 3 || this.difficulty === 4) {
      const obj:ITag = { text: '一般', color: $r('app.color.blue') }
      return obj
    } else if (this.difficulty === 5) {
      const obj:ITag = { text: '困难', color: $r('app.color.orange') }
      return obj
    }
    const obj:ITag =  { text: this.text ? this.text : '简单', color: $r('app.color.green') }
    return obj
  }

  build() {
    Text(this.getTag().text)
      .fontColor(this.getTag().color)
      .fontSize(vp2vp(10))
      .width(vp2vp(34))
      .height(vp2vp(18))
      .backgroundColor($r('app.color.gray_bg'))
      .borderRadius(vp2vp(2))
      .textAlign(TextAlign.Center)
      .margin({ right: vp2vp(7) })
  }
}