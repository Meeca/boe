//
//  UIButton+Block.m
//  BeautifulFaceProject
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 冯洪建. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>

static const void * Btnkey = &Btnkey;

@implementation UIButton (Block)

- (void)tapControlEventTouchUpInsideWithBlock:(TapBlock)tapBlock{
    [self tapControlEvents:UIControlEventTouchUpInside withBlock:^(UIButton *btn) {
        tapBlock(btn);
    }];
}
- (void)tapControlEvents:(UIControlEvents )controlEvents withBlock:(TapBlock)tapBlock{
    objc_setAssociatedObject(self, Btnkey, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(btnAction:) forControlEvents:controlEvents];
}
- (void)btnAction:(UIButton *)btn{
    TapBlock tapBlock = objc_getAssociatedObject(self, Btnkey);
    if (tapBlock) {
        tapBlock(btn);
    }
}

@end
