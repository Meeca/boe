//
//  DBHRedEnvelopeModelDataBase.m
//
//  Created by DBH  on 16/9/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DBHRedEnvelopeModelDataBase.h"
#import "DBHRedEnvelopeModelInfo.h"


NSString *const kDBHRedEnvelopeModelDataBaseResult = @"result";
NSString *const kDBHRedEnvelopeModelDataBaseMsg = @"msg";
NSString *const kDBHRedEnvelopeModelDataBaseInfo = @"info";


@interface DBHRedEnvelopeModelDataBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DBHRedEnvelopeModelDataBase

@synthesize result = _result;
@synthesize msg = _msg;
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
            self.result = [self objectOrNilForKey:kDBHRedEnvelopeModelDataBaseResult fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kDBHRedEnvelopeModelDataBaseMsg fromDictionary:dict];
            self.info = [DBHRedEnvelopeModelInfo modelObjectWithDictionary:[dict objectForKey:kDBHRedEnvelopeModelDataBaseInfo]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.result forKey:kDBHRedEnvelopeModelDataBaseResult];
    [mutableDict setValue:self.msg forKey:kDBHRedEnvelopeModelDataBaseMsg];
    [mutableDict setValue:[self.info dictionaryRepresentation] forKey:kDBHRedEnvelopeModelDataBaseInfo];

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

    self.result = [aDecoder decodeObjectForKey:kDBHRedEnvelopeModelDataBaseResult];
    self.msg = [aDecoder decodeObjectForKey:kDBHRedEnvelopeModelDataBaseMsg];
    self.info = [aDecoder decodeObjectForKey:kDBHRedEnvelopeModelDataBaseInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kDBHRedEnvelopeModelDataBaseResult];
    [aCoder encodeObject:_msg forKey:kDBHRedEnvelopeModelDataBaseMsg];
    [aCoder encodeObject:_info forKey:kDBHRedEnvelopeModelDataBaseInfo];
}

- (id)copyWithZone:(NSZone *)zone
{
    DBHRedEnvelopeModelDataBase *copy = [[DBHRedEnvelopeModelDataBase alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
    }
    
    return copy;
}


@end
