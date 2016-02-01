//
//  Util.h
//  Sales
//
//  Created by 李付 on 14/11/26.
//  Copyright (c) 2014年 com.sales. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>
#import "MBProgressHUD.h"
struct LatLng{
    CGFloat latitude;
    CGFloat longitude;
    
};
typedef enum : NSUInteger {
    NET_STATUS_NOSERVICE,
    NET_STATUS_2G,
    NET_STATUS_3G,
    NET_STATUS_4G,
    NET_STATUS_LTE,
    NET_STATUS_WIFI
} NET_STATUS;
typedef struct LatLng LatLng ;
@interface Util : NSObject
/**
 *  将秒数转化为小时和分钟数
 *
 *  @param spaceTime 间隔的秒数
 *
 *  @return 数组，分别是时分秒
 */
+(NSString *)changeToHourByTimeInterval:(NSTimeInterval)spaceTime;
/**
 *  获取当前的时间戳
 *
 *  @return 返回字符串型结果
 */
+(NSString *)currentStamp;
//判断汉字有效性
+(BOOL)isUserName:(NSString *)str;
//图片压缩
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
//用于asi的参数拼接
 +(NSString *)basedString:(NSString *)baseSting withDic:(NSDictionary *)dic;
/**
 *  加载显示mb，但是不会消失，除非调用hide方法
 *
 *  @param mainTitle   主标题
 *  @param detailTitle 详细信息
 */
+(void)showMBLoading:(NSString *)mainTitle detailText:(NSString *)detailTitle;
//网络加载框消失
+(void)hideMBLoading;
+(void)showThreeSecond:(NSString *)detial;
/**
 *显示一秒后消失,不显示标题的时候，将详细信息赋值给detailtext
 */

+(void)showMBProgressHUDLabel:(NSString *)labelText detailLabelText:(NSString *)detailsLabelText;
//验证邮箱
+ (BOOL) validateEmail:(NSString *)email;
//验证手机号
+ (BOOL) validateMobile:(NSString *)mobile;
//验证密码
+(BOOL)validPassWord:(NSString *)password;
//获取设备
+ (NSString *)getCurrentDeviceModel:(UIViewController *)controller;

+(NET_STATUS)getCurrentNetWork;
/**
 *  判断网络连接
 *
 *  @return
 */
+(BOOL) connectedToNetwork;
/**
 *  根据给定的颜色填充获取纯色图片
 *
 *  @param color 颜色标书
 *
 *  @return 返回图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 *  改变图片的颜色
 *
 *  @param image 原始图片
 *
 *  @return 返回改变之后的图片
 */

+ (UIImage*) imageBlackToTransparent:(UIImage*) image;

/**
 *  给传入的view添加动画
 */
//+(BOOL)login;
////替换日期为标准的和服务器对应的8位数字，不够填0
//+(NSString *)changeForm:(NSString *)origin;
///**
// *  获取坐标之间的转化
// *
// *  @param start 起点坐标
// *  @param end   做点坐标
// *
// *  @return 返回double型
// */
//+(double)getDistance:(LatLng)start :(LatLng)end;
/**
 *  获取当前的网络状态
 *
 *  @return 返回网络状态的标记字符串
 */
@end
