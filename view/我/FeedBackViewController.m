//
//  FeedBackViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "FeedBackViewController.h"
#import "UIViewController+MBShow.h"
#import "SettingsViewController.h"

@interface FeedBackViewController ()
@property (weak, nonatomic) IBOutlet UITextField *feedBackTextFeild;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)confirmBtnClick:(id)sender
{
    
    NSLog(@"你点击了确定按钮");
    [self loadFeedBack];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)loadFeedBack
{
    if (self.feedBackTextFeild.text.length == 0) {
        [self showToastWithMessage:@"请输入反馈内容"];
        return;
    }
    NSString *path = @"/app.php/User/feedback";
    NSDictionary *params = @{
                             @"uid":kUserId,
                             @"content":self.feedBackTextFeild.text,
                             
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
     {
         [self showToastWithMessage:msg];
         SettingsViewController *settingVC = [[SettingsViewController alloc] init];
         [self.navigationController pushViewController:settingVC animated:YES];
         BOOL flag = NO;
         
         NSMutableArray *array = [NSMutableArray array];
         for (int i = 0; i < self.navigationController.viewControllers.count - 1; i ++)
         {
             UIViewController *vc = self.navigationController.viewControllers[i];
             if (flag == NO && [vc isKindOfClass:[SettingsViewController class]])
             {
                 flag = YES;
             }
             
             if (flag)
             {
                 [array addObject:vc];
             }
             
         }
         
         NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
         [viewControllers removeObjectsInArray:array];
         
         self.navigationController.viewControllers = viewControllers;
         
         
     }
                      fail:^(NSString *error) {
                          
                      }];
    
}

@end
