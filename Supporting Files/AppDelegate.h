//
//  AppDelegate.h
//  ZPFramework
//
//  Created by XuDong Jin on 14-6-30.
//  Copyright (c) 2014年 XuDong Jin. All rights reserved.
//

#import <UIKit/UIKit.h>
//alipay
#import "DataVerifier.h"
//locationmanager
#import "LocationManager.h"
//引导图
#import "ICETutorialController.h"

#import "HomeViewController.h"
#import "FindViewController.h"
#import "CircleViewController.h"
#import "MeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, ICETutorialControllerDelegate>
{
    ICETutorialController *guideViewController;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BaseTabBarController *ctrl;


@end


//  com.zipingfang.jingdongfang