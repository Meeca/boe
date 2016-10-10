//
//  UIBarButtonItem+Extension.h
//  BeautifulFaceProject
//
//  Created by 冯 on 16/4/7.
//  Copyright © 2016年 冯洪建. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (instancetype)itemCancleWithTitle:(NSString *)title target:(id)target action:(SEL)action;


@end
