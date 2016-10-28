//
//  Tool.m
//  shop
//
//  Created by XuDong Jin on 14-5-25.
//  Copyright (c) 2014年 geek-zoo studio. All rights reserved.
//

#import "Tool.h"


@implementation Tool

//设置导航返回按扭没有文字
+ (void)setBackButtonNoTitle:(UIViewController *)vc {
    
//    UIImage *backButtonImage =  [UIImage imageNamed:@"btn_back"];
//     backButtonImage = [backButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
////    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
//    
//    
//    
//    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
//    returnButtonItem.title = @"";
//    returnButtonItem.tintColor = [UIColor grayColor];
//     vc.navigationItem.backBarButtonItem = returnButtonItem;
//    vc.navigationController.navigationBar.tintColor = [UIColor grayColor];
}

- (void)didTapBackButton:(UIBarButtonItem *)item{

    

}

//延迟执行的block
+ (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    block = [block copy];
    [self performSelector:@selector(fireBlockAfterDelay:) withObject:block afterDelay:delay];
}

+ (void)fireBlockAfterDelay:(void (^)(void))block
{
    block();
}


//添加返回按钮
+ (void)addBackButton:(UIViewController*)ctrl{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 10, 23, 34)];
    [backBtn setContentMode:UIViewContentModeScaleAspectFill];
    //    [backBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [backBtn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    [backBtn addTarget:ctrl action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    ctrl.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

//设置button点击效果
+ (void)setBtnSelectedStyle:(UIButton*)sender Image:(NSString*)image{
    if (image) {
        [sender setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateSelected];
    }
    [sender setSelected:YES];
    
    [Tool performBlock:^{
        [sender setSelected:NO];
    } afterDelay:0.05];

}

//验证手机号
+ (BOOL)verifyPhone:(UITextField*)tf{
    if (tf.text.length==0) {
        [self presentMessageTips:@"请输入手机号"];
        return NO;
    }
    if (![tf.text isTelephone]) {
        [self presentMessageTips:@"手机号格式错误"];
        return NO;
    }
    return YES;
}

//十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


//时间转时间戳
+ (NSString*)timestampToString:(NSString*)stamp{
    return [self timestampToString:stamp Format:nil];
}

+ (NSString*)timestampToString:(NSString*)stamp Format:(NSString*)format{
    
    if (![stamp isKindOfClass:[NSNumber class]]) {
        if (stamp.length==0) {
            return @"";
        }
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    if (format) {
        [dateFormatter setDateFormat:format];
    }
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:[stamp intValue]];
    
    NSString *dateStr = [dateFormatter stringFromDate:time];
    return dateStr;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

//获取view的controller
+ (UIViewController *)viewController:(UIView*)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

//打电话
+ (void)Call:(NSString*)phone InViewCtrl:(UIViewController*)ctrl{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [ctrl.view addSubview:callWebview];
}

//图片缩放到指定大小尺寸
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
//    imgView.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
//    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    [imgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

//
+ (UIImage *)imageFromView:(UIView *)viewBac
{
    UIGraphicsBeginImageContextWithOptions(viewBac.bounds.size, YES, viewBac.layer.contentsScale);
    [viewBac.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


//针对某一个控件截屏
+ (UIImage *)snapshot:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


//根据文字获取label大小
+ (CGSize)getLabelSizeWithText:(NSString*)str AndWidth:(float)width AndFont:(UIFont*)font attribute:(NSDictionary *)attribute {
    CGSize size;
    
    if ([[[UIDevice currentDevice] systemVersion] intValue]>=7.0) {
        NSMutableDictionary *attr;
        if (attribute) {
            attr = [NSMutableDictionary dictionaryWithDictionary:attribute];
            [attr setObject:font forKey:NSFontAttributeName];
        } else {
            attr = [NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        }
        size = [str boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
    }
    else{
        size = [str sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    return size;
}

+ (CGFloat)getCommentHeight:(CommentInfo *)info {
    
    return [self getLabelSizeWithText:info.content AndWidth:KSCREENWIDTH-75 AndFont:[UIFont systemFontOfSize:15] attribute:nil].height+25+50;
}





- (void)back {
    
}

@end
