//
//  CircleCommentTableViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/30.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "CircleCommentTableViewController.h"
#import "MCHttp.h"
#import "UIViewController+MBShow.h"

@interface CircleCommentTableViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *commentTextFeild;

@end

@implementation CircleCommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.title = @"评论";
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 50, 50);
    [right setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
//    [right setImage:[UIImage imageNamed:@"C-11-3"] forState:UIControlStateNormal];
    [right setTitle:[NSString stringWithFormat:@"发布"] forState:UIControlStateNormal];
    [right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(addCircle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.commentTextFeild) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
}

- (void)addCircle:(UIButton *)btn
{
    NSLog(@"----------------");
    [self loadNetData];

}
#pragma mark------- 加载网络
- (void)loadNetData
{
NSString *path = @"/app.php/Circles/comm_add";
    NSDictionary *params = @{
                             
                             
                             @"uid":kUserId,
                              @"co_id":self.coId,
                              @"title":self.commentTextFeild.text,
                             
                             };
    [MCNetTool postWithUrl:path params:params hud:YES
                   success:^(NSDictionary *requestDic, NSString *msg)
    {
                       [self showToastWithMessage:msg];
                       [self.navigationController popViewControllerAnimated:YES];
                       
                   } fail:^(NSString *error) {
                       
                      
                       
                   }];
    
}

@end
