//
//  SSImageView.h
//  HuaErSlimmingRing
//
//  Created by sskh on 14-8-20.
//  Copyright (c) 2014年 sskh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSImageView : UIImageView
@property (weak, nonatomic) id delegate;
@property (assign, nonatomic) SEL method;//回调方法

@end
