//
//  LMBuyItemViewController.m
//  JournaySale
//
//  Created by 马伟恒 on 16/1/22.
//  Copyright © 2016年 马伟恒. All rights reserved.
//

#import "LMBuyItemViewController.h"
static const NSInteger price = 3;
@interface LMBuyItemViewController ()
@property (weak, nonatomic) IBOutlet UILabel *currentCount;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemDetail;
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *moneyLeft;
- (IBAction)clickToBuy:(id)sender;
- (IBAction)clickTodown:(id)sender;
- (IBAction)clickToUp:(UIButton *)sender;

@end

@implementation LMBuyItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.itemPrice.attributedText = [self biggerNumber:self.itemPrice.text];
    
    

}
#pragma mark == 放大数字
-(NSMutableAttributedString *)biggerNumber:(NSString *)text{
    NSString *stringPrice = text;
    NSMutableAttributedString *priceAttri = [[NSMutableAttributedString alloc]initWithString:stringPrice];
    NSInteger leftIndex=[stringPrice rangeOfString:@"价"].location;
    NSInteger rightIndex=[stringPrice rangeOfString:@"金"].location;
    [priceAttri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(leftIndex+1, rightIndex-leftIndex-1)];
    
    [priceAttri addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(leftIndex+1, rightIndex-leftIndex-1)];
    return priceAttri;
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

- (IBAction)clickToBuy:(id)sender {
}

- (IBAction)clickTodown:(id)sender {
    NSInteger count = [self.currentCount.text integerValue];
    [self.currentCount setText:[NSString stringWithFormat:@"%ld",count==0?0:--count]];
    
    NSString *totalPric = [NSString stringWithFormat:@"总价 %ld 金币",price*count];
    self.totalPrice.attributedText = [self biggerNumber:totalPric];
}

- (IBAction)clickToUp:(UIButton *)sender {
    int max=20;
    NSInteger count = [self.currentCount.text integerValue];
    [self.currentCount setText:[NSString stringWithFormat:@"%ld",count==max?max:++count]];
    NSString *totalPric = [NSString stringWithFormat:@"总价 %ld 金币",price*count];
    self.totalPrice.attributedText = [self biggerNumber:totalPric];
}
@end
