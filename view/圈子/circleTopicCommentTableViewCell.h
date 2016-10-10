//
//  circleTopicCommentTableViewCell.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/29.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Comms_List;
@class DBHTopicModelCommsList;

@interface circleTopicCommentTableViewCell : UITableViewCell

@property (nonatomic ,strong)Comms_List * commsList;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewBtn;

@property (nonatomic, strong) DBHTopicModelCommsList *model;

@end
