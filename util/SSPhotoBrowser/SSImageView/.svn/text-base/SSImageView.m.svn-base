//
//  SSImageView.m
//  HuaErSlimmingRing
//
//  Created by sskh on 14-8-20.
//  Copyright (c) 2014年 sskh. All rights reserved.
//

#import "SSImageView.h"

@implementation SSImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *viwe = [self viewWithTag:1000];
    if (viwe) {
        viwe.hidden = YES;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([self.delegate respondsToSelector:self.method]) {
        [self.delegate performSelector:self.method withObject:self];
    } else {
        NSLog(@"回调方法没有实现:%@",NSStringFromSelector(self.method));
    }
#pragma clang diagnostic pop
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *view = [self viewWithTag:1000];
    if (!view) {
        view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.2f];
        view.tag = 1000;
        [self addSubview:view];
    } else {
        view.hidden = NO;
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *viwe = [self viewWithTag:1000];
    if (viwe) {
        viwe.hidden = YES;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
