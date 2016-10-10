//
//  FindCollectionViewCell.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindCollectionViewCell : UICollectionViewCell

@property (copy, nonatomic) NSString *imgUrl;
@property (strong,nonatomic)NSString *shoucang;
@property (strong,nonatomic)NSString *goumai;
@property (strong,nonatomic)NSString *guanzhu;
@property (assign ,nonatomic) BOOL isShow;

@property (copy, nonatomic) NSIndexPath *index;
@end
