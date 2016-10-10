//
//  UIViewController+Utils.m
//  ingage
//
//  Created by purple on 15/4/21.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import "UIViewController+Utils.h"
//#import "NSObject+Common.h"

@implementation UIViewController (Utils)
+(UIViewController*) findBestViewController:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        
        // Unknown view controller type, return last child view controller
        return vc;
        
    }
    
}

+(UIViewController*) currentViewController {
    
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
    
}

//+(UINavigationController * ) getMainController {
//    
//    UIViewController * currentViewController =  [UIViewController currentViewController];
//    
//    //因为有像uialertController这样的试图控制器，所以需要判断
//    if (nil == currentViewController.navigationController)
//    {
//        return ((UITabBarController*)[NSObject getAppDelegate].window.rootViewController).selectedViewController;
//    }
//    
//    return currentViewController.navigationController;
//}
@end
