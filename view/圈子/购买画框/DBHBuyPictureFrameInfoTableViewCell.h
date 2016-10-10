//
//  DBHBuyPictureFrameInfoTableViewCell.h
//  jingdongfang
//
//  Created by DBH on 16/9/22.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBHBuyPictureFrameModelInfo;

@interface DBHBuyPictureFrameInfoTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *topImageView;

@property (nonatomic, strong) DBHBuyPictureFrameModelInfo *model;

@end
