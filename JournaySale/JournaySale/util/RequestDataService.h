//
//  RequestDataService.h
//  Sales
//
//  Created by 李付 on 14/11/25.
//  Copyright (c) 2014年 com.sales. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "AFNetworking.h"
typedef void(^CompletionLoadHandle)(id result);
typedef void (^errorBlock)(NSError *);
@interface RequestDataService : NSObject

//网络请求
+ (AFHTTPRequestOperation *)requestWithURL:(NSString *)urlstring
                                    params:(NSMutableDictionary *)params
                                httpMethod:(NSString *)httpMethod
                                     block:(CompletionLoadHandle)block
                                errorBlock:(errorBlock)erro;

+(void)blockPostPath:(NSString *)path
           parameters:(NSDictionary *)parameters
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;



@end
