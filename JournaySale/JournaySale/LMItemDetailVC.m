//
//  LMItemDetailVC.m
//  JournaySale
//
//  Created by 马伟恒 on 16/1/21.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import "LMItemDetailVC.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "LMBuyItemViewController.h"
@interface LMItemDetailVC ()
{
    //当前的最大值y
    CGFloat maxY;
    //当前选中的button
    UIButton *selectBtn;
    //button下面的红线
    UIView *orangeView;
    //倒计时按钮
    UILabel *countLable;
    //倒计时
    CADisplayLink *countTime;
    //总共倒计时
    NSTimeInterval timerInterval;
    
}
@end

@implementation LMItemDetailVC

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
    //添加竖线
    UIImageView *verLine=[[UIImageView alloc]initWithFrame:CGRectMake(screenWidth/2.0+2, CGRectGetMinY(itemTitle.frame), 1, 40)];
    verLine.backgroundColor=RGBA(226, 212, 215);
    [upView addSubview:verLine];
    
    //分享按钮
    UIButton *shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setTitle:@"share" forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(CGRectGetMaxX(verLine.frame)+10, CGRectGetMidY(itemTitle.frame)+2, 60, 30);
     [shareButton addTarget:self action:@selector(shareItem) forControlEvents:UIControlEventTouchUpInside];
    [upView addSubview:shareButton];
    shareButton.backgroundColor=[UIColor lightGrayColor];
    
    //都有谁
    UIButton *showList=[UIButton buttonWithType:UIButtonTypeCustom];
    [showList setTitle:@"都有谁" forState:UIControlStateNormal];
    showList.frame=CGRectOffset(shareButton.frame, 80, 0);
    [upView addSubview:showList];
    [showList addTarget:self action:@selector(buyList) forControlEvents:UIControlEventTouchUpInside];
    [upView addSubview:showList];
    showList.backgroundColor=[UIColor lightGrayColor];
    maxY=CGRectGetMaxY(upView.frame);
    
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
    downView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:downView];
    
    UILabel *bonusTitle=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 100, 20)];
    bonusTitle.text=@"开奖倒计时";
    bonusTitle.font=[UIFont systemFontOfSize:14];
    [downView addSubview:bonusTitle];
    
     countLable=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bonusTitle.frame)-15, CGRectGetMinY(bonusTitle.frame), 150, 20)];
    countLable.font=[UIFont systemFontOfSize:18];
    countLable.textColor=RGBA(223, 212, 220);
    [downView addSubview:countLable];
    
    countTime=[CADisplayLink displayLinkWithTarget:self selector:@selector(countLeftTime)];
    countTime.frameInterval=60;
    [countTime addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *distanceDate=[formatter dateFromString:@"2016-01-22 18:00:00"];
    NSDate *now=[NSDate date];
    timerInterval=[distanceDate timeIntervalSinceDate:now];
    [countLable setText:[Util changeToHourByTimeInterval:timerInterval]];
    
    UIButton *Buyitem=[UIButton buttonWithType:UIButtonTypeCustom];
    Buyitem.frame = CGRectMake(screenWidth-80, 0, 80, CGRectGetHeight(downView.frame));
    Buyitem.backgroundColor=[UIColor orangeColor];
    [Buyitem setTitle:@"购买" forState:UIControlStateNormal];
    [Buyitem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [downView addSubview:Buyitem];
    [Buyitem addTarget:self action:@selector(butItem) forControlEvents:UIControlEventTouchUpInside];
    
    
}
#pragma mark -购买
-(void)butItem{
    LMBuyItemViewController *buyItem = [[LMBuyItemViewController alloc]initWithNibName:NSStringFromClass([LMBuyItemViewController class]) bundle:nil];
    [self.navigationController pushViewController:buyItem animated:YES];

}
-(void)countLeftTime{
    timerInterval--;
    [countLable setText:[Util changeToHourByTimeInterval:timerInterval]];
    
    
}
#pragma mark -分享
-(void)shareItem{
    NSArray* imageArray = @[[UIImage imageNamed:@"night.jpg"]];
//    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
    }
//    NSURL *urlToshare=[NSURL URLWithString:@"http://baidu.com"];
//    NSArray *activityItems=@[title,image,urlToshare];
//    UIActivityViewController *activityVC=[[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
//    //不出现在列中的项目
//    activityVC.excludedActivityTypes=nil;
//    [self presentViewController:activityVC animated:YES completion:nil];

}

#pragma mark - 查看记录
-(void)buyList{
    //TODO: 查看购买历史
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
