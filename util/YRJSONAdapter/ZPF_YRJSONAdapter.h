//
//  ZPFJSONAdapt.h
//  ZPFSnippets
//
//  Created by 王晓宇 on 14-5-13.
//  Copyright (c) 2014年 王晓宇. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *	@class	JSON的简单适配器,5.0以上使用系统的
 */
@interface ZPF_YRJSONAdapter : NSObject

+(id)objectFromJSONString:(NSString*)string;
+(id)mutableObjectFromJSONString:(NSString*)string;
+(id)objectFromJSONData:(NSData*)data;
+(id)mutableObjectFromJSONData:(NSData*)data;

+(NSString*)stringWithObject:(id)object;
+(NSData*)dataWithObject:(id)object;
@end


//category，like JSONKit
@interface NSString (ZPFJSONDeserializing)
- (id)objectFromJSONString;
- (id)mutableObjectFromJSONString;
@end

@interface NSData (ZPFSONDeserializing)
// The NSData MUST be UTF8 encoded JSON.
- (id)objectFromJSONData;
- (id)mutableObjectFromJSONData;
@end


@interface NSString (ZPFJSONSerializing)
- (NSData *)JSONData;
- (NSString *)JSONString;
@end

@interface NSArray (ZPFJSONSerializing)
- (NSData *)JSONData;
- (NSString *)JSONString;
@end

@interface NSDictionary (ZPFJSONSerializing)
- (NSData *)JSONData;
- (NSString *)JSONString;
@end