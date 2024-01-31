interface IUser {
  age?: number
}
const storage = LocalStorage.GetShared()

@Entry(storage)
@Component
struct OtherPage {
  @State message: string = 'Hello World'
  @LocalStorageProp('user')
  user: IUser = {}
  build() {
    Row() {
      Column() {
        Text(this.user.age.toString())
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}