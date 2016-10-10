//
//  AgainTooicViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/14.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "AgainTooicViewController.h"

@interface AgainTooicViewController ()
@property (weak, nonatomic) IBOutlet UITextView *commentTextFeild;

@end

@implementation AgainTooicViewController

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
    
    _commentTextFeild.text = [NSString stringWithFormat:@"@@%@:", _name];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(UITextView *)textField
{
    if (textField.text == self.commentTextFeild.text) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
}
- (void)addCircle:(UIButton *)btn
{
    NSLog(@"----------------");
    if (_isOther) {
        [self comment];
        return;
    }
    [self loadNetData];
    
}
#pragma mark------- 加载网络
- (void)loadNetData
{
    NSString *path = @"/app.php/Circles/r_comm_add";
    NSDictionary *params = @{
                             
                             
                             @"uid":kUserId,
                             @"co_id":self.coId,
                             @"title":self.commentTextFeild.text,
                              @"comm_id":_cooId
                             };
    [MCNetTool postWithUrl:path params:params hud:YES
                   success:^(NSDictionary *requestDic, NSString *msg)
     {
         [self showToastWithMessage:msg];
         [self.navigationController popViewControllerAnimated:YES];
         
     } fail:^(NSString *error) {
         
         
         
     }];
    
}

- (void)comment
{
    NSString *path = @"/app.php/Circles/r_comm_add";
    NSDictionary *params = @{
                             
                             
                             @"uid":kUserId,
                             @"co_id":_cid,
                             @"title":self.commentTextFeild.text,
                             @"comm_id":_comm_id
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
