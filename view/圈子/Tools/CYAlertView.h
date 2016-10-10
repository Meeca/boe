//
//  CYAlertView.h
//  CYAlertView
//
//  Created by A_Dirt on 16/5/5.
//  Copyright © 2016年 A_Dirt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYAlertView;

@protocol CYAlertViewDelegate

@required

- (void)alertView:(CYAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex password:(NSString *)pass;

@end

@interface CYAlertView : UIView

@property (weak, nonatomic) id <CYAlertViewDelegate> delegate;

//标题
@property (strong, nonatomic) NSString *title;
//内容
@property (strong, nonatomic) NSString *content;

//文本框
@property (strong,nonatomic) NSString *pass;

- (void)show;


@end
