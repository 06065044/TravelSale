//
//  RequestDataService.m
//  Sales
//
//  Created by 李付 on 14/11/25.
//  Copyright (c) 2014年 com.sales. All rights reserved.
//

#import "RequestDataService.h"
#import "Util.h"
#import "Reachability.h"
@implementation RequestDataService
+(AFHTTPRequestOperation *)requestWithURL:(NSString *)urlstring
                                    params:(NSMutableDictionary *)params
                                httpMethod:(NSString *)httpMethod
                                     block:(CompletionLoadHandle)block
                                      errorBlock:(errorBlock)erro  {
    
    if ([[Reachability reachabilityWithHostName:@"www.apple.com"] currentReachabilityStatus]==NotReachable) {
        //没网的时候
        [Util showMBProgressHUDLabel:nil detailLabelText:@"请检查网络"];
        
        return nil;
    }
    if (![Util connectedToNetwork]) {
        //没网的时候
        [Util showMBProgressHUDLabel:nil detailLabelText:@"请检查网络"];
        
        return nil;
    }
    NSLock *lock=[[NSLock alloc]init];
    [lock lock];
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }

    [Util showMBLoading:@"正在请求数据" detailText:@"请稍候..."];
    //1.拼接URL
    
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@",urlstring];
    //3.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setTimeoutInterval:10.f];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    AFHTTPRequestOperation *operation = nil;
    
    if ([httpMethod isEqualToString:@"GET"]) {
        
        //4.发送GET请求
        operation = [manager GET:url
                      parameters:params
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             if (block != nil) {
                                 [Util hideMBLoading];
                                 block(responseObject);
                             }
                         }
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             [Util hideMBLoading];
                             if ([url hasSuffix:@"saveBackStepItem"]) {
                                 [[NSNotificationCenter defaultCenter]postNotificationName:@"showSave" object:nil];
                             }
                             else  if ([url hasSuffix:@"queryBackStepItemValue"]) {
                                 [[NSNotificationCenter defaultCenter]postNotificationName:@"add" object:nil];
                             }
                             
                             [Util showMBProgressHUDLabel:@"请求失败" detailLabelText:@"请检查网络"];
                             NSLog(@"请求网络失败：%@",error);
                             if (erro) {
                                 erro(error);
                             }
                         }];
        
    }else if([httpMethod isEqualToString:@"POST"]){
        //4.发送POST请求
        
        BOOL isFile = NO;
        for (NSString *key in params) {
            id value = params[key];
            //判断请求参数是否是文件数据
            if ([value isKindOfClass:[NSData class]]) {
                isFile = YES;
                break;
            }
        }
        
        if (!isFile) {
            //如果参数中没有文件，使用以下方法发送网络请求
            [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (block != nil) {
                    [Util hideMBLoading];
                    block(responseObject);
                }
                NSLog(@"%@",operation.request.allHTTPHeaderFields);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [Util hideMBLoading];
                if ([url hasSuffix:@"saveBackStepItem"]) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"showSave" object:nil];
                }
                else  if ([url hasSuffix:@"queryBackStepItemValue"]) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"add" object:nil];
                }

                else
                    [Util showMBProgressHUDLabel:@"请求失败" detailLabelText:@"请检查网络"];

                if (erro) {
                    erro(error);
                }

            }];
        } else {
            
            //如果参数中带有文件，使用如下POST方法请求网络
            operation = [manager POST:url
                           parameters:params
            constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                         {
                             for (NSString *key in params) {
                                 id value = params[key];
                                 
                                 //判断请求参数是否是文件数据
                                 if ([value isKindOfClass:[NSData class]]) {
                                     
                                     //将文件数据添加到formData中
                                     [formData appendPartWithFileData:value
                                                                 name:key
                                                             fileName:key
                                                             mimeType:@"multipart/form-data;boundary=*****"];
                                     
                                 }
                             }
                         }
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  if (block != nil) {
                                      [Util hideMBLoading];

                                      block(responseObject);
                                  }
                                  
                                  NSLog(@"response:%@",operation.response.allHeaderFields);
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  [Util hideMBLoading];
                                  
                                  if (erro) {
                                      erro(error);
                                  }
                              }];
        }
    }
    
    //5.设置返回数据的解析方式
    operation.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
        [lock unlock];
    return operation;

}

+(void)blockPostPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    if (!path) {
        path = @"";
    }
    NSArray *arcCookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in arcCookies){
        [cookieStorage setCookie: cookie];
    }
    NSURL *dataUrl = [NSURL URLWithString:path relativeToURL:[NSURL URLWithString:path]];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:dataUrl];//id: NSHTTPCookie
    NSDictionary *sheaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    __strong NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:dataUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.f];
    [request setHTTPMethod:@"Post"];
    [request addValue:@"iOS" forHTTPHeaderField:@"User-Agent"];
    [request setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
    [request setAllHTTPHeaderFields:sheaders];
}


@end
