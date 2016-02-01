//
//  LoginViewController.m
//  JournaySale
//
//  Created by 马伟恒 on 16/1/14.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import "LoginViewController.h"
#import "LMUserInfoViewController.h"
#import "LMMineViewController.h"
#import "LMHomeViewController.h"
#import "AppDelegate.h"
@interface LoginViewController ()@property (unsafe_unretained, nonatomic) IBOutlet UITextField *userName;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *passWord;
- (IBAction)userLogin:(id)sender;
- (IBAction)userRegister:(id)sender;

@end
@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.leftBack.hidden=YES;
   
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

- (IBAction)userLogin:(id)sender {
    
    [self changeToTab];
    return;
    
    //TODO: 真实的登陆验证
    NSString *ipport=IPPORT;
    NSString *loginUrl=[NSString stringWithFormat:@"http://%@/url",ipport];
  [RequestDataService requestWithURL:loginUrl params:nil httpMethod:@"POST" block:^(id result) {
      if ([result[@"statusCode"] intValue]==200) {
          //成功
          
      }
      
      
  } errorBlock:^(NSError *error) {
      
  }];
 
}
-(void)changeToTab{

    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
     [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
    
    LMUserInfoViewController *user=[[LMUserInfoViewController alloc]init];
    UINavigationController *nav3=[[UINavigationController alloc]initWithRootViewController:user];
    nav3.navigationBarHidden=YES;
    nav3.tabBarItem.title=@"我的";
    [nav3.tabBarItem setSelectedImage:nil];
    nav3.tabBarItem.image=[UIImage imageNamed:@"user"];
    
    LMMineViewController *mine=[[LMMineViewController alloc]init];
    UINavigationController *nav2=[[UINavigationController alloc]initWithRootViewController:mine];
    nav2.navigationBarHidden=YES;
    nav2.tabBarItem.title=@"已购";
    nav2.tabBarItem.image=[UIImage imageNamed:@"商机"];
    
    LMHomeViewController *home=[[LMHomeViewController alloc]init];
    UINavigationController *nav1=[[UINavigationController alloc]initWithRootViewController:home];
    nav1.navigationBarHidden=YES;
    nav1.tabBarItem.title=@"项目";
     nav1.tabBarItem.image=[UIImage imageNamed:@"办公"];
//    UIImage *selecdImage=[Util imageBlackToTransparent:[UIImage imageNamed:@"办公"]];
//   
//    nav1.tabBarItem.selectedImage=selecdImage;
    
    UITabBarController *tabVC = [[UITabBarController alloc]init];
    AppDelegate * apple=[UIApplication sharedApplication].delegate;

    tabVC.delegate = apple;
    tabVC.viewControllers=@[nav1,nav2,nav3];
    [UIApplication sharedApplication].keyWindow.rootViewController=tabVC;
    tabVC.tabBar.barTintColor=RGBA(73, 66, 61);
}

- (IBAction)userRegister:(id)sender {
}
@end
