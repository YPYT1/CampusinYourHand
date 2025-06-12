/**
 * 通用工具函数
 */

export class CommonUtils {
  /**
   * 格式化日期
   * @param date 日期对象
   * @param format 格式字符串，如 'YYYY-MM-DD HH:mm'
   * @returns 格式化后的日期字符串
   */
  static formatDate(date: Date, format: string = 'YYYY-MM-DD HH:mm'): string {
    const year = date.getFullYear()
    const month = String(date.getMonth() + 1).padStart(2, '0')
    const day = String(date.getDate()).padStart(2, '0')
    const hours = String(date.getHours()).padStart(2, '0')
    const minutes = String(date.getMinutes()).padStart(2, '0')
    const seconds = String(date.getSeconds()).padStart(2, '0')

    return format
      .replace('YYYY', String(year))
      .replace('MM', month)
      .replace('DD', day)
      .replace('HH', hours)
      .replace('mm', minutes)
      .replace('ss', seconds)
  }

  /**
   * 防抖函数
   * @param fn 要防抖的函数
   * @param delay 延迟时间（毫秒）
   * @returns 防抖后的函数
   */
  static debounce(fn: Function, delay: number): Function {
    let timeoutId: number
    return function (...args: any[]) {
      clearTimeout(timeoutId)
      timeoutId = setTimeout(() => fn.apply(this, args), delay)
    }
  }

  /**
   * 节流函数
   * @param fn 要节流的函数
   * @param interval 间隔时间（毫秒）
   * @returns 节流后的函数
   */
  static throttle(fn: Function, interval: number): Function {
    let lastTime = 0
    return function (...args: any[]) {
      const now = Date.now()
      if (now - lastTime >= interval) {
        lastTime = now
        fn.apply(this, args)
      }
    }
  }

  /**
   * 检查是否为空字符串
   * @param str 要检查的字符串
   * @returns 是否为空
   */
  static isEmpty(str: string | null | undefined): boolean {
    return !str || str.trim().length === 0
  }

  /**
   * 检查手机号格式
   * @param phone 手机号
   * @returns 是否为有效手机号
   */
  static isValidPhone(phone: string): boolean {
    const phoneRegex = /^1[3-9]\d{9}$/
    return phoneRegex.test(phone)
  }

  /**
   * 检查学号格式（假设为8-12位数字）
   * @param studentId 学号
   * @returns 是否为有效学号
   */
  static isValidStudentId(studentId: string): boolean {
    const studentIdRegex = /^\d{8,12}$/
    return studentIdRegex.test(studentId)
  }

  /**
   * 生成随机ID
   * @param length ID长度
   * @returns 随机ID字符串
   */
  static generateId(length: number = 8): string {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    let result = ''
    for (let i = 0; i < length; i++) {
      result += chars.charAt(Math.floor(Math.random() * chars.length))
    }
    return result
  }

  /**
   * 深拷贝对象
   * @param obj 要拷贝的对象
   * @returns 拷贝后的对象
   */
  static deepClone<T>(obj: T): T {
    return JSON.parse(JSON.stringify(obj))
  }

  /**
   * 延迟执行
   * @param ms 延迟时间（毫秒）
   * @returns Promise
   */
  static delay(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms))
  }
} 