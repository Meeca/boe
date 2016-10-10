//
//  DBHRedEnvelopeListModelDataBase.m
//
//  Created by DBH  on 16/9/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DBHRedEnvelopeListModelDataBase.h"
#import "DBHRedEnvelopeListModelInfo.h"


NSString *const kDBHRedEnvelopeListModelDataBaseResult = @"result";
NSString *const kDBHRedEnvelopeListModelDataBaseMsg = @"msg";
NSString *const kDBHRedEnvelopeListModelDataBaseInfo = @"info";


@interface DBHRedEnvelopeListModelDataBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DBHRedEnvelopeListModelDataBase

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
            self.result = [self objectOrNilForKey:kDBHRedEnvelopeListModelDataBaseResult fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kDBHRedEnvelopeListModelDataBaseMsg fromDictionary:dict];
            self.info = [DBHRedEnvelopeListModelInfo modelObjectWithDictionary:[dict objectForKey:kDBHRedEnvelopeListModelDataBaseInfo]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.result forKey:kDBHRedEnvelopeListModelDataBaseResult];
    [mutableDict setValue:self.msg forKey:kDBHRedEnvelopeListModelDataBaseMsg];
    [mutableDict setValue:[self.info dictionaryRepresentation] forKey:kDBHRedEnvelopeListModelDataBaseInfo];

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

    self.result = [aDecoder decodeObjectForKey:kDBHRedEnvelopeListModelDataBaseResult];
    self.msg = [aDecoder decodeObjectForKey:kDBHRedEnvelopeListModelDataBaseMsg];
    self.info = [aDecoder decodeObjectForKey:kDBHRedEnvelopeListModelDataBaseInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kDBHRedEnvelopeListModelDataBaseResult];
    [aCoder encodeObject:_msg forKey:kDBHRedEnvelopeListModelDataBaseMsg];
    [aCoder encodeObject:_info forKey:kDBHRedEnvelopeListModelDataBaseInfo];
}

- (id)copyWithZone:(NSZone *)zone
{
    DBHRedEnvelopeListModelDataBase *copy = [[DBHRedEnvelopeListModelDataBase alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
    }
    
    return copy;
}


@end
