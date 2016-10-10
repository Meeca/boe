//
//  DBHBuyPictureFrameNumberView.h
//  jingdongfang
//
//  Created by DBH on 16/9/22.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickButtonBlock)(NSInteger number);

@interface DBHBuyPictureFrameNumberView : UIView

@property (nonatomic, strong) NSString *number;

- (void)clickButtonBlock:(ClickButtonBlock)clickButtonBlock;

@end
