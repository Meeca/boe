//
//  LXKRegularExpressionTool.m
//  YiKu
//
//  Created by xingkuanlin on 16/8/9.
//  Copyright © 2016年 xingkuanlin. All rights reserved.
//

#import "LXKRegularExpressionTool.h"

@implementation LXKRegularExpressionTool

/**
 *  验证用户身份证号 15或18位,18的最后可能是X
 *
 *  @param idCard idCard
 *
 *  @return bool
 */
+ (BOOL)checkUserIdCard:(NSString *)idCard {
    if (idCard) {
        // ^匹配字符串开始的意思 $是结束
        
        NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
        BOOL isMatch = [pred evaluateWithObject:idCard];
        return isMatch;
//        NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X$)";
//        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
//        return [pred evaluateWithObject:idCard];
    } else {
        return NO;
    }
    
}


/**
 *  移动手机号的正则表达式 以13,15,18开头的
 *
 *  @param mobileNumber 移动手机号
 *
 *  @return 判定手机号是否正确
 */
+ (BOOL)isValidateMobile:(NSString *)mobileNumber {
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNumber];
}

+ (BOOL)checkEmail:(NSString *)email {
    NSString *MOBILE = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:email];
}

/**
 *  6-16数组和字母的组合
 *
 *  @param password password
 *
 *  @return YES才符合要求
 */
+ (BOOL)checkPassword:(NSString *) password {
    NSString *pattern = @"[0-9a-zA-Z]{6,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

@end
