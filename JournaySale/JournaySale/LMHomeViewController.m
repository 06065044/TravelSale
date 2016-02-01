//
//  LMHomeViewController.m
//  JournaySale
//
//  Created by 马伟恒 on 16/1/14.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import "LMHomeViewController.h"
#import "ItemCell.h"
#import "ItemModel.h"
#import "NSObject+YYModel.h"
#import "LMItemDetailVC.h"

@interface LMHomeViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_source;//table数据源
    UISearchBar *itemSearch;//搜索框
    UITableView *_tableList;//数据列表
    BOOL timeAsecnding;
    BOOL priceAcending;
}
@end

@implementation LMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加搜索框
    [self addSearchBar];
    //添加列表
    [self addTable];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *ipport          = IPPORT;
    NSString *url=[NSString stringWithFormat:@"http://%@",ipport];
    //TODO: 接入接口处理数据
   // url=@"http://192.168.1.131:8080/tourismcf/api/v1/items/buyed/notopen";
    url=@"http://192.168.1.131:8080/tourismcf/api/v1/items/open";
    //NSDictionary *dic=@{@"memberId":@"5"};
    
//    [RequestDataService requestWithURL:url params:nil httpMethod:@"GET" block:^(id result) {
//        NSLog(@"%@",result);
//    } errorBlock:^(NSError *error) {
//        
//    }];
//
    
}
-(void)addSearchBar{
    itemSearch=[[UISearchBar alloc]initWithFrame:CGRectMake(20, 25, screenWidth-40, 30)];
    itemSearch.delegate       = self;
    
    [self.view addSubview:itemSearch];
    
    itemSearch.backgroundImage=[Util imageWithColor:TOPCOLOR];
    
    
}
static NSString *itemReuser=@"itemReuse";
-(void)addTable{
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), screenWidth, 30)];
    UIBarButtonItem *timeItem=[[UIBarButtonItem alloc]initWithTitle:@"时间" style:UIBarButtonItemStylePlain target:self action:@selector(reloadByTime)];
    UIBarButtonItem *priceItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"user"] style:UIBarButtonItemStylePlain target:self action:@selector(reloadByPrice)];
    UIBarButtonItem *spaceItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar.items=@[timeItem,priceItem,spaceItem];
    toolBar.barTintColor      = RGBA(233, 228, 233);
    [self.view addSubview:toolBar];
    
    _tableList                = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame)+30, screenWidth, screenHeight-CGRectGetMaxY(toolBar.frame)-CGRectGetHeight(self.tabBarController.tabBar.frame)) style:UITableViewStylePlain];
    _tableList.delegate       = self;
    _tableList.dataSource     = self;
    _tableList.separatorInset = UIEdgeInsetsZero;
    _tableList.rowHeight=150;
    [_tableList registerNib:[UINib nibWithNibName:NSStringFromClass([ItemCell class]) bundle:nil] forCellReuseIdentifier:itemReuser];
    [self.view addSubview:_tableList];
}
#pragma mark--排序方法
-(void)reloadByTime{
    timeAsecnding=!timeAsecnding;
    NSSortDescriptor *timeSort=[[NSSortDescriptor alloc]initWithKey:@"createTime" ascending:timeAsecnding];
    _source=[_source sortedArrayUsingDescriptors:@[timeSort]];
    [_tableList reloadData];
}
-(void)reloadByPrice{
    priceAcending=!priceAcending;
    NSSortDescriptor *priceSort=[[NSSortDescriptor alloc]initWithKey:@"price" ascending:timeAsecnding];
    _source=[_source sortedArrayUsingDescriptors:@[priceSort]];
    [_tableList reloadData];
}
#pragma mark -table 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
    return _source.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemCell *Cell=(ItemCell *)[tableView dequeueReusableCellWithIdentifier:itemReuser forIndexPath:indexPath];
    ItemModel *item= [ItemModel yy_modelWithDictionary:_source[indexPath.row]];
    [Cell configureWithItemModel:item andBlock:^{
        //TODO: 插入详情按钮
        NSLog(@"%ld",indexPath.row);
        
    }];
    return Cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LMItemDetailVC *detial=[[LMItemDetailVC alloc]init];
    detial.hidesBottomBarWhenPushed=YES;
    //TODO: 添加字典
    [self.navigationController pushViewController:detial animated:YES];
}

#pragma mark == other
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
