/**
 * 数据模型定义
 * 包含应用中使用的所有数据结构
 */

/**
 * 简化版活动接口，用于首页展示
 */
export interface SimpleActivity {
  id: string                   // 活动ID
  title: string                // 活动标题
  time: string                 // 活动时间
  location: string             // 活动地点
  image: string                // 活动封面图片URL
  status: string               // 活动状态
}

/**
 * 活动状态枚举
 */
export enum ActivityStatus {
  ONGOING = 'ongoing',        // 火热报名中
  FULL = 'full',             // 报名已满
  ENDED = 'ended',           // 已结束
  CANCELLED = 'cancelled'    // 已取消
}

/**
 * 预约记录状态枚举
 */
export enum ReservationStatus {
  RESERVED = 'reserved',     // 已预约
  COMPLETED = 'completed',   // 已参加
  CANCELLED = 'cancelled',   // 已取消
  EXPIRED = 'expired'        // 已过期
}

/**
 * 活动分类枚举
 */
export enum ActivityCategory {
  TECH = 'tech',            // 技术分享
  CULTURE = 'culture',      // 文化活动
  SPORTS = 'sports',        // 体育运动
  ACADEMIC = 'academic',    // 学术讲座
  SOCIAL = 'social',        // 社交活动
  CAREER = 'career'         // 就业招聘
}

/**
 * 活动信息接口
 */
export interface Activity {
  id: string                    // 活动ID
  title: string                 // 活动标题
  description: string           // 活动描述
  category: ActivityCategory    // 活动分类
  startTime: Date              // 开始时间
  endTime: Date                // 结束时间
  location: string             // 活动地点
  organizer: string            // 主办方
  maxParticipants: number      // 最大参与人数
  currentParticipants: number  // 当前参与人数
  imageUrl: string             // 活动封面图片
  status: ActivityStatus       // 活动状态
  tags: string[]               // 活动标签
  requirements: string[]       // 参与要求
  agenda: ActivityAgenda[]     // 活动流程
  guests: ActivityGuest[]      // 特邀嘉宾
  createdAt: Date             // 创建时间
  updatedAt: Date             // 更新时间
}

/**
 * 活动流程接口
 */
export interface ActivityAgenda {
  time: string                 // 时间段
  title: string                // 流程标题
  description: string          // 流程描述
}

/**
 * 特邀嘉宾接口
 */
export interface ActivityGuest {
  id: string                   // 嘉宾ID
  name: string                 // 姓名
  title: string                // 职位/头衔
  avatar: string               // 头像URL
  introduction: string         // 简介
}

/**
 * 用户信息接口
 */
export interface User {
  id: string                   // 用户ID
  studentId: string            // 学号
  name: string                 // 姓名
  nickname: string             // 昵称
  avatar: string               // 头像URL
  phone: string                // 手机号
  email: string                // 邮箱
  college: string              // 学院
  major: string                // 专业
  grade: string                // 年级
  points: number               // 积分
  joinedActivitiesCount: number // 参与活动数量
  createdAt: Date             // 注册时间
}

/**
 * 预约记录接口
 */
export interface Reservation {
  id: string                   // 预约ID
  userId: string               // 用户ID
  activityId: string           // 活动ID
  activity: Activity           // 活动信息
  status: ReservationStatus    // 预约状态
  reservedAt: Date            // 预约时间
  checkedInAt?: Date          // 签到时间
  cancelledAt?: Date          // 取消时间
  qrCode?: string             // 签到二维码
  rating?: number             // 评分(1-5)
  comment?: string            // 评价内容
}

/**
 * 快捷入口配置接口
 */
export interface QuickEntry {
  id: string                   // 入口ID
  title: string                // 标题
  icon: string                 // 图标
  color: string                // 背景色
  action: string               // 点击行为
  enabled: boolean             // 是否启用
}

/**
 * 通知消息接口
 */
export interface Notification {
  id: string                   // 消息ID
  title: string                // 消息标题
  content: string              // 消息内容
  type: 'info' | 'warning' | 'success' | 'error' // 消息类型
  read: boolean                // 是否已读
  createdAt: Date             // 创建时间
  actionUrl?: string          // 点击跳转链接
}

/**
 * 应用设置接口
 */
export interface AppSettings {
  userId: string               // 用户ID
  enableNotifications: boolean // 启用通知
  enableActivityReminder: boolean // 启用活动提醒
  theme: 'light' | 'dark' | 'auto' // 主题设置
  language: 'zh-CN' | 'en-US'  // 语言设置
  doNotDisturbStart?: string   // 免打扰开始时间
  doNotDisturbEnd?: string     // 免打扰结束时间
} 