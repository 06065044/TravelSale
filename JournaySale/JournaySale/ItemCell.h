//
//  ItemCell.h
//  JournaySale
//
//  Created by 马伟恒 on 16/1/21.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"
//点击购买的时候
typedef void(^clickToBuy)(void);
@interface ItemCell : UITableViewCell
{
    clickToBuy selfBlock;
}
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemContent;
@property (weak, nonatomic) IBOutlet UILabel *distanceTIme;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *itemLeft;
- (IBAction)buyItem:(id)sender;


-(void)configureWithItemModel:(ItemModel *)model andBlock:(clickToBuy)clickToBuy;
@end
