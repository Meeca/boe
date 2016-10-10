//
//  CirclePropertyTableViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/24.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CirclesRead;

@interface CirclePropertyTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *circleLabelNew;

@property (nonatomic, strong) CirclesRead *circlesRead;

@end
