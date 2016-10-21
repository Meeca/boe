//
//  JDFSearchView.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/21.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "JDFSearchView.h"
#import "CircleSearchViewController.h"

@implementation JDFSearchView

- (IBAction)jumpCircleSearchVC:(id)sender
{
    NSLog(@"你点击了搜索按钮");
    
    CircleSearchViewController *circleSearchVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleSearchViewController"];
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:circleSearchVC];
//    [naviVC setNavigationBarHidden:YES animated:YES];
    
    [[self getCurrentViewController] presentViewController:naviVC animated:YES completion:^{
        
    }];
    
}
-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}
@end
