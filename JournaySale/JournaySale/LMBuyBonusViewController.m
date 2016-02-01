//
//  LMBuyBonusViewController.m
//  JournaySale
//
//  Created by 马伟恒 on 16/1/31.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import "LMBuyBonusViewController.h"

@interface LMBuyBonusViewController ()
{
    UITextField *money;
    UILabel *selectLabel;
}
@end

@implementation LMBuyBonusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.labTitle.text = @"我的金库";
    self.view.backgroundColor = RGBA(250, 244, 240);
    UIView *upView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), screenWidth, screenHeight*0.2)];
    upView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:upView];
    
    UILabel *left= [[UILabel alloc]initWithFrame:CGRectMake(5, 5, screenWidth-10, 40)];
    left.text = @"可用金额: 120金币";
    [upView addSubview:left];
    
    UILabel *desTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(left.frame)+10, screenWidth, 20)];
    desTitle.text = @"金币充值和使用说明";
    [upView addSubview:desTitle];
    
    //充值优惠
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(upView.frame)+5, screenWidth, screenHeight/2.5)];
    downView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:downView];
    UILabel *labInst = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, screenWidth, 20)];
    labInst.text = @"充值方式:";
    [downView addSubview:labInst];
    
    UIView *horzLine = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(labInst.frame)+5, screenWidth-5, 1)];
    horzLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [downView addSubview:horzLine];
    
    //UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(horzLine.frame), screenWidth, 44*5)];
    NSArray *_moneyArray = @[@"充50\n送5",@"冲100\n送15",@"冲200\n送40",@"冲500\n送80",@"冲1000\n送300"];
    for (int i = 0; i<_moneyArray.count; ++i) {
        
        UILabel *labBuy = [[UILabel alloc]initWithFrame:CGRectMake(20+screenWidth*0.33*(i%3), CGRectGetMaxY(horzLine.frame)+10+80*(i/3), screenWidth*0.25, 60)];
        labBuy.numberOfLines =2;
        labBuy.layer.borderWidth=1.0;
        labBuy.layer.borderColor = [UIColor lightGrayColor].CGColor;
        labBuy.lineBreakMode = NSLineBreakByWordWrapping;
        labBuy.text = _moneyArray[i];
        labBuy.textAlignment = NSTextAlignmentCenter;
        [downView addSubview:labBuy];
        labBuy.userInteractionEnabled = YES;
        UITapGestureRecognizer *chooseMoney = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choseMoney:)];
        chooseMoney.numberOfTapsRequired = 1;
        chooseMoney.numberOfTouchesRequired = 1;
        [labBuy addGestureRecognizer:chooseMoney];
    }
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMinY(horzLine.frame)+180, 100, 30)];
    lab.text = @"其他金额";
    [downView addSubview:lab];
    money = [[UITextField alloc]initWithFrame:CGRectMake(100, CGRectGetMinY(lab.frame), 200, 30)];
    money.keyboardType = UIKeyboardTypeNumberPad;
    money.placeholder = @"请输入要充值的金额";
    money.borderStyle = UITextBorderStyleRoundedRect;
    [downView addSubview:money];

    UIButton *buttonBuy  = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonBuy setFrame:CGRectMake(screenWidth/2.0-80, CGRectGetMaxY(downView.frame)+20, 160, 30)];
    [buttonBuy setTitle:@"充值" forState:UIControlStateNormal];
    [buttonBuy setBackgroundColor:TOPCOLOR];
    [self.view addSubview:buttonBuy];
    
}
-(void)choseMoney:(UIGestureRecognizer *)ges{
    UILabel *lab = (UILabel *)[ges view];
    //TODO: 图片改变
    if (selectLabel) {
        selectLabel.textColor = [UIColor blackColor];
    }
    selectLabel = lab;
    selectLabel.textColor = [UIColor orangeColor];
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
