//
//  TableHeader.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/2.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableHeader : UITableViewHeaderFooterView

@property (copy, nonatomic) void(^block1)(ArtistInfo *info);
@property (copy, nonatomic) void(^block2)(ArtistInfo *info);

- (void)iconAction:(void(^)(ArtistInfo *info))block;
- (void)followerAction:(void(^)(ArtistInfo *info))block;

@end
