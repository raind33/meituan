import mediaquery from '@ohos.mediaquery'
import { vp2vp } from '../common/utils/Basic'
// import { Home } from '../views/Index/Home'
// import { Interview } from '../views/Index/Interview'
// import { Mine } from '../views/Index/Mine'
// import { Project } from '../views/Index/Project'

class ToolBarItem {
  defaultIcon!: string | Resource
  activeIcon!: string | Resource
  label!: string
}

@Entry
@Component
struct Index {
  @State
  activeIndex: number = 0
  toolBars: ToolBarItem[] = [
    { defaultIcon: $r('app.media.home'), activeIcon: $r('app.media.home_select'), label: '首页' },
    { defaultIcon: $r('app.media.project'), activeIcon: $r('app.media.project_select'), label: '项目' },
    { defaultIcon: $r('app.media.interview'), activeIcon: $r('app.media.interview_select'), label: '面经' },
    { defaultIcon: $r('app.media.mine'), activeIcon: $r('app.media.mine_select'), label: '我的' }
  ]
  @State
  isLandscape: boolean = false
  listenerScreen = mediaquery.matchMediaSync('(orientation: landscape) and (device-type: tablet)')

  aboutToAppear() {
    this.listenerScreen.on('change', (result) => {
      this.isLandscape = result.matches
    })
  }

  @Builder
  TabBarBuilder(item: ToolBarItem, index: number) {
    Column() {
      Image(this.activeIndex === index ? item.activeIcon : item.defaultIcon)
        .width(vp2vp(24))
      Text(item.label)
        .fontSize(vp2vp(12))
        .margin({ top: vp2vp(4) })
        .fontColor(this.activeIndex === index ? '#000' : '#aaa')
    }
  }

  build() {
    Tabs({
      index: this.activeIndex
    }) {
      ForEach(this.toolBars, (item: ToolBarItem, index: number) => {
        TabContent() {
          Text('2323')
          // if (index ===0) Home()
          // else if (index === 1) Project()
          // else if (index === 2) Interview()
          // else Mine()
        }
        .tabBar(this.TabBarBuilder(item, index))
      })
    }
    .vertical(this.isLandscape)
    .barPosition(this.isLandscape ? BarPosition.Start : BarPosition.End)
    .barHeight(this.isLandscape ? vp2vp(400) : vp2vp(50))
    .onChange(index => this.activeIndex = index)
  }
}