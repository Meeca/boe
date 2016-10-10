//
//  DBHRedEnvelopeListModelInfo.m
//
//  Created by DBH  on 16/9/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DBHRedEnvelopeListModelInfo.h"
#import "DBHRedEnvelopeListModelRList.h"


NSString *const kDBHRedEnvelopeListModelInfoRList = @"r_list";
NSString *const kDBHRedEnvelopeListModelInfoUId = @"u_id";
NSString *const kDBHRedEnvelopeListModelInfoUNike = @"u_nike";
NSString *const kDBHRedEnvelopeListModelInfoAllprice = @"allprice";
NSString *const kDBHRedEnvelopeListModelInfoUImage = @"u_image";


@interface DBHRedEnvelopeListModelInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DBHRedEnvelopeListModelInfo

@synthesize rList = _rList;
@synthesize uId = _uId;
@synthesize uNike = _uNike;
@synthesize allprice = _allprice;
@synthesize uImage = _uImage;


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
    NSObject *receivedDBHRedEnvelopeListModelRList = [dict objectForKey:kDBHRedEnvelopeListModelInfoRList];
    NSMutableArray *parsedDBHRedEnvelopeListModelRList = [NSMutableArray array];
    if ([receivedDBHRedEnvelopeListModelRList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedDBHRedEnvelopeListModelRList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedDBHRedEnvelopeListModelRList addObject:[DBHRedEnvelopeListModelRList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedDBHRedEnvelopeListModelRList isKindOfClass:[NSDictionary class]]) {
       [parsedDBHRedEnvelopeListModelRList addObject:[DBHRedEnvelopeListModelRList modelObjectWithDictionary:(NSDictionary *)receivedDBHRedEnvelopeListModelRList]];
    }

    self.rList = [NSArray arrayWithArray:parsedDBHRedEnvelopeListModelRList];
            self.uId = [self objectOrNilForKey:kDBHRedEnvelopeListModelInfoUId fromDictionary:dict];
            self.uNike = [self objectOrNilForKey:kDBHRedEnvelopeListModelInfoUNike fromDictionary:dict];
            self.allprice = [self objectOrNilForKey:kDBHRedEnvelopeListModelInfoAllprice fromDictionary:dict];
            self.uImage = [self objectOrNilForKey:kDBHRedEnvelopeListModelInfoUImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForRList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.rList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRList] forKey:kDBHRedEnvelopeListModelInfoRList];
    [mutableDict setValue:self.uId forKey:kDBHRedEnvelopeListModelInfoUId];
    [mutableDict setValue:self.uNike forKey:kDBHRedEnvelopeListModelInfoUNike];
    [mutableDict setValue:self.allprice forKey:kDBHRedEnvelopeListModelInfoAllprice];
    [mutableDict setValue:self.uImage forKey:kDBHRedEnvelopeListModelInfoUImage];

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

    self.rList = [aDecoder decodeObjectForKey:kDBHRedEnvelopeListModelInfoRList];
    self.uId = [aDecoder decodeObjectForKey:kDBHRedEnvelopeListModelInfoUId];
    self.uNike = [aDecoder decodeObjectForKey:kDBHRedEnvelopeListModelInfoUNike];
    self.allprice = [aDecoder decodeObjectForKey:kDBHRedEnvelopeListModelInfoAllprice];
    self.uImage = [aDecoder decodeObjectForKey:kDBHRedEnvelopeListModelInfoUImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_rList forKey:kDBHRedEnvelopeListModelInfoRList];
    [aCoder encodeObject:_uId forKey:kDBHRedEnvelopeListModelInfoUId];
    [aCoder encodeObject:_uNike forKey:kDBHRedEnvelopeListModelInfoUNike];
    [aCoder encodeObject:_allprice forKey:kDBHRedEnvelopeListModelInfoAllprice];
    [aCoder encodeObject:_uImage forKey:kDBHRedEnvelopeListModelInfoUImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    DBHRedEnvelopeListModelInfo *copy = [[DBHRedEnvelopeListModelInfo alloc] init];
    
    if (copy) {

        copy.rList = [self.rList copyWithZone:zone];
        copy.uId = [self.uId copyWithZone:zone];
        copy.uNike = [self.uNike copyWithZone:zone];
        copy.allprice = [self.allprice copyWithZone:zone];
        copy.uImage = [self.uImage copyWithZone:zone];
    }
    
    return copy;
}


@end
