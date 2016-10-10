//
//  CircleMembersFooterView.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/31.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "CircleMembersFooterView.h"

@implementation CircleMembersFooterView

+(CircleMembersFooterView *)circleMembersFooterView{

    CircleMembersFooterView * item = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
    
    
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
