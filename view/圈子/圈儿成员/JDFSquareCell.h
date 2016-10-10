//
//  JDFSquareCell.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/25.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDFSquareItem.h"

@interface JDFSquareCell : UICollectionViewCell


@property (nonatomic, strong) JDFSquareItem * jDFSquareItem;


@property (weak, nonatomic) IBOutlet UIButton *chooseSquareBtn;
@property (nonatomic) BOOL disabled;
@property (nonatomic,assign) BOOL isShow;

@end
