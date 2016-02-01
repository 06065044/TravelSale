//
//  LMMineViewController.m
//  JournaySale
//
//  Created by 马伟恒 on 16/1/14.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import "LMMineViewController.h"
#import "ItemCell.h"
#import "ItemListCell.h"
#import "itemBuyedOpened.h"
#import "LMMineDetialViewController.h"
#import "LMItemDetailVC.h"

@interface LMMineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_itemList;
    NSArray *_itemSource;
    NSInteger indexSelect;
}
@end
static NSInteger const ToolBarHeight = 50;
@implementation LMMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.backgroundColor = [UIColor clearColor];
    self.labTitle.text=@"已购项目";
    _itemList = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), screenWidth, screenHeight-CGRectGetMaxY(self.navView.frame)-ToolBarHeight) style:UITableViewStylePlain];
    _itemList.delegate = self;
    _itemList.dataSource = self;
    _itemList.rowHeight=120;
     [self.view addSubview:_itemList];
    _itemList.separatorStyle = UITableViewCellSeparatorStyleNone;
     _itemList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    NSLog(@"%@",self.view.subviews);
    //创建底部切换按钮
    for (int i=0; i<2; ++i) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, screenHeight-50, screenWidth/2.0, 50);
        [button setTag:1000+i];
         if (i == 1) {
            button.frame = CGRectOffset(button.frame, screenWidth/2.0, 0);
        }
        if (i==0) {
            [button setTitle:@"未开奖" forState:UIControlStateNormal];
            UIView *midLine = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame), CGRectGetMinY(button.frame), 1, CGRectGetHeight(button.frame))];
            midLine.backgroundColor = [UIColor lightGrayColor];
            [self.view addSubview:midLine];
          
        }
        else{
            [button setTitle:@"已开奖" forState:UIControlStateNormal];
        }
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(changeData:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    UIButton *buton = (UIButton *)[self.view viewWithTag:1000];
      [self changeData:buton];
}
-(void)changeData:(UIButton *)button{
    indexSelect = button.tag;
    UIButton *otherButton ;
    if (indexSelect==1000) {
//        self.labTitle.text = @""
        otherButton = (UIButton *)[self.view viewWithTag:1001];
    }
    else{
        otherButton = (UIButton *)[self.view viewWithTag:1000];
    }
    [otherButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_itemList reloadData];
}
#pragma mark=table代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
    return  _itemSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Reuser=@"resuer";
    static NSString *reuser2 = @"reuser2";
    if (indexSelect ==1000) {
        ItemListCell *Cell=(ItemListCell *)[tableView dequeueReusableCellWithIdentifier:Reuser];
        if (!Cell) {
            Cell = [[ItemListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Reuser andBouns:^{
                //点击进入开奖
            } andHistory:^{
                //进入历史
            }];
        }
        return Cell;
    }
    else{
        itemBuyedOpened *openCell = [tableView dequeueReusableCellWithIdentifier:reuser2];
        if (!openCell) {
            openCell = [[itemBuyedOpened alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuser2 andHistory:^{
                //点击进入历史明细
            }];
        }
    
        return openCell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexSelect == 1000) {
        LMItemDetailVC *detial = [[LMItemDetailVC alloc]init];
        [self.navigationController pushViewController:detial animated:YES];
    }
    else{
    
    LMMineDetialViewController *Detial = [[LMMineDetialViewController alloc]init];
    [self.navigationController pushViewController:Detial animated:YES];

    }
}
#pragma mark -other
-(void)popBack{
    [self dismissViewControllerAnimated:YES completion:nil];
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
