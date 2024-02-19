import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { UserModel } from '../../models/UserModel'
import { Auth, USER_KEY } from '../utils/Auth'
import { vp2vp } from '../utils/Basic'
import { Request } from '../utils/Request'

interface  A {
  clockinNumbers: number
}
@Component
export struct IvClock {
  @Prop
  clockCount: number = 0
  @StorageProp(USER_KEY)
  @Watch('updateUser')
  userJson: string = '{}'
  @State
  user: UserModel = JSON.parse(this.userJson)

  updateUser() {
    this.user = JSON.parse(this.userJson)
  }

  // 每次进入应用，如果登录需要更新用户信息（打卡在第二天可以继续打卡）
  aboutToAppear() {
    if (this.user.token) {
      Request.get<UserModel>('userInfo').then(res => {
        const nickName = res.data.nickName
        const clockinNumbers = res.data.clockinNumbers
        const totalTime = res.data.totalTime
        const avatar = res.data.avatar
        // arkts限制无法使用扩展运算符，暂未找到解决办法
        const newUser:UserModel  = { id: '', username: '',token: '',refreshToken: '',  nickName, clockinNumbers, totalTime, avatar}

        newUser.id = this.user.id
        newUser.username = this.user.username
        newUser.token = this.user.token
        newUser.refreshToken = this.user.refreshToken
        Auth.setUser(newUser)
      })
    }
  }

  build() {
    Stack({ alignContent: Alignment.End }) {
      Image(this.clockCount > 0 ? $r('app.media.clocked') : $r('app.media.unclock'))
        .objectFit(ImageFit.Fill)
      if (this.clockCount > 0) {
        Column() {
          Text('已连续打卡')
            .fontSize(8)
          Text() {
            Span(this.clockCount.toString())
              .fontWeight(600)
              .fontSize(12)
            Span(' 天')
              .fontSize(10)
          }
        }
        .width('50')
      } else {
        Text('打卡')
          .width('50')
          .textAlign(TextAlign.Center)
          .fontSize(vp2vp(18))
          .fontWeight(500)
          .fontColor('#333C4F')
          .margin({ bottom: vp2vp(4) })
      }
    }
    .width(vp2vp(74))
    .height(vp2vp(28))
    .onClick(() => {
      // 1. 已经登录了，但是没有打卡，发请求打卡
      // 2. 已经登录了，但是已经打卡，跳转打卡日历
      // 3. 没登录，去登录
      if (this.user.token) {
        if (this.user.clockinNumbers! > 0) {
          router.pushUrl({ url: 'pages/ClockPage' })
        } else {
          Request.post<A>('clockin')
            .then(res => {
              this.user.clockinNumbers = res.data.clockinNumbers
              Auth.setUser(this.user)
              promptAction.showToast({ message: '打卡成功' })
            })
        }
      } else {
        router.pushUrl({ url: 'pages/LoginPage' })
      }
    })
  }
}