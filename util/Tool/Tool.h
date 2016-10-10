//
//  Tool.h
//  shop
//
//  Created by XuDong Jin on 14-5-25.
//  Copyright (c) 2014年 geek-zoo studio. All rights reserved.
//

#import <Foundation/Foundation.h>

//在子线程中运行
#define GCDA(completion) dispatch_async(dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),completion)
//在主线程中运行
#define GCDM(completion) dispatch_async(dispatch_get_main_queue(),completion)



@interface Tool : NSObject


//设置导航返回按扭没有文字
+ (void)setBackButtonNoTitle:(UIViewController *)vc;

//延迟执行的block
+ (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

//添加返回按钮
+ (void)addBackButton:(UIViewController*)ctrl;

//设置button点击效果
+ (void)setBtnSelectedStyle:(UIButton*)sender Image:(NSString*)image;

//验证手机号
+ (BOOL)verifyPhone:(UITextField*)tf;

//十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;

//时间戳转时间
+ (NSString*)timestampToString:(NSString*)stamp;
+ (NSString*)timestampToString:(NSString*)stamp Format:(NSString*)format;
+ (NSString *)stringFromDate:(NSDate *)date withFormatter:(NSString *)formatter;

//获取view的controller
+ (UIViewController *)viewController:(UIView*)view;

//打电话
+ (void)Call:(NSString*)phone InViewCtrl:(UIViewController*)ctrl;

//图片缩放到指定大小尺寸
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

+ (UIImage *)imageFromView:(UIView *)viewBac;

//针对某一个控件截屏
+ (UIImage *)snapshot:(UIView *)view;

//pop动画 改变大小
+ (void)changeSize:(UIView*)view;

//根据文字获取label大小
+ (CGSize)getLabelSizeWithText:(NSString*)str AndWidth:(float)width AndFont:(UIFont*)font attribute:(NSDictionary *)attribute;

+ (CGFloat)getCommentHeight:(CommentInfo *)info;

@end
