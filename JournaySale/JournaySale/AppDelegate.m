//
//  AppDelegate.m
//  JournaySale
//
//  Created by 马伟恒 on 16/1/12.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "LMMineViewController.h"
//sharesdk -
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//qq
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信
#import "WXApi.h"
//新浪微博
#import "WeiboSDK.h"
@interface AppDelegate ()<UITabBarControllerDelegate>


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
     
    self.window.rootViewController=[[LoginViewController alloc]init];
    
    [self.window makeKeyAndVisible];
    //注册sharesdk
    [ShareSDK registerApp:ShareSdkKey
          activePlatforms:@[
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeSinaWeibo),
//                            @(SSDKPlatformTypeTencentWeibo),
                            @(SSDKPlatformTypeQQ),
                           ]
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         default:
                             break;
                     }
                     
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                              redirectUri:@"http://www.sharesdk.cn"
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeTencentWeibo:
                      //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
                      [appInfo SSDKSetupTencentWeiboByAppKey:@"801307650"
                                                   appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                                 redirectUri:@"http://www.sharesdk.cn"];
                      break;
                 case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                            appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                      break;
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:@"100371282"
                                           appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                         authType:SSDKAuthTypeBoth];
                      break;
     
                  default:
                      break;
              }
              
          }];
    return YES;
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    UIViewController *selfCon = ((UINavigationController *)viewController).viewControllers[0];
    if ([selfCon isKindOfClass:[LMMineViewController class]]) {
        LMMineViewController *mine=[[LMMineViewController alloc]init];
        UINavigationController *nav2=[[UINavigationController alloc]initWithRootViewController:mine];
        nav2.navigationBarHidden=YES;
        [selfCon presentViewController:nav2 animated:YES completion:nil];
        return NO;
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
