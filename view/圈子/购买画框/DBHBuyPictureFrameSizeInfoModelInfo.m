//
//  DBHBuyPictureFrameSizeInfoModelInfo.m
//
//  Created by DBH  on 16/9/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DBHBuyPictureFrameSizeInfoModelInfo.h"


NSString *const kDBHBuyPictureFrameSizeInfoModelInfoTitle = @"title";
NSString *const kDBHBuyPictureFrameSizeInfoModelInfoSock = @"sock";
NSString *const kDBHBuyPictureFrameSizeInfoModelInfoAId = @"a_id";
NSString *const kDBHBuyPictureFrameSizeInfoModelInfoPrice = @"price";


@interface DBHBuyPictureFrameSizeInfoModelInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DBHBuyPictureFrameSizeInfoModelInfo

@synthesize title = _title;
@synthesize sock = _sock;
@synthesize aId = _aId;
@synthesize price = _price;


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
            self.title = [self objectOrNilForKey:kDBHBuyPictureFrameSizeInfoModelInfoTitle fromDictionary:dict];
            self.sock = [self objectOrNilForKey:kDBHBuyPictureFrameSizeInfoModelInfoSock fromDictionary:dict];
            self.aId = [self objectOrNilForKey:kDBHBuyPictureFrameSizeInfoModelInfoAId fromDictionary:dict];
            self.price = [self objectOrNilForKey:kDBHBuyPictureFrameSizeInfoModelInfoPrice fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.title forKey:kDBHBuyPictureFrameSizeInfoModelInfoTitle];
    [mutableDict setValue:self.sock forKey:kDBHBuyPictureFrameSizeInfoModelInfoSock];
    [mutableDict setValue:self.aId forKey:kDBHBuyPictureFrameSizeInfoModelInfoAId];
    [mutableDict setValue:self.price forKey:kDBHBuyPictureFrameSizeInfoModelInfoPrice];

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

    self.title = [aDecoder decodeObjectForKey:kDBHBuyPictureFrameSizeInfoModelInfoTitle];
    self.sock = [aDecoder decodeObjectForKey:kDBHBuyPictureFrameSizeInfoModelInfoSock];
    self.aId = [aDecoder decodeObjectForKey:kDBHBuyPictureFrameSizeInfoModelInfoAId];
    self.price = [aDecoder decodeObjectForKey:kDBHBuyPictureFrameSizeInfoModelInfoPrice];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_title forKey:kDBHBuyPictureFrameSizeInfoModelInfoTitle];
    [aCoder encodeObject:_sock forKey:kDBHBuyPictureFrameSizeInfoModelInfoSock];
    [aCoder encodeObject:_aId forKey:kDBHBuyPictureFrameSizeInfoModelInfoAId];
    [aCoder encodeObject:_price forKey:kDBHBuyPictureFrameSizeInfoModelInfoPrice];
}

- (id)copyWithZone:(NSZone *)zone
{
    DBHBuyPictureFrameSizeInfoModelInfo *copy = [[DBHBuyPictureFrameSizeInfoModelInfo alloc] init];
    
    if (copy) {

        copy.title = [self.title copyWithZone:zone];
        copy.sock = [self.sock copyWithZone:zone];
        copy.aId = [self.aId copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
    }
    
    return copy;
}


@end
