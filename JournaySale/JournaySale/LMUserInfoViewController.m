//
//  LMUserInfoViewController.m
//  JournaySale
//
//  Created by 马伟恒 on 16/1/14.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import "LMUserInfoViewController.h"
#import "UserInfoCell.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "LMBuyBonusViewController.h"
#import "LMChangePWDViewController.h"

@interface LMUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@end
static NSArray *titleArray;
@implementation LMUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBA(250, 244, 240);
    self.leftBack.hidden = YES;
    self.labTitle.text=@"我的";
    titleArray  = @[@[@"我的金库",@"中奖码"],@[@"修改密码",@"个人信息"]];
    //上面的view
    UIView *upView= [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), screenWidth, 100)];
    [self.view addSubview:upView];
    upView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *headIgv = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 80)];
    headIgv.image = [UIImage imageNamed:@"night.jpg"];
    [upView addSubview:headIgv];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headIgv.frame)+10, CGRectGetMidY(headIgv.frame)-20, 100, 20)];
    name.text = @"kitty";
     name.textColor = [UIColor blackColor];
    [upView addSubview:name];
    
    UILabel *birthdayLabel =  [[UILabel alloc]initWithFrame:CGRectOffset(name.frame, 0, 25)];
    birthdayLabel.text = @"20151129";
    [upView addSubview:birthdayLabel];
    birthdayLabel.textColor = name.textColor;
    static NSInteger cellHeight = 44;
    
    UITableView *_useTable = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(upView.frame)+10, screenWidth, 44*4.5) style:UITableViewStylePlain];
    _useTable.delegate = self;
    _useTable.dataSource = self;
    _useTable.rowHeight = cellHeight;
    [self.view addSubview:_useTable];
    
    UIButton *logOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logOutButton.frame = CGRectMake(screenWidth/2.0-80, CGRectGetMaxY(_useTable.frame)+10, 160, 30);
    [logOutButton setTitle:@"安全退出" forState:UIControlStateNormal];
    [logOutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    logOutButton.backgroundColor = TOPCOLOR;
    
    [self.view addSubview:logOutButton];
}
//退出
-(void)logout{
    LoginViewController *login = [[LoginViewController alloc]init];
    [[UIApplication sharedApplication]keyWindow].rootViewController = login;
    

}
#pragma mark --table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse = @"reuse";
    UserInfoCell *cell = (UserInfoCell *)[tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UserInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse image:[UIImage imageNamed:@"商机"] title:titleArray[indexPath.section][indexPath.row] andView:nil];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //金库充值
            LMBuyBonusViewController *buyed= [[LMBuyBonusViewController alloc]init];
            buyed.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:buyed animated:YES];
        }
        if (indexPath.row == 1) {
            //中奖码
            
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            LMChangePWDViewController *change = [[LMChangePWDViewController alloc]init];
            change.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:change animated:YES];
        }
        if (indexPath.row==1) {
            //个人信息
        }
    }

}
#pragma mark -other
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
