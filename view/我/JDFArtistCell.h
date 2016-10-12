//
//  JDFArtistCell.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/4.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JDFArtist;

@interface JDFArtistCell : UITableViewCell

@property (nonatomic, strong) JDFArtist *artist;
@property (nonatomic, copy) void(^ tapAction)(JDFArtist *artist);

@end
