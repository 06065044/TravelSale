//
//  LMChangePWDViewController.m
//  JournaySale
//
//  Created by 马伟恒 on 16/1/31.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import "LMChangePWDViewController.h"

@interface LMChangePWDViewController ()
{
    UITextField *tf1;
    UITextField *tf2;
}
@end

@implementation LMChangePWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.labTitle.text = @"修改密码";
    UIView *upView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame)+5, screenWidth, 120)];
    upView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:upView];
    
    UILabel *newPWD = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 80, 30)];
    newPWD.text = @"新密码";
    [upView addSubview:newPWD];
    
    UILabel *replyPWD = [[UILabel alloc]initWithFrame:CGRectOffset(newPWD.frame, 0, 40)];
    replyPWD.text = @"重复密码";
    [upView addSubview:replyPWD];
    
    tf1 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newPWD.frame), CGRectGetMinY(newPWD.frame), 180, CGRectGetHeight(newPWD.frame))];
    tf1.borderStyle  = UITextBorderStyleRoundedRect;
    [upView addSubview:tf1];
    
    tf2 = [[UITextField alloc]initWithFrame:CGRectOffset(tf1.frame, 0, 40)];
    tf2.borderStyle = tf1.borderStyle;
    [upView addSubview:tf2];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton setBackgroundColor:TOPCOLOR];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(changePwd) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setFrame:CGRectMake(screenWidth/2.0-80, CGRectGetMaxY(upView.frame)+15, 160, 30)];
    [self.view addSubview:sureButton];
}
-(void)changePwd{
    NSString *ipport = IPPORT;
    NSString *url = [NSString stringWithFormat:@"http://%@",ipport];
    
    


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
