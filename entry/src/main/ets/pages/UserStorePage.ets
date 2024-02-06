import { User, UserStore } from '../utils/userStore'
@Entry
@Component
struct Index {

  userStore!: UserStore

  @State
  user: User = {}

  aboutToAppear(){
    // 查
    this.userStore = new UserStore()
    // aboutToAppear 不能写 await
    this.userStore.getUser()
      .then(user => {
        this.user = user
      })
  }

  build() {
    Column({ space: 15 }) {
      Text(`用户数据：${this.user.name} + ${this.user.age}`)
      Button('修改')
        .onClick(() => {
          this.userStore.setUser({
            name: 'tom',
            age: 18
          })
        })
      Button('获取')
        .onClick(async () => {
          const user = await this.userStore.getUser()
          this.user = user
        })
      Button('删除')
        .onClick(() => {
          this.userStore.delUser()
        })
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}