//
//  UserInfoCell.m
//  JournaySale
//
//  Created by 马伟恒 on 16/1/30.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import "UserInfoCell.h"

@implementation UserInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier image:(UIImage *)image title:(NSString *)cellTitle andView:(UIView *)view{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *igv=[[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 30, 30)];
        igv.image = image;
        [self.contentView addSubview:igv];
        
        //titile
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(igv.frame)+10, CGRectGetMinY(igv.frame), 100, CGRectGetHeight(igv.frame))];
        title.text = cellTitle;
        [self.contentView addSubview:title];
    //view
        if (view) {
            [self.contentView addSubview:view];
        }
        
    }
    return self;
}
@end
