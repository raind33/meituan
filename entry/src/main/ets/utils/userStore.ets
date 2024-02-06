
import preferences from '@ohos.data.preferences'

export class User {
  name?: string
  age?: number
}


export class UserStore {

  KEY = 'user-info'

  getStore () {
    return preferences.getPreferences(getContext(this), 'userStore')
  }

  async setUser (user: User) {
    const store = await this.getStore()
    store.put(this.KEY, JSON.stringify(user))
    store.flush()
  }

  async getUser () {
    const store = await this.getStore()
    const str = await store.get(this.KEY, '{}')
    const user = JSON.parse(str as string) as User
    return user
  }

  async delUser () {
    const store = await this.getStore()
    await store.delete(this.KEY)
    store.flush()
  }

}