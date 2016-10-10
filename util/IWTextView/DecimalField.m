//
//  DecimalField.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/6.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "DecimalField.h"

@interface DecimalField () <UITextFieldDelegate> {
    BOOL isHaveDian;
}

@end

@implementation DecimalField

- (instancetype)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self) {
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeDecimalPad;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanded:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanded:(NSNotification *)not {
    UITextField *textField = not.object;
    if ([textField isMemberOfClass:[DecimalField class]]) {
        if (textField.text.length > 0) {
            unichar single = [textField.text characterAtIndex:0];//第一个字符
            if ((single >='0' && single<='9') || single=='.') {  //数据格式正确
                if (single == '0') {
                    if (textField.text.length > 1) {
                        unichar single1 = [textField.text characterAtIndex:1];//第二个字符
                        if (single1 != '.') {
                            textField.text = [textField.text substringWithRange:NSMakeRange(1, textField.text.length-1)];
                        }
                    }
                } else if (single == '.') {
                    NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
                    [str insertString:@"0" atIndex:0];
                    textField.text = str;
                }
            } else {
                textField.text = @"";
            }
        }
    }
}

#pragma mark - UITextFieldDelegate

//textField.text 输入之前的值        string 输入的字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSLog(@"%@", NSStringFromRange(range));
    NSLog(@"%@", textField.text);
    if (([textField.text rangeOfString:@"."].location) == NSNotFound)
    {
        isHaveDian = NO;
    } else {
        isHaveDian = YES;
    }
    
    NSLog(@"%@", NSStringFromRange([textField.text rangeOfString:@"."]));
    if ([string length]>0)
    {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            if (single == '.')
            {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian = YES;
                    return YES;
                } else
                {
                    NSLog(@"亲，您已经输入过小数点了");
                    return NO;
                }
            }
            else
            {
                if (isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    NSInteger tt = range.location - ran.location;
                    if (textField.text.length-ran.location == 3) { // 已经有两位了
                        return NO;
                    }
                    if (tt <= 2){
                        return YES;
                    } else {
                        NSLog(@"亲，您最多输入两位小数");
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        } else {//输入的数据格式不正确
            NSLog(@"亲，您输入的格式不正确");
            return NO;
        }
    }
    else
    {
        return YES;
    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
