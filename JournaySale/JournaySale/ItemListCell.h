//
//  ItemListCell.h
//  JournaySale
//
//  Created by 马伟恒 on 16/1/25.
//  Copyright © 2016年 马伟恒. All rights reserved.
//


typedef void(^boundClick)(void);
typedef void(^historyClick)(void);
#import <UIKit/UIKit.h>
#import "ItemModel.h"
@interface ItemListCell : UITableViewCell
{
    boundClick _bounsClick;
    historyClick _historyClick;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andBouns:(boundClick)clickA andHistory:(historyClick)clickB;
@end
