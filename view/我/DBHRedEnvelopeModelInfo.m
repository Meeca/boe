//
//  DBHRedEnvelopeModelInfo.m
//
//  Created by DBH  on 16/9/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DBHRedEnvelopeModelInfo.h"


NSString *const kDBHRedEnvelopeModelInfoNike = @"nike";
NSString *const kDBHRedEnvelopeModelInfoContent = @"content";
NSString *const kDBHRedEnvelopeModelInfoUid = @"uid";
NSString *const kDBHRedEnvelopeModelInfoImage = @"image";
NSString *const kDBHRedEnvelopeModelInfoPrice = @"price";


@interface DBHRedEnvelopeModelInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DBHRedEnvelopeModelInfo

@synthesize nike = _nike;
@synthesize content = _content;
@synthesize uid = _uid;
@synthesize image = _image;
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
            self.nike = [self objectOrNilForKey:kDBHRedEnvelopeModelInfoNike fromDictionary:dict];
            self.content = [self objectOrNilForKey:kDBHRedEnvelopeModelInfoContent fromDictionary:dict];
            self.uid = [self objectOrNilForKey:kDBHRedEnvelopeModelInfoUid fromDictionary:dict];
            self.image = [self objectOrNilForKey:kDBHRedEnvelopeModelInfoImage fromDictionary:dict];
            self.price = [self objectOrNilForKey:kDBHRedEnvelopeModelInfoPrice fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nike forKey:kDBHRedEnvelopeModelInfoNike];
    [mutableDict setValue:self.content forKey:kDBHRedEnvelopeModelInfoContent];
    [mutableDict setValue:self.uid forKey:kDBHRedEnvelopeModelInfoUid];
    [mutableDict setValue:self.image forKey:kDBHRedEnvelopeModelInfoImage];
    [mutableDict setValue:self.price forKey:kDBHRedEnvelopeModelInfoPrice];

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

    self.nike = [aDecoder decodeObjectForKey:kDBHRedEnvelopeModelInfoNike];
    self.content = [aDecoder decodeObjectForKey:kDBHRedEnvelopeModelInfoContent];
    self.uid = [aDecoder decodeObjectForKey:kDBHRedEnvelopeModelInfoUid];
    self.image = [aDecoder decodeObjectForKey:kDBHRedEnvelopeModelInfoImage];
    self.price = [aDecoder decodeObjectForKey:kDBHRedEnvelopeModelInfoPrice];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nike forKey:kDBHRedEnvelopeModelInfoNike];
    [aCoder encodeObject:_content forKey:kDBHRedEnvelopeModelInfoContent];
    [aCoder encodeObject:_uid forKey:kDBHRedEnvelopeModelInfoUid];
    [aCoder encodeObject:_image forKey:kDBHRedEnvelopeModelInfoImage];
    [aCoder encodeObject:_price forKey:kDBHRedEnvelopeModelInfoPrice];
}

- (id)copyWithZone:(NSZone *)zone
{
    DBHRedEnvelopeModelInfo *copy = [[DBHRedEnvelopeModelInfo alloc] init];
    
    if (copy) {

        copy.nike = [self.nike copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
    }
    
    return copy;
}


@end
