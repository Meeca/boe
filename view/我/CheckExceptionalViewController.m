//
//  CheckExceptionalViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/14.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "CheckExceptionalViewController.h"
#import "CheckDetailViewController.h"

@interface CheckExceptionalViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *checkMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation CheckExceptionalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self loadCheckUI];
    
}
- (void)loadCheckUI
{

    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_image] placeholderImage:nil];
    _nameLabel.text = [NSString stringWithFormat:@"来自%@",_nike];
    
    _checkMoneyLabel.text = [NSString stringWithFormat:@"%@元",_price];
    
    
    


}

- (IBAction)checkBtnClick:(id)sender
{
    NSLog(@"你点击了打赏记录按钮");
    
    
    CheckDetailViewController *checkDetail = [[UIStoryboard storyboardWithName:@"Check" bundle:nil]instantiateViewControllerWithIdentifier:@"CheckDetailViewController"];
    [self.navigationController pushViewController:checkDetail animated:YES];
}

@end
