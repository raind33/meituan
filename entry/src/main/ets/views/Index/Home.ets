import emitter from '@ohos.events.emitter'
import { IvClock } from '../../common/components/IvClock'
import { IvQuestionList } from '../../common/components/IvQuestionList'
import { IvSearch } from '../../common/components/IvSearch'
import { IvSkeleton } from '../../common/components/IvSkeleton'
import { LOGIN_EVENT } from '../../common/constants'
import { USER_KEY } from '../../common/utils/Auth'
import { vp2vp } from '../../common/utils/Basic'
import { Request } from '../../common/utils/Request'
import { QuestionTypeModel } from '../../models/QuestionTypeModel'
import { UserModel } from '../../models/UserModel'

@Component
export struct Home {
  @State
  loading: boolean = false
  @State
  questionTypeList: QuestionTypeModel[] = []
  @State
  activeIndex: number = 0


  @StorageProp(USER_KEY)
  @Watch('updateUser')
  userJson: string = '{}'
  @State
  user: UserModel = JSON.parse(this.userJson)

  updateUser() {
    this.user = JSON.parse(this.userJson)
  }

  aboutToAppear() {
    this.getQuestionTypeList()

    // 绑定事件，接收通知
    emitter.on(LOGIN_EVENT, () => {
     this.getQuestionTypeList()
    })
  }

  async getQuestionTypeList() {
    this.loading = true
    const res = await Request.get<QuestionTypeModel[]>('question/type')
    this.questionTypeList = res.data
    this.loading = false
  }

  @Builder
  SkeletonBuilder() {
    Column() {
      Row({ space: vp2vp(15) }) {
        IvSkeleton()
        IvSkeleton({ widthValue: vp2vp(60) })
        IvSkeleton({ widthValue: vp2vp(80) })
      }
      .width('100%')
      .margin({ bottom: vp2vp(15) })

      List({ space: vp2vp(15) }) {
        ForEach([1, 2, 3, 4, 5, 6, 7], () => {
          ListItem() {
            Column({ space: vp2vp(15) }) {
              Row({ space: vp2vp(15) }) {
                IvSkeleton({ widthValue: vp2vp(30) })
                IvSkeleton({ widthValue: '100%' }).layoutWeight(1)
              }

              Row({ space: vp2vp(15) }) {
                IvSkeleton({ widthValue: vp2vp(50) })
                IvSkeleton({ widthValue: vp2vp(50) })
                IvSkeleton({ widthValue: vp2vp(50) })
              }
              .width('100%')
            }
            .padding({ top: vp2vp(10), bottom: vp2vp(10) })
          }
        })
      }
      .divider({ strokeWidth: 0.5, color: $r('app.color.gray_bg') })
    }
    .width('100%')
    .padding(vp2vp(15))
    .layoutWeight(1)
  }

  @Builder
  TabItemBuilder(item: QuestionTypeModel, index: number) {
    Row() {
      Stack({ alignContent: Alignment.Bottom }) {
        Text(item.name)
          .fontSize(vp2vp(15))
          .height(vp2vp(44))
          .fontColor(this.activeIndex === index ? $r('app.color.black') : $r('app.color.gray'))
        Text()
          .width(this.activeIndex === index ? vp2vp(20) : vp2vp(0))
          .height(vp2vp(2))
          .backgroundColor($r('app.color.black'))
          .animation({
            duration: this.activeIndex === index ? 300 : 0
          })
      }
      .margin(index === 0 ? { left: vp2vp(15) } : {})

      if (item.displayNewestFlag === 1) {
        Image($r('app.media.new'))
          .width(vp2vp(34))
          .height(vp2vp(14))
          .padding({ left: vp2vp(5) })
      }
    }
    .padding({ right: vp2vp(15) })
  }

  build() {
    Column() {
      Row({ space: vp2vp(10) }) {
        IvSearch()

        IvClock({ clockCount: this.user.clockinNumbers || 0 })
      }
      .padding(vp2vp(15))

      Row() {
        Swiper() {
          Flex() {
            Image('/common/images/banner_ai.png')
              .objectFit(ImageFit.Fill)
          }
          .padding({ left: vp2vp(15), right: vp2vp(15) })

          Flex() {
            Image('/common/images/banner_pj.png')
              .objectFit(ImageFit.Fill)
          }
          .padding({ left: vp2vp(15), right: vp2vp(15) })

          Flex() {
            Image('/common/images/banner_qa.png')
              .objectFit(ImageFit.Fill)
          }
          .padding({ left: vp2vp(15), right: vp2vp(15) })
        }
        .autoPlay(true)
        .indicator(false)
      }
      .aspectRatio(2.8)

      // 显示隐藏试题列表和试题类型
      if (this.loading) {
        this.SkeletonBuilder()
      } else {
        Tabs({ index: this.activeIndex }) {
          ForEach(this.questionTypeList, (item: QuestionTypeModel, index: number) => {
            TabContent() {
              IvQuestionList({ type: item.id, selfIndex: index, activeIndex: this.activeIndex })
            }
            .tabBar(this.TabItemBuilder(item, index))
            .height('100%')
          })
        }
        .layoutWeight(1)
        .barMode(BarMode.Scrollable)
        .onChange(index => this.activeIndex = index)
      }

    }
    .width('100%')
    .height('100%')
  }
}