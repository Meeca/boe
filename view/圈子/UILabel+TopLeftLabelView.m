//
//  UILabel+TopLeftLabelView.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/14.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "UILabel+TopLeftLabelView.h"

@implementation UILabel (TopLeftLabelView)

- (void)setTopAlignmentWithText:(NSString *)text maxHeight:(CGFloat)maxHeight
{
    CGRect frame = self.frame;
    CGSize size = [text sizeWithFont:self.font constrainedToSize:CGSizeMake(frame.size.width, maxHeight)];
    frame.size = CGSizeMake(frame.size.width, size.height);
    self.frame = frame;
    self.text = text;
}

@end
