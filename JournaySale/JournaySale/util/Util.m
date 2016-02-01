//
//  Util.m
//  Sales
//
//  Created by 李付 on 14/11/26.
//  Copyright (c) 2014年 com.sales. All rights reserved.
//

#import "Util.h"
#import <sys/sysctl.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "Header.h"
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import <arpa/inet.h>
//#import "ASIHTTPRequest.h"
#import "Reachability.h"
#import "NSString+MD5Addition.h"
 #define _USE_MATH_DEFINES   //　看math.h中的定义
@implementation Util
+(NSString *)changeToHourByTimeInterval:(NSTimeInterval)spaceTime{
    if (spaceTime<0) {
        return [NSString stringWithFormat:@"已经开奖"];
    }
    int h=spaceTime/3600;
    int m=(spaceTime-h*3600)/60;
    int s=spaceTime-h*3600-m*60;
    NSString *timer=[NSString stringWithFormat:@"%d小时%d分%d秒",h,m,s];
    return  timer;
}
+(NSString *)currentStamp{
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter2 setTimeStyle:NSDateFormatterShortStyle];
    //[dateFormatter setDateFormat:@"hh:mm:ss"]
    [dateFormatter2 setDateFormat:@"SSS"];
    NSString *stamp = [dateFormatter2 stringFromDate:[NSDate date]];
    return stamp;
}
+(NSString *)basedString:(NSString *)baseSting withDic:(NSDictionary *)dic
{
    NSInteger AllCount=[dic allKeys].count;
    NSString *final=[NSString stringWithString:baseSting];
    for (int i=0; i<AllCount; i++) {
        NSString *biaoji=@"?";
        if (i>0) {
            biaoji=@"&";
        }
        NSString *key=[dic allKeys][i];
        NSString *value=[dic objectForKey:key];
        final=[final stringByAppendingFormat:@"%@%@=%@",biaoji,key,value];
    }
    return final;
}
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

//开启加载框
+(void)showMBLoading:(NSString *)mainTitle detailText:(NSString *)detailTitle{
    //加载框
    
    UIWindow *app=[[UIApplication sharedApplication] keyWindow];
    if ([app viewWithTag:123456]) {
        return;
    }
    MBProgressHUD *bd=[[MBProgressHUD alloc]initWithView:app];
    if (![app viewWithTag:123456]) {
        [app addSubview:bd];
        bd.tag=123456;
        bd.dimBackground=YES;
        bd.detailsLabelText=detailTitle;
        [bd show:YES];
    }
    
   
}
//隐藏加载框
+(void)hideMBLoading{
    //去掉加载框
    UIWindow *app=[[UIApplication sharedApplication] keyWindow];
    for (UIView *sub in app.subviews) {
        if (sub.tag==123456) {
            [sub removeFromSuperview];
        }
        if ([sub isKindOfClass:[MBProgressHUD class]]) {
            [sub removeFromSuperview];
        }
        
    }
}
//判断有效性
+(BOOL)isUserName:(NSString *)str
{
    str=[str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"(" withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@")" withString:@""];
    NSString *      regex = @"^[\u4e00-\u9fa5_a-zA-Z0-9]+$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:str];
}

//显示2秒后消失
+(void)showThreeSecond:(NSString *)detial{
    //    UIWindow *app=[[UIApplication sharedApplication].windows lastObject];
    //    MBProgressHUD *bd=[[MBProgressHUD alloc]initWithView:app];
    //    [app addSubview:bd];
    //    bd.tag=123456;
    //    bd.dimBackground=YES;
    //    bd.detailsLabelText=detial;
    //    [bd show:YES];
    
    
    UIWindow *app=[[UIApplication sharedApplication] keyWindow];
    MBProgressHUD*HUD = [[MBProgressHUD alloc] initWithView:app];
    [app addSubview:HUD];
    HUD.detailsLabelText =detial;
    HUD.dimBackground=YES;
    [HUD setMinShowTime:5.0];
    [HUD show:YES];
    [HUD showAnimated:YES whileExecutingBlock:^{
        [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:5]];
        // sleep(2.0);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
    
}
+(void)showMBProgressHUDLabel:(NSString *)labelText detailLabelText:(NSString *)detailsLabelText{
    
    UIWindow *app=[[UIApplication sharedApplication] keyWindow];
    MBProgressHUD*HUD = [[MBProgressHUD alloc] initWithView:app];
    [app addSubview:HUD];
    HUD.labelText = labelText;
    HUD.detailsLabelText =detailsLabelText;
    HUD.mode = MBProgressHUDModeText;
    [HUD setMinShowTime:2.0];
    [HUD showAnimated:YES whileExecutingBlock:^{
        [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:2]];
        // sleep(2.0);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}
//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//密码6-20位
+(BOOL)validPassWord:(NSString *)password{
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,20}";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:password];
    return isMatch;
}

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
//    if (mobile.length!=11) {
//        return NO;
//    }
    NSString *phoneRegex = @"^((17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (NSString *)getCurrentDeviceModel:(UIViewController *)controller
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}
+(NET_STATUS)getCurrentNetWork{
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetworkItemView=nil;
    NET_STATUS result;
    for (id subview in subviews) {
        if ([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView=subview;
            break;
        }
    }
    switch ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue]) {
        case 0:
            result=NET_STATUS_NOSERVICE;
            break;
        case 1:
            result=NET_STATUS_2G;
            break;
        case 2:
            result=NET_STATUS_3G;
            break;
        case 3:
            result=NET_STATUS_4G;
            break;
        case 4:
            result=NET_STATUS_LTE;
            break;
        case 5:
            result=NET_STATUS_WIFI;
            break;
        default:
            break;
    }
    return result;
}
+(BOOL) connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}
#pragma mark --change color
void ProviderReleaseData (void *info, const void *data, size_t size)
{
    free((void*)data);
}

+ (UIImage*) imageBlackToTransparent:(UIImage*) image
{
    // 分配内存
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
    {
        if ((*pCurPtr & 0xFFFFFF00) == 0xffffff00)    // 将白色变成透明
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
        else
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = 73; //0~255
            ptr[2] = 66;
            ptr[1] = 61;
            
        }
        
    }
    
    // 将内存转成image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    // free(rgbImageBuf) 创建dataProvider时已提供释放函数，这里不用free
    
    return resultUIImage;
}
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
