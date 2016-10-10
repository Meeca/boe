//
//  DBHRedEnvelopeListModelDataBase.h
//
//  Created by DBH  on 16/9/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBHRedEnvelopeListModelInfo;

@interface DBHRedEnvelopeListModelDataBase : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) DBHRedEnvelopeListModelInfo *info;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
