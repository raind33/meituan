import { vp2vp } from '../utils/Basic'

@Component
export struct IvSkeleton {
  widthValue: number | string = 100
  heightValue: number | string = 20
  @State
  translateValue: string = '-100%'

  build() {
    Stack() {
      Text()
        .backgroundColor($r('app.color.gray_bg'))
        .height('100%')
        .width('100%')
      Text()
        .linearGradient({
          angle: 90,
          colors: [
            ['rgba(255,255,255,0)', 0],
            ['rgba(255,255,255,0.5)', 0.5],
            ['rgba(255,255,255,0)', 1]
          ]
        })
        .height('100%')
        .width('100%')
        .translate({
          x: this.translateValue,
        })
        .animation({
          duration: 1500,
          iterations: -1
        })
    }
    .height(this.heightValue)
    .width(this.widthValue)
    .borderRadius(vp2vp(4))
    .clip(true)
    .onAppear(() => {
      this.translateValue = '100%'
    })
  }
}