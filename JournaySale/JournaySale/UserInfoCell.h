//
//  UserInfoCell.h
//  JournaySale
//
//  Created by 马伟恒 on 16/1/30.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoCell : UITableViewCell
//@property(strong,nonatomic)UIImageView *iconImage;
//@property(strong,nonatomic)UILabel *titleShow;
//@property(strong,nonatomic)UIView *addView;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier image:(UIImage *)image
                       title:(NSString *)cellTitle andView:(UIView *)view;
@end
