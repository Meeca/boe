//
//  DBHCommentCellTableViewCell.h
//  jingdongfang
//
//  Created by DBH on 16/9/23.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentInfo;
@class DBHTopicModelRCommentList;

@interface DBHCommentCellTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *object;

@property (nonatomic, strong) CommentInfo *model;

@property (nonatomic, strong) DBHTopicModelRCommentList *otherModel;

- (void)hideSeparation;

@end
