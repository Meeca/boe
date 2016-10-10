//
//  OrderFooter.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/11.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "OrderFooter.h"

@interface OrderFooter () {
    UIView *view;
    UILabel *msg;
    UILabel *price;
}

@end

@implementation OrderFooter

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    return self;
}

- (void)_initViews {
    self.contentView.backgroundColor = RGB(234, 234, 234);
    view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    
    msg = [[UILabel alloc] initWithFrame:CGRectZero];
    msg.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:msg];
    
    price = [[UILabel alloc] initWithFrame:CGRectZero];
    price.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:price];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    OrderInfo *info = self.data;
    
    view.frame = CGRectMake(0, 0, self.width, self.height-10);
    
    msg.text = @"共1件商品  合计：";
    [msg sizeToFit];
    
    price.text = [NSString stringWithFormat:@"￥%@", info.price.length>0?info.price:@"0"];
    [price sizeToFit];
    price.right = self.width-15;
    price.centerY = (self.height-10)/2;
    
    msg.right = price.left;
    msg.bottom = price.bottom;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
