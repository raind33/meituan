
import display from '@ohos.display'
import deviceInfo from '@ohos.deviceInfo'

// 设计稿宽度
const designWidth = 375
// 物理像素
const devicePhysics = display.getDefaultDisplaySync().width || 375

export const vp2vp = (originSize: number) => {
  // useSize =  deviceWidth / designWidth * measureSize
  // 只有 手机 才需要
  console.log(devicePhysics+'')
  if (deviceInfo.deviceType !== 'tablet') {
    return px2vp(devicePhysics) / designWidth * originSize
  }
  return originSize
}