import http from '@ohos.net.http'
import { Cart } from '../components/Cart'
import { Footer } from '../components/Footer'
import { MenuWrapper } from '../components/MenuWrapper'
import { Nav } from '../components/Nav'
import { KEY } from '../utils'
import { CartItemModel, Category } from '../models'

const req = http.createHttp()

PersistentStorage.PersistProp(KEY, '[]')
@Entry
@Component
struct Index {

  @State
  showCart: boolean = false

  @State
  categoryList: Category[] = []

  @StorageProp(KEY)
  @Watch('onCartChange')
  cartJson: string = '[]'

  @State
  cartList: CartItemModel[] = JSON.parse(this.cartJson)

  onCartChange () {
    this.cartList = JSON.parse(this.cartJson)
  }


  // build 执行前
  aboutToAppear() {
    req.request('https://zhoushugang.gitee.io/fe2022/takeaway.json')
      .then(res => {

        const categoryList = JSON.parse(res.result as string) as Category[]
        this.categoryList = categoryList

      })
  }

  build() {
    Stack({alignContent: Alignment.Bottom}){
      Column(){
        Nav()
        MenuWrapper({ categoryList: $categoryList })
      }
      .height('100%')
      .width('100%')
      if(this.showCart) {
        Cart({ cartList: $cartList })
      }
      Footer({ showCart: $showCart })
    }
    .height('100%')
    .width('100%')
  }
}