//
//  TLMessageCell.h
//  TLMessageView
//
//  Created by 郭锐 on 16/8/18.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLProjectMacro.h"
#import "NSDate+Utils.h"
#import "MessageModel.h"

#define SMAS(x) [self.constraints addObject:x]

@interface TLMessageBubble : UIImageView

@end

@interface TLMessageCell : UITableViewCell
@property(nonatomic,strong)TLMessageBubble *bubbleImageView;
@property(nonatomic,strong)UIImageView *arrowImageView;
@property(nonatomic,strong)UIView *statusView;
@property(nonatomic,strong)UIActivityIndicatorView *activityIndicator;
@property(nonatomic,strong)UIButton *retryBtn;
@property(nonatomic,strong)UIImageView *avatarImageView;
@property(nonatomic,strong)NSMutableArray *constraints;
@property(nonatomic,strong)UILabel *dateTimeLabel;

@property(nonatomic,strong)MessageModel *message;

@property(nonatomic, copy)void(^reSendAction)(MessageModel *message);
//@property(nonatomic,strong)void(^clickAvatar)(RCMessageDirection msgDirection);

-(void)updateDirection:(MessageType)direction;
-(void)updateMessage:(MessageModel *)message showDate:(BOOL)showDate;
-(void)setMsgStatus:(MessageStatus)msgStatus;
@end
