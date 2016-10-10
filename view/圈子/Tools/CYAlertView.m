//
//  CYAlertView.m
//  CYAlertView
//
//  Created by A_Dirt on 16/5/5.
//  Copyright © 2016年 A_Dirt. All rights reserved.
//

#import "CYAlertView.h"
@interface CYAlertView ()<UITextFieldDelegate>


@end

@implementation CYAlertView
{
    __weak IBOutlet UIView *alertView;
    __weak IBOutlet UILabel *titleLab;
    __weak IBOutlet UILabel *contenLab;
    __weak IBOutlet UIButton *cancelBtn;
    __weak IBOutlet UIButton *determineBtn;

    __weak IBOutlet UITextField *passWordTextField;
    __weak IBOutlet UITextField *searchCircle;
}

- (void)awakeFromNib {
    
    alertView.layer.cornerRadius = 5;
    alertView.layer.masksToBounds = YES;
    self.pass = passWordTextField.text;
    [passWordTextField resignFirstResponder];
    [self changeKeyBoard];
}


- (void)changeKeyBoard
{
    //设置键盘的return按键
    searchCircle.returnKeyType = UIReturnKeyDone;
    searchCircle.delegate = self;
    
}


- (void)drawRect:(CGRect)rect {
    if (self.title.length > 0) {
        titleLab.text = self.title;
    }
    if (self.content.length >0) {
        contenLab.text = self.content;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"点击了确定");
    [self endEditing:YES];
    return YES;
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];

    [window addSubview:self];
    
    self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.center = window.center;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reKeyBoard)];
    [self addGestureRecognizer:tap];
  
    
    
}

- (void)reKeyBoard
{
[passWordTextField resignFirstResponder];

}

//- (void)endEditing
//{
//    [self.window endEditing:YES];
//}
- (IBAction)buttonClick:(UIButton *)sender {

    if ([sender.titleLabel.text isEqualToString:@"确定"]){
        if (self.delegate) {
            [self.delegate alertView:self clickedButtonAtIndex:1 password:passWordTextField.text];
        }
    }
    
    [self removeFromSuperview];
}
- (IBAction)click:(UIButton *)sender
{
   
}


@end
