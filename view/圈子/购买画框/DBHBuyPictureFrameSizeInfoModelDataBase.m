//
//  DBHBuyPictureFrameSizeInfoModelDataBase.m
//
//  Created by DBH  on 16/9/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DBHBuyPictureFrameSizeInfoModelDataBase.h"
#import "DBHBuyPictureFrameSizeInfoModelInfo.h"


NSString *const kDBHBuyPictureFrameSizeInfoModelDataBaseMsg = @"msg";
NSString *const kDBHBuyPictureFrameSizeInfoModelDataBaseResult = @"result";
NSString *const kDBHBuyPictureFrameSizeInfoModelDataBaseInfo = @"info";


@interface DBHBuyPictureFrameSizeInfoModelDataBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DBHBuyPictureFrameSizeInfoModelDataBase

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
            self.msg = [self objectOrNilForKey:kDBHBuyPictureFrameSizeInfoModelDataBaseMsg fromDictionary:dict];
            self.result = [self objectOrNilForKey:kDBHBuyPictureFrameSizeInfoModelDataBaseResult fromDictionary:dict];
    NSObject *receivedDBHBuyPictureFrameSizeInfoModelInfo = [dict objectForKey:kDBHBuyPictureFrameSizeInfoModelDataBaseInfo];
    NSMutableArray *parsedDBHBuyPictureFrameSizeInfoModelInfo = [NSMutableArray array];
    if ([receivedDBHBuyPictureFrameSizeInfoModelInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedDBHBuyPictureFrameSizeInfoModelInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedDBHBuyPictureFrameSizeInfoModelInfo addObject:[DBHBuyPictureFrameSizeInfoModelInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedDBHBuyPictureFrameSizeInfoModelInfo isKindOfClass:[NSDictionary class]]) {
       [parsedDBHBuyPictureFrameSizeInfoModelInfo addObject:[DBHBuyPictureFrameSizeInfoModelInfo modelObjectWithDictionary:(NSDictionary *)receivedDBHBuyPictureFrameSizeInfoModelInfo]];
    }

    self.info = [NSArray arrayWithArray:parsedDBHBuyPictureFrameSizeInfoModelInfo];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.msg forKey:kDBHBuyPictureFrameSizeInfoModelDataBaseMsg];
    [mutableDict setValue:self.result forKey:kDBHBuyPictureFrameSizeInfoModelDataBaseResult];
    NSMutableArray *tempArrayForInfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.info) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForInfo] forKey:kDBHBuyPictureFrameSizeInfoModelDataBaseInfo];

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

    self.msg = [aDecoder decodeObjectForKey:kDBHBuyPictureFrameSizeInfoModelDataBaseMsg];
    self.result = [aDecoder decodeObjectForKey:kDBHBuyPictureFrameSizeInfoModelDataBaseResult];
    self.info = [aDecoder decodeObjectForKey:kDBHBuyPictureFrameSizeInfoModelDataBaseInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_msg forKey:kDBHBuyPictureFrameSizeInfoModelDataBaseMsg];
    [aCoder encodeObject:_result forKey:kDBHBuyPictureFrameSizeInfoModelDataBaseResult];
    [aCoder encodeObject:_info forKey:kDBHBuyPictureFrameSizeInfoModelDataBaseInfo];
}

- (id)copyWithZone:(NSZone *)zone
{
    DBHBuyPictureFrameSizeInfoModelDataBase *copy = [[DBHBuyPictureFrameSizeInfoModelDataBase alloc] init];
    
    if (copy) {

        copy.msg = [self.msg copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
    }
    
    return copy;
}


@end
