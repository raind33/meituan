@Entry
@Component
struct PullRefreshPage {
  @State text: string = '下拉即可刷新';
  @State translateY: number = 0
  @State loading: boolean = false

  // 阻尼效果
  getTranslateVal(distance: number) {
    const point = 60
    if(distance > point) {
      return 60 + (distance- point) * 0.3
    }
    return distance
  }
  build() {
    Row() {
      Stack({ alignContent: Alignment.Top }) {
        Row() {
          if(this.loading) {
            LoadingProgress()
              .width(30)
              .aspectRatio(1)
          }

          Text(this.text)
        }
          .height(100)

        List() {

        }
        .translate({ y: this.translateY })
        .width('100%')
        .height('100%')
        .backgroundColor('red')
        .gesture(
          PanGesture(new PanGestureOptions({ direction: PanDirection.Down }))
            .onActionUpdate((e: GestureEvent) => {
              this.translateY = this.getTranslateVal(e.offsetY)
              if(this.translateY > 100) {
                this.text = '释放即可刷新'
              }
            })
            .onActionEnd((e: GestureEvent) => {
              animateTo({ duration: 300}, () => {
                if(this.translateY > 100) {
                  this.translateY = 100
                  this.text = '加载中...'
                  this.loading = true
                  setTimeout(() => {
                    this.loading = false
                    this.text = '下拉即可刷新'
                    this.translateY = 0
                  }, 2000)
                } else {
                  this.translateY = 0
                }


              })

            })
        )

      }
      .width('100%')
    }
    .height('100%')
  }
}