//
//  DBHBuyPictureFrameModelDataBase.h
//
//  Created by DBH  on 16/9/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBHBuyPictureFrameModelInfo;

@interface DBHBuyPictureFrameModelDataBase : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) DBHBuyPictureFrameModelInfo *info;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
