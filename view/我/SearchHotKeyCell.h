//
//  SearchHotKeyCell.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/4.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDFSearchHotKeyModel;

typedef void(^SearchHotKeyCellBlock)(JDFSearchHotKeyModel *searchHotModel);

@interface SearchHotKeyCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *searchLabel;
@property (nonatomic, strong) JDFSearchHotKeyModel *searchHotModel;

@property (nonatomic, copy) SearchHotKeyCellBlock block;

@end
