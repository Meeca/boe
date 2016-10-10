//
//  JDFConversAddCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/27.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "JDFConversAddCell.h"

@implementation JDFConversAddCell

- (IBAction)addAction:(UIButton *)sender
{
    if (self.block)
    {
        self.block(sender);
    }
}

- (void)awakeFromNib
{
    self.btn.layer.borderColor = [[UIColor whiteColor] CGColor];
}
@end
