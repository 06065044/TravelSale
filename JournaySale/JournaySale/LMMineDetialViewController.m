//
//  LMMineDetialViewController.m
//  JournaySale
//
//  Created by 马伟恒 on 16/2/1.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import "LMMineDetialViewController.h"

@interface LMMineDetialViewController ()
{
    //当前的最大值y
    CGFloat maxY;
    //当前选中的button
    UIButton *selectBtn;
    //button下面的红线
    UIView *orangeView;
    //倒计时按钮
    UILabel *countLable;
//    //倒计时
//    CADisplayLink *countTime;
//    //总共倒计时
//    NSTimeInterval timerInterval;
    
}
@end

@implementation LMMineDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加上半部分
    [self loadUp];
    // 添加中间的行程
    [self loadTravel];
    //    //添加倒计时
    [self countTime];
}
-(void)loadUp{
    //添加背景
    self.navView.backgroundColor=[UIColor clearColor];
    UIView *upView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight/3.0)];
    upView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:upView];
    
    UIImageView *itemImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight*0.25)];
    itemImage.image=[UIImage imageNamed:@"night.jpg"];
    [upView addSubview:itemImage];
    [self.view sendSubviewToBack:upView];
    
    //标题
    UILabel *itemTitle=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(itemImage.frame)+5, screenWidth/2.0, 25)];
    itemTitle.text=@"韩国济州岛5日游";
    [upView addSubview:itemTitle];
    //单价
    UILabel *priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(itemTitle.frame)+2, 80, 25)];
    NSString *text=@"单价20金币";
    NSMutableAttributedString *attri=[[NSMutableAttributedString alloc]initWithString:text];
    NSInteger leftIndex=[text rangeOfString:@"价"].location;
    NSInteger rightIndex=[text rangeOfString:@"金"].location;
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, text.length)];
    [attri addAttribute:NSForegroundColorAttributeName value:RGBA(226, 212, 215) range:NSMakeRange(0, text.length)];
    
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(leftIndex+1, rightIndex-leftIndex-1)];
    
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(leftIndex+1, rightIndex-leftIndex-1)];
    priceLabel.attributedText=attri;
    [upView addSubview:priceLabel];
    //份数
    UILabel *leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame)+10, CGRectGetMinY(priceLabel.frame), 100, CGRectGetHeight(priceLabel.frame))];
    NSString *leftText=@"剩余120份数";
    NSMutableAttributedString *leftAtt=[[NSMutableAttributedString alloc]initWithString:leftText];
    NSInteger left1=[leftText rangeOfString:@"余"].location;
    NSInteger right1=[leftText rangeOfString:@"份"].location;
    [leftAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, leftText.length)];
    [leftAtt addAttribute:NSForegroundColorAttributeName value:RGBA(226, 212, 215) range:NSMakeRange(0, leftText.length)];
    [leftAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(left1+1, right1-1-left1)];
    [leftAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(left1+1, right1-1-left1)];
    leftLabel.attributedText=leftAtt;
    [upView addSubview:leftLabel];
    maxY = CGRectGetMaxY(leftLabel.frame);
}
//添加中部的按钮
#pragma mark -- middle
-(void)loadTravel{
    for (int i=0; i<2; ++i) {
        UIButton *buttonTravel=[UIButton buttonWithType:UIButtonTypeCustom];
        buttonTravel.frame=CGRectMake(0+screenWidth*i/2.0, maxY, screenWidth/2.0, 30);
        [buttonTravel setTitle:@"行程安排" forState:UIControlStateNormal];
        buttonTravel.backgroundColor=RGBA(232, 227, 222);
        [buttonTravel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [buttonTravel addTarget:self action:@selector(changeDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonTravel];
        if (i==0) {
            orangeView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(buttonTravel.frame), CGRectGetWidth(buttonTravel.frame), 1)];
            orangeView.backgroundColor=[UIColor orangeColor];
            [self.view addSubview:orangeView];
        }
    }
    UIScrollView *srcoll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(orangeView.frame), screenWidth, screenHeight/2.0+25)];
    srcoll.contentSize=CGSizeMake(screenWidth*2, CGRectGetHeight(srcoll.frame));
    [self.view addSubview:srcoll];
    maxY=CGRectGetMaxY(srcoll.frame);
}
-(void)changeDetail:(UIButton *)btn{
    if (selectBtn) {
        selectBtn.backgroundColor=RGBA(232, 227, 222);
    }
    selectBtn=btn;
    btn.backgroundColor=RGBA(219, 215, 208);
    [UIView animateWithDuration:0.25 animations:^{
        if (CGRectGetMinX(selectBtn.frame)==0) {
            orangeView.frame=CGRectOffset(orangeView.frame, -screenWidth/2.0, 0);
        }
        else{
            orangeView.frame=CGRectOffset(orangeView.frame, screenWidth/2.0, 0);
        }
    }completion:^(BOOL finished) {
        //TODO: 刷新列表
        if (CGRectGetMinX(selectBtn.frame)==0) {
            //显示作伴的行程
        }
        else{
            //显示右边的特色
        }
    }];
    
    
}
#pragma mark -- 底部
-(void)countTime{
    UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(0, maxY, screenWidth, screenHeight-maxY)];
    downView.backgroundColor = TOPCOLOR;
    [self.view addSubview:downView];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:downView.bounds];
    lab.text = @"开奖详情";
    lab.textColor = [UIColor whiteColor];
    [downView addSubview:lab];
    lab.textAlignment = NSTextAlignmentCenter;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
