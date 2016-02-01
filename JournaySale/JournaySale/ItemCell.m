//
//  ItemCell.m
//  JournaySale
//
//  Created by 马伟恒 on 16/1/21.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import "ItemCell.h"
#import "UIImageView+WebCache.h"
@implementation ItemCell

- (void)awakeFromNib {
    // Initialization code
    CGRect frameOri=self.frame;
    [self setFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(frameOri))];
    self.itemImage.image=[UIImage imageNamed:@"night.jpg"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configureWithItemModel:(ItemModel *)model andBlock:(clickToBuy)clickToBuy{
//    [self.itemImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
//    self.summary.text = model.imageTitle;
//    self.itemTitle.text = model.itemTitle;
//    self.itemContent.text = model.itemDesc;
//    self.price.text = model.itemPrice;
//    self.distanceTIme.text = model.itemDistanceTime;
//    self.itemLeft.text = model.itemLeft;
    selfBlock = [clickToBuy copy];
}

- (IBAction)buyItem:(id)sender {
    if (selfBlock) {
        selfBlock();
    }
    
}
@end
