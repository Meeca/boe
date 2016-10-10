//
//  AddressCell.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/9.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressCell : UITableViewCell

- (void)deftAction:(void(^)(AddressInfo *info))homeb;
- (void)editAction:(void(^)(AddressInfo *info))edib;
- (void)delAction:(void(^)(AddressInfo *info))delb;

@end
