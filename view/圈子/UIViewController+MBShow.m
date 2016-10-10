//
//  UIViewController+MBShow.m
//  ManTu
//
//  Created by 于国文 on 16/8/15.
//  Copyright © 2016年 yuguowen. All rights reserved.
//

#import "UIViewController+MBShow.h"
#import "MBProgressHUD.h"

@implementation UIViewController (MBShow)

-(void)showToastWithMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    [hud hide:YES afterDelay:1.0];
}

@end
