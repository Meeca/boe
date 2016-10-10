//
//  UIButton+Block.h
//  BeautifulFaceProject
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 冯洪建. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TapBlock)(UIButton * btn);

@interface UIButton (Block)
- (void)tapControlEventTouchUpInsideWithBlock:(TapBlock)tapBlock;
- (void)tapControlEvents:(UIControlEvents )controlEvents withBlock:(TapBlock)tapBlock;


@end
