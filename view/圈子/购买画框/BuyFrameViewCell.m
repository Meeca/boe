//
//  BuyFrameViewCell.m
//  jingdongfang
//
//  Created by haozhiyu on 2016/10/27.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "BuyFrameViewCell.h"
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))
#define COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@interface BuyFrameViewCell () {
    UIImageView *imageView;
    UILabel *lable;
}

@end

@implementation BuyFrameViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)_initView {
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:imageView];
    
    lable = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:lable];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = COLOR(178, 168, 166, 1);
    lable.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(15)];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    imageView.frame = self.bounds;
    lable.frame = self.bounds;
    
    if ([self.sizeModel.sock integerValue]<=0) {
        UIImage *image = [UIImage imageNamed:@"xu"];
        imageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    } else {
        if (self.isSelected) {
            UIImage *image = [UIImage imageNamed:@"lan"];
            imageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];

        } else {
            UIImage *image = [UIImage imageNamed:@"hui"];
            imageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        }
    }
    
    lable.text = self.sizeModel.title;
    
}

@end
