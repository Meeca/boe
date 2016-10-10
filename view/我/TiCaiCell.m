//
//  TiCaiCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/8.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "TiCaiCell.h"

@interface TiCaiCell () {
    UILabel *textLabel;
}

@end

@implementation TiCaiCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        textLabel.font = [UIFont systemFontOfSize:14];
        textLabel.layer.cornerRadius = 5;
        textLabel.layer.masksToBounds = YES;
        textLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:textLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    ThemeList *t = self.data;
    
    textLabel.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
    textLabel.text = t.title.length > 0 ? t.title : @"";
    if (self.sel) {
        textLabel.backgroundColor = KAPPCOLOR;
        textLabel.textColor = [UIColor whiteColor];
    } else {
        textLabel.backgroundColor = [UIColor whiteColor];
        textLabel.textColor = [UIColor blackColor];
    }
}

@end
