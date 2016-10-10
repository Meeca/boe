//
//  DBHRedEnveloPeListHeaderView.h
//  Jiatingquan
//
//  Created by DBH on 16/9/20.
//  Copyright © 2016年 邓毕华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickButtonBlock)();

@class DBHRedEnvelopeListModelInfo;

@interface DBHRedEnveloPeListHeaderView : UIView

@property (nonatomic, strong) DBHRedEnvelopeListModelInfo *model;

- (void)clickButtonBlock:(ClickButtonBlock)clickButtonBlock;

@end
