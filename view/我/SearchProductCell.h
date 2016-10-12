//
//  SearchArtCell.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/4.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JDFProduct;

@interface SearchProductCell : UICollectionViewCell

@property (nonatomic, strong) JDFProduct *product;
@property (nonatomic, copy) void(^ tapAction)(JDFProduct *product);

@end
