//
//  ShareDeviceHeaderView.h
//  jingdongfang
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareDeviceHeaderView : UIView
@property (weak, nonatomic) IBOutlet UITextField *textField;
+ (ShareDeviceHeaderView *)shareDeviceHeaderView;

@end
