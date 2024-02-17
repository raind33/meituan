// 1. 基准地址维护
import http from '@ohos.net.http'
import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { Auth } from './Auth'
import { Logger } from './Logger'
// 2. 携带请求参数处理
// 3. 设置token
// 4. 提供常用请求方式调用api


export const BaseURL = 'https://api-harmony-teach.itheima.net/hm/'

const req = http.createHttp()

const request = <T = unknown>(url: string, method: http.RequestMethod = http.RequestMethod.GET, params: object = {
}) => {

  // 一些配置
  const options: http.HttpRequestOptions = {
    header: {
      'Content-Type': 'application/json'
    },
    readTimeout: 30000,
    method
  }

  // 处理请求参数
  let fullUrl = BaseURL + url
  if (method === http.RequestMethod.GET) {
    const strArr = Object.keys(params).map(key => `${key}=${params[key]}`)
    fullUrl += `?${strArr.join('&')}`
  } else {
    options.extraData = params
  }

  // 携带token
  const user = Auth.getUser()
  if (user.token) {
    options.header['Authorization'] = `Bearer ${user.token}}`
  }


  Logger.info(`REQUEST→${url}→${method}`, JSON.stringify(params))
  // 处理业务失败
  // 处理登录失效
  // 添加日志行为
  return req.request(fullUrl, options)
    .then(res => {

      // 成功
      if (res.result) {
        Logger.info(`RESPONSE→${url}→${method}`, res.result.toString().substring(0, 250))
        const result = JSON.parse(res.result as string) as {
          code: number
          message: string
          data: T
        }
        if (result.code === 10000) {
          return result
        }

        // 登录失效
        if ( result.code === 401 ) {
          Auth.delUser()
          router.pushUrl({
            url: 'pages/LoginPage'
          }, router.RouterMode.Single)
          // 如果页面栈中已经存在 LoginPage 将不再限制页面栈，而是把 LoginPage 放在最顶部
        }
      }

      // 没有响应数据认为失败，业务状态码错误也失败
      return Promise.reject(res.result)
    })
    .catch(e => {
      Logger.info(`RESPONSE→${url}→${method}`, JSON.stringify(e).substring(0, 250))
      promptAction.showToast({ message: '网络错误' })
      // 失败
      return Promise.reject(e)
    })
    .finally(() => {
      // 释放请求资源暂用
      req.destroy()
    })
}

export class Request {
  static get<T>(url: string, params?: object) {
    return request<T>(url, http.RequestMethod.GET, params)
  }

  static post<T>(url: string, params?: object) {
    return request<T>(url, http.RequestMethod.POST, params)
  }

  static put<T>(url: string, params?: object) {
    return request<T>(url, http.RequestMethod.PUT, params)
  }

  static delete<T>(url: string, params?: object) {
    return request<T>(url, http.RequestMethod.DELETE, params)
  }
}