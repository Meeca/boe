//
//  ViewAllContentViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/14.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "ViewAllContentViewController.h"
#import "UILabel+TopLeftLabelView.h"

@interface ViewAllContentViewController ()

@end

@implementation ViewAllContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   self.navigationItem.title = @"评论";
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, 50, 50);
    [left setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    [left setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(manage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    
    _contentLabel.backgroundColor=[UIColor whiteColor];
//    _contentLabel.numberOfLines=0;
    
    _contentLabel.text = _content;

   _contentLabel.editable = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}

- (void)manage
{

    NSLog(@"你点击了全文");
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
