//
//  JDFTopicHeaderView.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/24.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleTopicConverseRead.h"

@interface JDFTopicHeaderView : UIView

@property (nonatomic ,strong)CircleTopicConverseRead * ctcrModel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conversImageViewHeightConstraint;

@property (nonatomic, assign) BOOL isHideComent;

@end
