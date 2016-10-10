//
//  DBHRedEnvelopeView.h
//  Jiatingquan
//
//  Created by DBH on 16/9/20.
//  Copyright © 2016年 邓毕华. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBHRedEnvelopeModelInfo;

typedef void(^ClickButtonBlock)(NSString *userId);

@interface DBHRedEnvelopeView : UIView

@property (nonatomic, strong) DBHRedEnvelopeModelInfo *model;

- (void)clickButtonBlock:(ClickButtonBlock)clickButtonBlock;

@end
