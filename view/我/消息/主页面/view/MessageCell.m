//
//  MessageCell.m
//  jingdongfang
//
//  Created by mac on 16/9/3.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _numLab.backgroundColor = [UIColor redColor];
    _numLab.layer.cornerRadius = 15/2;
    _numLab.clipsToBounds = YES;
    
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titileLab.text = self.str;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
