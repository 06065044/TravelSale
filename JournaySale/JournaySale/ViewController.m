//
//  ViewController.m
//  JournaySale
//
//  Created by 马伟恒 on 16/1/12.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import "ViewController.h"

 @interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _navView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 64)];
    _navView.backgroundColor=TOPCOLOR;
    [self.view addSubview:_navView];
    self.view.backgroundColor=RGBA(230, 225, 220);
    
    _leftBack=[UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBack setTitle:@"返回" forState:UIControlStateNormal];
    [_leftBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_leftBack];
    [_leftBack setFrame:CGRectMake(20, 25, 40, 30)];
    [_leftBack addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
    _labTitle=[[UILabel alloc]initWithFrame:CGRectMake((screenWidth-100)/2, 25, 100, 30)];
    _labTitle.textColor=[UIColor whiteColor];
    [self.view addSubview:_labTitle];
    
    
}
-(void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
