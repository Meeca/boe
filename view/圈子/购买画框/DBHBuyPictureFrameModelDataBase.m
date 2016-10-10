//
//  DBHBuyPictureFrameModelDataBase.m
//
//  Created by DBH  on 16/9/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DBHBuyPictureFrameModelDataBase.h"
#import "DBHBuyPictureFrameModelInfo.h"


NSString *const kDBHBuyPictureFrameModelDataBaseMsg = @"msg";
NSString *const kDBHBuyPictureFrameModelDataBaseResult = @"result";
NSString *const kDBHBuyPictureFrameModelDataBaseInfo = @"info";


@interface DBHBuyPictureFrameModelDataBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DBHBuyPictureFrameModelDataBase

@synthesize msg = _msg;
@synthesize result = _result;
@synthesize info = _info;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.msg = [self objectOrNilForKey:kDBHBuyPictureFrameModelDataBaseMsg fromDictionary:dict];
            self.result = [self objectOrNilForKey:kDBHBuyPictureFrameModelDataBaseResult fromDictionary:dict];
            self.info = [DBHBuyPictureFrameModelInfo modelObjectWithDictionary:[dict objectForKey:kDBHBuyPictureFrameModelDataBaseInfo]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.msg forKey:kDBHBuyPictureFrameModelDataBaseMsg];
    [mutableDict setValue:self.result forKey:kDBHBuyPictureFrameModelDataBaseResult];
    [mutableDict setValue:[self.info dictionaryRepresentation] forKey:kDBHBuyPictureFrameModelDataBaseInfo];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.msg = [aDecoder decodeObjectForKey:kDBHBuyPictureFrameModelDataBaseMsg];
    self.result = [aDecoder decodeObjectForKey:kDBHBuyPictureFrameModelDataBaseResult];
    self.info = [aDecoder decodeObjectForKey:kDBHBuyPictureFrameModelDataBaseInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_msg forKey:kDBHBuyPictureFrameModelDataBaseMsg];
    [aCoder encodeObject:_result forKey:kDBHBuyPictureFrameModelDataBaseResult];
    [aCoder encodeObject:_info forKey:kDBHBuyPictureFrameModelDataBaseInfo];
}

- (id)copyWithZone:(NSZone *)zone
{
    DBHBuyPictureFrameModelDataBase *copy = [[DBHBuyPictureFrameModelDataBase alloc] init];
    
    if (copy) {

        copy.msg = [self.msg copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
    }
    
    return copy;
}


@end
