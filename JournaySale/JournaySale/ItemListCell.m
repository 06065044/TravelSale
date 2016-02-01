//
//  ItemListCell.m
//  JournaySale
//
//  Created by 马伟恒 on 16/1/25.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import "ItemListCell.h"
#import "UIImageView+WebCache.h"
#import "Util.h"
#import "Header.h"
@interface ItemListCell()
@property(strong,nonatomic,nonnull)UIImageView *itemImage;//项目图片
@property(strong,nonatomic,nonnull)UILabel *imageTitle;//图片简要描述
@property(strong,nonnull,nonatomic)UILabel *itemTitle;//项目标题
@property(strong,nonnull,nonatomic)UILabel *itemDesc;//项目描述
@property(strong,nonnull,nonatomic)UILabel *itemDistance;//项目截止时间
@property(strong,nonnull,nonatomic)UIButton *bounsButton;//开奖按钮
@property(strong,nonnull,nonatomic)UIButton *lookHistory;
@end
@implementation ItemListCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andBouns:(boundClick)clickA andHistory:(historyClick)clickB{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
         //项目图片
        _itemImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 100, 100)];
        _itemImage.image = [UIImage imageNamed:@"night.jpg"];
        [self.contentView addSubview:_itemImage];
        
        //透明底层
        UIView *clearSub = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_itemImage.frame)-30, CGRectGetWidth(_itemImage.frame), 30)];
        clearSub.backgroundColor = [UIColor blackColor];
        clearSub.alpha = 0.4;
        //图片标题
        _imageTitle = [[UILabel alloc]initWithFrame:clearSub.bounds];
        _imageTitle.font = [UIFont systemFontOfSize:12];
        _imageTitle.textAlignment = NSTextAlignmentRight;
        [clearSub addSubview:_imageTitle];
        
        [_itemImage addSubview:clearSub];
        
        //项目标题
        
        _itemTitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_itemImage.frame)+10, CGRectGetMinY(_itemImage.frame)-5,screenWidth-CGRectGetMaxX(_itemImage.frame)-20 ,20)];
        _itemTitle.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_itemTitle];
        
        //描述
        _itemDesc = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_itemTitle.frame), CGRectGetMaxY(_itemTitle.frame), CGRectGetWidth(_itemTitle.frame), 40)];
        _itemDesc.numberOfLines = 2;
        _itemDesc. numberOfLines = NSLineBreakByWordWrapping ;
        [self.contentView addSubview:_itemDesc];
        
        //开奖剩余
        UILabel *labelKai = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_itemTitle.frame), CGRectGetMaxY(_itemDesc.frame), 100, 20)];
        labelKai.text = @"开奖剩余";
        labelKai.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:labelKai];
        
        _itemDistance = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labelKai.frame), CGRectGetMinY(labelKai.frame), 120, 20)];
        _itemDistance.font = [UIFont systemFontOfSize:14];
        _itemDistance.text = @"1天2小时30分35秒";
        [self.contentView addSubview:_itemDistance];
        
        
        _bounsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bounsButton.frame = CGRectMake(CGRectGetMinX(labelKai.frame), CGRectGetMaxY(_itemImage.frame)-20, 60, 25);
        [_bounsButton setTitle:@"开奖" forState:UIControlStateNormal];
        [_bounsButton setBackgroundColor:[UIColor lightGrayColor]];
        [_bounsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bounsButton addTarget:self action:@selector(gofoBouns) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_bounsButton];
        
        _lookHistory = [UIButton buttonWithType:UIButtonTypeCustom];
        _lookHistory.frame = CGRectOffset(_bounsButton.frame, 120, 0);
        [_lookHistory addTarget:self action:@selector(toLookHistory) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_lookHistory];
        //下面的分割线
        UIImageView *seperaeteLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 119, screenWidth, 1)];
        seperaeteLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:seperaeteLine];
        _bounsClick = [clickA copy];
        _historyClick = [clickB copy];
     
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateDistanceTime:(NSString *)string{
    _itemDistance.text=string;
}
-(void)confiureText:(ItemModel *)model{
    [_itemImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
    _imageTitle.text = model.imageTitle;
    _itemTitle.text = model.itemTitle;
    _itemDesc.text = model.itemDesc;

}
-(void)gofoBouns{
    if (_bounsClick) {
        _bounsClick();
    }

}
-(void)toLookHistory{
    if (_historyClick) {
        _historyClick();
    }
    
}

-(void)layoutSubviews{
    

}
@end
