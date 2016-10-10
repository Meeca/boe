//
//  PhotoCollecCell.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/27.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollecCell : UICollectionViewCell

@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) BOOL isSel;
@property (assign, nonatomic) BOOL isHidSel;

@end
