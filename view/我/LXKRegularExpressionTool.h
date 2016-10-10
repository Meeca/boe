//
//  LXKRegularExpressionTool.h
//  YiKu
//
//  Created by xingkuanlin on 16/8/9.
//  Copyright © 2016年 xingkuanlin. All rights reserved.
//

/**
 *  带有变量的字符串使用nspread会崩溃
 *
 *  @param BOOL bool
 *
 *  @return 正则表达验证
 */
#import <Foundation/Foundation.h>


/**
 *  正则表达式的验证
 */
@interface LXKRegularExpressionTool : NSObject

/**
 *  验证用户身份证号 15或18位,18的最后可能是X
 *
 *  @param idCard idCard
 *
 *  @return bool
 */
+ (BOOL)checkUserIdCard:(NSString *)idCard;

/**
 *  移动手机号的正则表达式 以13,15,18开头的
 *
 *  @param mobileNumber 移动手机号
 *
 *  @return 判定手机号是否正确
 */
+ (BOOL)isValidateMobile:(NSString *)mobileNumber;

/**
 *  验证邮箱
 *
 *  @param email 邮箱地址
 *
 *  @return 判断邮箱格式是否正确
 */
+ (BOOL)checkEmail:(NSString *)email;

/**
 *  6-16数组和字母的组合
 *
 *  @param password password
 *
 *  @return YES才符合要求
 */
+ (BOOL)checkPassword:(NSString *) password;

@end
