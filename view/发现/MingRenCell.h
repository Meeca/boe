//
//  MingRenCell.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/2.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MingRenCell : UITableViewCell

@property (copy, nonatomic) void(^block)(id f);

@property (copy, nonatomic) NSIndexPath *index;

- (void)itmeAction:(void(^)(id f))block;

@end
