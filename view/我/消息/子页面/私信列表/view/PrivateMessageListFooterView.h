//
//  PrivateMessageListFooterView.h
//  jingdongfang
//
//  Created by mac on 16/9/3.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivateMessageListFooterView : UIView
@property (weak, nonatomic) IBOutlet UIButton *chooseAllBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleateBtn;
+ (PrivateMessageListFooterView *)privateMessageListFooterView;

@end
