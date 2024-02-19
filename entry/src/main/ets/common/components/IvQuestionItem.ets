import { QuestionItemModel } from '../../models/QuestionItemModel'
import { Auth } from '../utils/Auth'
import { vp2vp } from '../utils/Basic'
import { IvTag } from './IvTag'

@Component
export struct IvQuestionItem {

  @Link
  item: QuestionItemModel

  @Builder
  SplitBuilder() {
    Text('|')
      .width(vp2vp(30))
      .textAlign(TextAlign.Center)
      .fontColor('#C3C3C5')
      .fontSize(vp2vp(12))
  }

  @Builder
  TextBuilder(text: string) {
    Text(text)
      .fontColor('#C3C3C5')
      .fontSize(vp2vp(12))
  }

  build() {
    Column() {
      Row() {
        IvTag({ difficulty: this.item.difficulty })
        Text(this.item.stem)
          .fontSize(vp2vp(15))
          .layoutWeight(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
      }.width('100%')

      Row() {
        this.TextBuilder(`点赞 ${this.item.likeCount}`)
        this.SplitBuilder()
        this.TextBuilder(`浏览 ${this.item.views}`)
        if ( this.item.readFlag === 1 ) {
          this.SplitBuilder()
          this.TextBuilder(`已看过`)
        }
      }
      .width('100%')
      .margin({ top: vp2vp(10) })
    }
    .height(vp2vp(80))
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .onClick(() => {
      Auth.pushUrl({
        url: 'pages/QuestionDetailPage',
        params: this.item
      })
    })
  }
}