//
//  ItemModel.h
//  JournaySale
//
//  Created by 马伟恒 on 16/1/21.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject
@property(strong,nonatomic)NSString *imageUrl;
@property(strong,nonatomic)NSString *imageTitle;
@property(strong,nonatomic)NSString *itemTitle;
@property(strong,nonatomic)NSString *itemDesc;
@property(strong,nonatomic)NSString *itemPrice;
@property(strong,nonatomic)NSString *itemDistanceTime;
@property(strong,nonatomic)NSString *itemLeft;

@end
