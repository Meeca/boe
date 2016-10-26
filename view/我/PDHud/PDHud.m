//
//  PDHud.m
//  QiXiaoFuProject
//
//  Created by mac on 16/9/11.
//  Copyright © 2016年 fhj. All rights reserved.
//

#import "PDHud.h"
#import <objc/runtime.h>

@implementation PDHud

// Customization
+ (void)initialize
{
    
//    NSURL *url = [[NSBundle mainBundle ] URLForResource:@"PDHud" withExtension:@"bundle"];
//    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
//    
//    
//    [UIImage imageNamed:@"MCBannerView.bundle/banner_arrow.png"];
//    UIImage* infoImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle ] pathForResource:@"HUD_info" ofType:@"png"]];
//    UIImage* successImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle ] pathForResource:@"HUD_success" ofType:@"png"]];
//    UIImage* errorImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle ] pathForResource:@"HUD_error" ofType:@"png"]];
//    
//    
    self.minimumDismissTimeInterval = 1.50f;
    [self setSuccessImage:[UIImage imageNamed:@"PDHud.bundle/HUD_success@2x.png"]];
    [self setInfoImage:[UIImage imageNamed:@"PDHud.bundle/HUD_info@2x.png"]];
    [self setErrorImage:[UIImage imageNamed:@"PDHud.bundle/HUD_error@2x.png"]];
    
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self setDefaultStyle:SVProgressHUDStyleDark];
    [self setCornerRadius:8.0];
}


// 根据 提示文字字数，判断 HUD 显示时间
- (NSTimeInterval)displayDurationForString:(NSString*)string
{
    return MIN((float)string.length*0.06 + 0.5, 2.0);
}

// 修改 HUD 颜色，需要取消混合效果(使`backgroundColroForStyle`方法有效)
- (void)updateBlurBounds{
}

// HUD 颜色
- (UIColor*)backgroundColorForStyle{
    return [UIColor colorWithWhite:0 alpha:0.9];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
