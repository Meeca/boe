//
//  JJViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/2.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJViewController : UIViewController

@property (copy, nonatomic) void(^block)(ArtistInfo *info);

- (void)loadModel:(NSString *)u_id;
- (void)loadDataSucc:(void(^)(ArtistInfo *info))block;

@end
