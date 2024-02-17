@Entry
@Component
struct Index {

  // 2. 画笔
  settings = new RenderingContextSettings(true)
  context = new CanvasRenderingContext2D(this.settings)

  // canvas 需要 ImageBitMap 图片
  panImg = new ImageBitmap('/images/ic_clock_pan.png')
  secondImg = new ImageBitmap('/images/ic_second_pointer.png')

  build() {
    Column({ space: 15 }) {

      // 1. 画布
      Canvas(this.context)
        .width(252)
        .aspectRatio(1)
        .onReady(() => {
          // 准备就绪

          // 1. 绘制边框矩形
          // this.context.strokeRect(100, 100, 50, 50)

          // 2. 绘制填充矩形
          // this.context.fillRect(150,150, 50, 50)

          // 3. 绘制图片
          // 角度 360  弧度 2π   1° = π/180
          // rotate 旋转的中心在 0 0 位置
          this.context.drawImage(this.panImg, 0, 0, 252, 252)

          // 4. 绘制秒针
          this.context.translate(126, 126)
          this.context.rotate(180 * Math.PI / 180)
          this.context.translate(-126, -126)
          this.context.drawImage(this.secondImg, 122, 0, 8, 252)
        })

    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}