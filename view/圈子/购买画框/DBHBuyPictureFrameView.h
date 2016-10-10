//
//  DBHBuyPictureFrameView.h
//  jingdongfang
//
//  Created by DBH on 16/9/22.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBuyButtonBlock)(DetailsInfo *model);

@class DBHBuyPictureFrameSizeInfoModelInfo;

@interface DBHBuyPictureFrameView : UIView

@property (nonatomic, strong) NSArray *pictureFrameSizeArray;
@property (nonatomic, strong) NSArray *pictureFrameBorderArray;

- (void)viewShow;

- (void)viewHide;

- (void)clickBuyButtonBlock:(ClickBuyButtonBlock)clickBuyButtonBlock;

@end
