//
//  DBHRedEnvelopeListModelRList.m
//
//  Created by DBH  on 16/9/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DBHRedEnvelopeListModelRList.h"


NSString *const kDBHRedEnvelopeListModelRListNike = @"nike";
NSString *const kDBHRedEnvelopeListModelRListPrice = @"price";
NSString *const kDBHRedEnvelopeListModelRListOId = @"o_id";
NSString *const kDBHRedEnvelopeListModelRListCreatedAt = @"created_at";


@interface DBHRedEnvelopeListModelRList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DBHRedEnvelopeListModelRList

@synthesize nike = _nike;
@synthesize price = _price;
@synthesize oId = _oId;
@synthesize createdAt = _createdAt;


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
            self.nike = [self objectOrNilForKey:kDBHRedEnvelopeListModelRListNike fromDictionary:dict];
            self.price = [self objectOrNilForKey:kDBHRedEnvelopeListModelRListPrice fromDictionary:dict];
            self.oId = [self objectOrNilForKey:kDBHRedEnvelopeListModelRListOId fromDictionary:dict];
            self.createdAt = [self objectOrNilForKey:kDBHRedEnvelopeListModelRListCreatedAt fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nike forKey:kDBHRedEnvelopeListModelRListNike];
    [mutableDict setValue:self.price forKey:kDBHRedEnvelopeListModelRListPrice];
    [mutableDict setValue:self.oId forKey:kDBHRedEnvelopeListModelRListOId];
    [mutableDict setValue:self.createdAt forKey:kDBHRedEnvelopeListModelRListCreatedAt];

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

    self.nike = [aDecoder decodeObjectForKey:kDBHRedEnvelopeListModelRListNike];
    self.price = [aDecoder decodeObjectForKey:kDBHRedEnvelopeListModelRListPrice];
    self.oId = [aDecoder decodeObjectForKey:kDBHRedEnvelopeListModelRListOId];
    self.createdAt = [aDecoder decodeObjectForKey:kDBHRedEnvelopeListModelRListCreatedAt];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nike forKey:kDBHRedEnvelopeListModelRListNike];
    [aCoder encodeObject:_price forKey:kDBHRedEnvelopeListModelRListPrice];
    [aCoder encodeObject:_oId forKey:kDBHRedEnvelopeListModelRListOId];
    [aCoder encodeObject:_createdAt forKey:kDBHRedEnvelopeListModelRListCreatedAt];
}

- (id)copyWithZone:(NSZone *)zone
{
    DBHRedEnvelopeListModelRList *copy = [[DBHRedEnvelopeListModelRList alloc] init];
    
    if (copy) {

        copy.nike = [self.nike copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.oId = [self.oId copyWithZone:zone];
        copy.createdAt = [self.createdAt copyWithZone:zone];
    }
    
    return copy;
}


@end
