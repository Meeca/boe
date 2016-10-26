//
//  PhotoUpLoadAgreementViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "PhotoUpLoadAgreementViewController.h"
#import "UserCertificationViewController.h"

@interface PhotoUpLoadAgreementViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PhotoUpLoadAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"IGallery销售平台服务协议";
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    

    self.webView.backgroundColor = [UIColor colorWithRed:236.0/255 green:236.0/255 blue:236.0/255 alpha:1];
//    NSString *path = [[NSBundle mainBundle]pathForResource:@"xieyi" ofType:@"html"];
//    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,@"app.php/User/pay_agreement"]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}


- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:YES];
    //1.设置self.tabBarController.tabBar.hidden=YES;
    
    self.tabBarController.tabBar.hidden=YES;
    
    //2.如果在push跳转时需要隐藏tabBar，设置self.hidesBottomBarWhenPushed=YES;
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)agreeClickBtn:(id)sender
{
    
    NSLog(@"_______同意");
    UserCertificationViewController *userVC = [[UIStoryboard storyboardWithName:@"UserCertification" bundle:nil] instantiateViewControllerWithIdentifier:@"UserCertificationViewController"];
    userVC.authonID = _aID;
    userVC.authonNew = _authon;
    [self.navigationController pushViewController:userVC animated:YES];
}

@end
