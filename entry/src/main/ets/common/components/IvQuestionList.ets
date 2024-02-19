import { BasicDataSource } from '../../models/BasicDataSource'
import { QueryQuestionListParams, QuestionItemModel } from '../../models/QuestionItemModel'
import { vp2vp } from '../utils/Basic'
import { Request } from '../utils/Request'
import { IvQuestionItem } from './IvQuestionItem'

interface B {
  total: number
  pageTotal: number
  rows: QuestionItemModel[]
}
// LazyForEach 的数据源
class QuestionListDataSource extends BasicDataSource {

  private questionList: QuestionItemModel[] = []

  public totalCount(): number {
    return this.questionList.length;
  }

  public getData(index: number): QuestionItemModel {
    return this.questionList[index];
  }

  public addData(index: number, data: QuestionItemModel): void {
    this.questionList.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public pushData(data: QuestionItemModel): void {
    this.questionList.push(data);
    this.notifyDataAdd(this.questionList.length - 1);
  }
}


@Component
export struct IvQuestionList {
  @Prop
  type: number
  selfIndex!: number
  @Prop
  @Watch('initQuestionList')
  activeIndex: number
  params: QueryQuestionListParams = {
    questionBankType: 10,
    page: 1,
    type: this.type
  }
  @State
  questionList: QuestionItemModel[] = []
  @State
  finished: boolean = false
  @State
  loading: boolean = false

  questionListDataSource = new QuestionListDataSource()

  aboutToAppear() {
    this.initQuestionList()
  }

  initQuestionList() {
    if (this.activeIndex === this.selfIndex && this.questionListDataSource.totalCount() === 0) {
      this.getQuestionList()
    }
  }

  getQuestionList() {
    if (this.loading || this.finished) return

    this.loading = true
    Request.get<B>('question/list', this.params)
      .then(res => {

        // this.questionList.push(...res.data.rows)
        res.data.rows.forEach(item => {
          this.questionListDataSource.pushData(item)
        })

        if (this.params.page < res.data.pageTotal) {
          this.params.page++
        } else {
          this.finished = true
        }
        this.loading = false
      })
      .catch(() => {
        this.loading = false
      })
  }

  @Builder
  LoadingBuilder() {
    if (this.finished) {
      Row() {
        Text('没有更多了~')
          .fontColor($r('app.color.gray'))
          .fontSize(vp2vp(14))
      }
      .width('100%')
      .height(vp2vp(50))
      .justifyContent(FlexAlign.Center)
    } else {
      if (this.loading) {
        Row() {
          LoadingProgress()
            .width(vp2vp(24))
            .margin({ right: vp2vp(5) })
          Text('加载中...')
            .fontColor($r('app.color.gray'))
            .fontSize(vp2vp(14))
        }
        .width('100%')
        .height(vp2vp(50))
        .justifyContent(FlexAlign.Center)
      }
    }
  }

  build() {
    List() {
      LazyForEach(this.questionListDataSource, (item: QuestionItemModel) => {
        ListItem() {
          IvQuestionItem({ item })
        }
      })
      // 加一个 loading
      ListItem(){
        this.LoadingBuilder()
      }
    }
    .divider({
      strokeWidth: 0.5,
      color: $r('app.color.gray_bg')
    })
    .padding({ left: vp2vp(15), right: vp2vp(15) })
    .height('100%')
    .width('100%')
    .onReachEnd(() => {
      this.getQuestionList()
    })
  }
}