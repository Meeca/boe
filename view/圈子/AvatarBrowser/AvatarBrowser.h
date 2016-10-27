//
//  ADo_AvatarBrowser.h
//  Weibo
//
//  Created by 杜 维欣 on 15/7/30.
//  Copyright (c) 2015年 Rednovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvatarBrowser : UIView

- (instancetype)initWithImage:(UIImage *)orignImage view:(UIView *)orignView;
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)orignImage view:(UIView *)orignView;

- (void)show;
@end


/*
 
 AvatarBrowser *browser = [[AvatarBrowser alloc] initWithImage:btn.imageView.image view:btn];
 [browser show];
 
 */