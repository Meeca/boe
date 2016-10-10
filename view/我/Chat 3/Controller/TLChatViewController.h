//
//  TLChatViewController.h
//  TLMessageView
//
//  Created by 郭锐 on 16/8/18.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLChatViewController : UIViewController
@property(nonatomic,strong)UITableView *chatTableView;

@property (nonatomic, copy) NSString *userId;

-(void)scrollToBottom;
@end
