import router from '@ohos.router'
import { UserModel } from '../../models/UserModel'


export const USER_KEY = 'interview-user'
const PASS_LIST = ['pages/LoginPage', 'pages/Index']

export class Auth {
  static initLocalUser() {
    PersistentStorage.PersistProp(USER_KEY, '{}')
  }

  static setUser(user: UserModel) {
    AppStorage.Set(USER_KEY, JSON.stringify(user))
  }

  static getUser() {
    const user = AppStorage.Get<string>(USER_KEY) || '{}'
    return JSON.parse(user) as UserModel
  }

  static delUser() {
    AppStorage.Set(USER_KEY, '{}')
  }

  static pushUrl(options: router.RouterOptions) {
    // 需要登录的页面 且 没有登录  ====>  跳转登录页面 且 需要把页面的地址和参数传递给登录页面
    const user = this.getUser()
    if (!PASS_LIST.includes(options.url) && !user.token) {
      // 去登录
      router.pushUrl({
        url: 'pages/LoginPage',
        params: {
          ...options.params,
          return_url: options.url
        }
      })

      return false
    }
    router.pushUrl(options)
  }
}