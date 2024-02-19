import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { IvClock } from '../../common/components/IvClock'
import { Auth, USER_KEY } from '../../common/utils/Auth'
import { formatTime, vp2vp } from '../../common/utils/Basic'
import { UserModel } from '../../models/UserModel'
import emitter from '@ohos.events.emitter'
import { LOGIN_EVENT } from '../../common/constants'

@Preview
@Component
export struct Mine {
  @StorageProp(USER_KEY)
  @Watch('updateUser')
  userJson: string = '{}'
  @State
  user: UserModel = JSON.parse(this.userJson)

  updateUser() {
    this.user = JSON.parse(this.userJson)
  }

  @Builder
  NavBuilder(icon: Resource, title: string,) {
    Column({ space: vp2vp(8) }) {
      Image(icon)
        .width(vp2vp(30))
        .height(vp2vp(30))
        .objectFit(ImageFit.Fill)
      Text(title)
        .fontColor($r('app.color.gray'))
        .fontSize(vp2vp(13))
    }
  }

  @Builder
  CellBuilder(title: string, cb?: () => void) {
    Row() {
      Text(title)
        .fontSize(vp2vp(15))
        .fontColor($r('app.color.black'))
      Image($r('app.media.icon_my_arrow'))
        .fillColor('#C3C3C5')
        .width(vp2vp(18))
        .height(vp2vp(18))
    }
    .width('100%')
    .height(vp2vp(40))
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: vp2vp(15), right: vp2vp(15) })
    .onClick(() => {
      cb && cb()
    })
  }

  build() {
    Column({ space: vp2vp(15) }) {
      // 头部
      Row() {
        Image(this.user.avatar || '/common/images/avatar.png')
          .alt('/common/images/avatar.png')
          .width(vp2vp(55))
          .aspectRatio(1)
          .borderRadius(vp2vp(30))
          .border({ width: 0.5, color: '#e4e4e4' })
        Column({ space: vp2vp(5) }) {
          if (this.user.token) {
            Text(this.user.nickName || this.user.username)
              .fontSize(vp2vp(18))
              .fontWeight(FontWeight.Bold)
            Row() {
              Text('编辑资料')
                .fontSize(vp2vp(12))
                .fontColor($r('app.color.gray'))
              Image($r('app.media.icon_edit'))
                .width(vp2vp(12))
                .aspectRatio(1)
                .fillColor($r('app.color.gray'))
            }
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ProfilePage'
              })
            })
          } else {
            Text('立即登录')
              .fontSize(vp2vp(18))
              .fontWeight(FontWeight.Bold)
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/LoginPage'
                })
              })
          }
        }
        .padding({ left: vp2vp(12) })
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        IvClock({ clockCount: this.user.clockinNumbers || 0 })
      }
      .height(vp2vp(80))

      // 导航
      GridRow({ columns: 4 }) {
        GridCol() {
          this.NavBuilder($r('app.media.icon_my_history'), '历史记录')
        }

        GridCol() {
          this.NavBuilder($r('app.media.icon_my_favo'), '我的收藏')
        }

        GridCol() {
          this.NavBuilder($r('app.media.icon_my_zan'), '我的点赞')
        }

        GridCol() {
          Column() {
            this.NavBuilder($r('app.media.icon_my_time'), '累计学时')
            Row() {
              Text(formatTime(this.user.totalTime))
                .fontColor('#C3C3C5')
                .fontSize(vp2vp(11))
              Image($r('app.media.icon_my_arrow'))
                .fillColor('#C3C3C5')
                .width(vp2vp(13))
                .height(vp2vp(13))
            }
            .margin({ top: vp2vp(3) })
          }
        }
      }
      .backgroundColor('#fff')
      .padding({ top: vp2vp(15), bottom: vp2vp(15) })
      .borderRadius(vp2vp(8))

      Row() {
        Text()
          .width(vp2vp(3))
          .height(vp2vp(12))
          .backgroundColor($r('app.color.green'))
        Text('前端常用词')
          .fontSize(vp2vp(15))
          .fontColor($r('app.color.black'))
          .layoutWeight(1)
          .padding({ left: vp2vp(12) })
        Image($r('app.media.icon_my_new'))
          .width(vp2vp(53))
          .height(vp2vp(22))
          .margin({ right: vp2vp(10) })
      }
      .backgroundColor('#fff')
      .padding({ top: vp2vp(15), bottom: vp2vp(15) })
      .borderRadius(vp2vp(8))

      List() {
        ListItem() {
          this.CellBuilder('推荐分享')
        }

        ListItem() {
          this.CellBuilder('意见反馈')
        }

        ListItem() {
          this.CellBuilder('关于我们')
        }

        if (this.user.token) {
          ListItem() {
            this.CellBuilder('退出登录', async () => {
              // 退出登录
              const res = await promptAction.showDialog({
                title: '温馨提示',
                message: '您确认要退出面试宝典APP吗？',
                buttons: [
                  { text: '取消', color: '#c3c4c5' },
                  { text: '确认', color: $r('app.color.blue') }
                ]
              })

              if (res.index === 1) {
                Auth.delUser()
                emitter.emit(LOGIN_EVENT)
              }
            })
          }
        }
      }
      .padding({ top: vp2vp(10), bottom: vp2vp(10) })
      .borderRadius(vp2vp(8))
      .backgroundColor('#fff')
      .divider({ strokeWidth: 0.5, color: $r('app.color.gray_bg') })

    }
    .padding(vp2vp(15))
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.gray_bg'))
  }
}