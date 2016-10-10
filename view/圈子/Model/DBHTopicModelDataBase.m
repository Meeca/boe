//
//  DBHTopicModelDataBase.m
//
//  Created by DBH  on 16/9/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DBHTopicModelDataBase.h"
#import "DBHTopicModelInfo.h"


NSString *const kDBHTopicModelDataBaseMsg = @"msg";
NSString *const kDBHTopicModelDataBaseResult = @"result";
NSString *const kDBHTopicModelDataBaseInfo = @"info";


@interface DBHTopicModelDataBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DBHTopicModelDataBase

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
            self.msg = [self objectOrNilForKey:kDBHTopicModelDataBaseMsg fromDictionary:dict];
            self.result = [self objectOrNilForKey:kDBHTopicModelDataBaseResult fromDictionary:dict];
            self.info = [DBHTopicModelInfo modelObjectWithDictionary:[dict objectForKey:kDBHTopicModelDataBaseInfo]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.msg forKey:kDBHTopicModelDataBaseMsg];
    [mutableDict setValue:self.result forKey:kDBHTopicModelDataBaseResult];
    [mutableDict setValue:[self.info dictionaryRepresentation] forKey:kDBHTopicModelDataBaseInfo];

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

    self.msg = [aDecoder decodeObjectForKey:kDBHTopicModelDataBaseMsg];
    self.result = [aDecoder decodeObjectForKey:kDBHTopicModelDataBaseResult];
    self.info = [aDecoder decodeObjectForKey:kDBHTopicModelDataBaseInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_msg forKey:kDBHTopicModelDataBaseMsg];
    [aCoder encodeObject:_result forKey:kDBHTopicModelDataBaseResult];
    [aCoder encodeObject:_info forKey:kDBHTopicModelDataBaseInfo];
}

- (id)copyWithZone:(NSZone *)zone
{
    DBHTopicModelDataBase *copy = [[DBHTopicModelDataBase alloc] init];
    
    if (copy) {

        copy.msg = [self.msg copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
    }
    
    return copy;
}


@end
