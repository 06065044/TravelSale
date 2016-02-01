//
//  itemBuyedOpened.h
//  JournaySale
//
//  Created by 马伟恒 on 16/1/27.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^historyClick)(void);
@interface itemBuyedOpened : UITableViewCell
{
    historyClick _historyClick;
}

-(instancetype)initWithStyle:(  UITableViewCellStyle)style reuseIdentifier:( NSString * )reuseIdentifier andHistory:(  historyClick)clickB;
@end
