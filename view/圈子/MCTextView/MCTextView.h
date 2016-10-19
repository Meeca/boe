//
//  HWTextView.h
//  ZPF-project
//
//  Created by MiniC on 15/6/2.
//  Copyright (c) 2015年 XuDong Jin. All rights reserved.
//  增强：带有占位文字

#import <UIKit/UIKit.h>

@interface MCTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

@property (copy, nonatomic) void (^completionBlock) (NSString * text);


@end
