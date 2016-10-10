//
//  JHCell.h
//  CJPubllicLessons
//
//  Created by cjatech-简豪 on 15/12/2.
//  Copyright (c) 2015年 cjatech-简豪. All rights reserved.
//

/*******************************************
 *
 *
 *
 *自定义itemcell
 *
 *
 *
 ********************************************/
#import <UIKit/UIKit.h>
@class JDFClassificationModel;

typedef void(^SearchHotKeyCellBlock)(JDFClassificationModel *searchHotModel);

@interface JHCell : UICollectionViewCell
@property (strong, nonatomic) UILabel * textLabel;  //cell中的文字
@property (nonatomic, strong) JDFClassificationModel *searchHotModel;
@property (nonatomic, copy) SearchHotKeyCellBlock block;

@end
