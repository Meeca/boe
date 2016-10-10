//
//  ShareDeviceHeaderView.m
//  jingdongfang
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "ShareDeviceHeaderView.h"

@implementation ShareDeviceHeaderView
+ (ShareDeviceHeaderView *)shareDeviceHeaderView{
    ShareDeviceHeaderView *item = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
    
    UIImageView * leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
      leftView.image = [UIImage imageNamed:@"A-sousuo"];
     item.textField.leftView = leftView;
    item.textField.leftViewMode = UITextFieldViewModeAlways;
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
