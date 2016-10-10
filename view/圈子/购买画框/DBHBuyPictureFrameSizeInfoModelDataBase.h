//
//  DBHBuyPictureFrameSizeInfoModelDataBase.h
//
//  Created by DBH  on 16/9/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DBHBuyPictureFrameSizeInfoModelDataBase : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSArray *info;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
