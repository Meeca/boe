//
//  ZiLiaoTableViewCell.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/3.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZiLiaoTableViewCell : UITableViewCell

- (void)followOwerAction:(void(^)(ArtistInfo *info))block;

@end
