//
//  ViewAllContentViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/14.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewAllContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *contentLabel;

@property (nonatomic,strong)NSString *content;
@end
