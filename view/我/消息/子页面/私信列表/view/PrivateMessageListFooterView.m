//
//  PrivateMessageListFooterView.m
//  jingdongfang
//
//  Created by mac on 16/9/3.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "PrivateMessageListFooterView.h"

@implementation PrivateMessageListFooterView
+ (PrivateMessageListFooterView *)privateMessageListFooterView{
    PrivateMessageListFooterView *item = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
    return item;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
