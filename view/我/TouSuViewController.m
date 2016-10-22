//
//  TouSuViewController.m
//  jingdongfang
//
//  Created by haozhiyu on 2016/10/22.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "TouSuViewController.h"

@interface TouSuViewController ()

@end

@implementation TouSuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"投诉";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"切图 20160719-5"]];
    image.frame = CGRectMake(0, 0, 120, 120);
    image.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:image];
    image.center = self.view.center;
    
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectZero];
    msg.text = @"请拨打客服电话，我们将竭诚为您服务";
    msg.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:msg];
    [msg sizeToFit];
    msg.center = image.center;
    msg.top = image.bottom+40;
    
    UILabel *tel = [[UILabel alloc] initWithFrame:CGRectZero];
    tel.font = [UIFont boldSystemFontOfSize:28];
    tel.textColor = KAPPCOLOR;
    tel.text = @"400-000-000";
    [self.view addSubview:tel];
    [tel sizeToFit];
    tel.center = msg.center;
    tel.top = msg.bottom+20;
    
    image.top = (self.view.height-(tel.bottom-image.top))/5*2;
    msg.top = image.bottom+40;
    tel.top = msg.bottom+20;
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
