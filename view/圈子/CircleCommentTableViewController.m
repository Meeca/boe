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
#import "MCTextView.h"

@interface CircleCommentTableViewController ()<UITextViewDelegate>
//@property (weak, nonatomic) IBOutlet UITextField *commentTextFeild;
@property (weak, nonatomic) IBOutlet MCTextView *textView;

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

    _textView.placeholder = @"你想说些什么呢";
    
}
//- (void)textFieldDidChange:(UITextField *)textField
//{
//    if (textField == self.commentTextFeild) {
//        if (textField.text.length > 20) {
//            textField.text = [textField.text substringToIndex:20];
//        }
//    }
//}

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
                              @"title":self.textView.text,
                             
                             };
    [MCNetTool postWithUrl:path params:params hud:YES
                   success:^(NSDictionary *requestDic, NSString *msg)
    {
                       [self showToastWithMessage:msg];
                       [self.navigationController popViewControllerAnimated:YES];
                       
                   } fail:^(NSString *error) {
                       
                      
                       
                   }];
    
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10.f;
}


- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01f;
}

@end
