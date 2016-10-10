//
//  DBHBuyPictureFrameModelInfo.m
//
//  Created by DBH  on 16/9/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DBHBuyPictureFrameModelInfo.h"


NSString *const kDBHBuyPictureFrameModelInfoContent = @"content";
NSString *const kDBHBuyPictureFrameModelInfoPId = @"p_id";
NSString *const kDBHBuyPictureFrameModelInfoAllImage = @"all_image";
NSString *const kDBHBuyPictureFrameModelInfoPrice = @"price";
NSString *const kDBHBuyPictureFrameModelInfoTitle = @"title";
NSString *const kDBHBuyPictureFrameModelInfoImage = @"image";


@interface DBHBuyPictureFrameModelInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DBHBuyPictureFrameModelInfo

@synthesize content = _content;
@synthesize pId = _pId;
@synthesize allImage = _allImage;
@synthesize price = _price;
@synthesize title = _title;
@synthesize image = _image;


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
            self.content = [self objectOrNilForKey:kDBHBuyPictureFrameModelInfoContent fromDictionary:dict];
            self.pId = [self objectOrNilForKey:kDBHBuyPictureFrameModelInfoPId fromDictionary:dict];
            self.allImage = [self objectOrNilForKey:kDBHBuyPictureFrameModelInfoAllImage fromDictionary:dict];
            self.price = [self objectOrNilForKey:kDBHBuyPictureFrameModelInfoPrice fromDictionary:dict];
            self.title = [self objectOrNilForKey:kDBHBuyPictureFrameModelInfoTitle fromDictionary:dict];
            self.image = [self objectOrNilForKey:kDBHBuyPictureFrameModelInfoImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.content forKey:kDBHBuyPictureFrameModelInfoContent];
    [mutableDict setValue:self.pId forKey:kDBHBuyPictureFrameModelInfoPId];
    [mutableDict setValue:self.allImage forKey:kDBHBuyPictureFrameModelInfoAllImage];
    [mutableDict setValue:self.price forKey:kDBHBuyPictureFrameModelInfoPrice];
    [mutableDict setValue:self.title forKey:kDBHBuyPictureFrameModelInfoTitle];
    [mutableDict setValue:self.image forKey:kDBHBuyPictureFrameModelInfoImage];

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

    self.content = [aDecoder decodeObjectForKey:kDBHBuyPictureFrameModelInfoContent];
    self.pId = [aDecoder decodeObjectForKey:kDBHBuyPictureFrameModelInfoPId];
    self.allImage = [aDecoder decodeObjectForKey:kDBHBuyPictureFrameModelInfoAllImage];
    self.price = [aDecoder decodeObjectForKey:kDBHBuyPictureFrameModelInfoPrice];
    self.title = [aDecoder decodeObjectForKey:kDBHBuyPictureFrameModelInfoTitle];
    self.image = [aDecoder decodeObjectForKey:kDBHBuyPictureFrameModelInfoImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_content forKey:kDBHBuyPictureFrameModelInfoContent];
    [aCoder encodeObject:_pId forKey:kDBHBuyPictureFrameModelInfoPId];
    [aCoder encodeObject:_allImage forKey:kDBHBuyPictureFrameModelInfoAllImage];
    [aCoder encodeObject:_price forKey:kDBHBuyPictureFrameModelInfoPrice];
    [aCoder encodeObject:_title forKey:kDBHBuyPictureFrameModelInfoTitle];
    [aCoder encodeObject:_image forKey:kDBHBuyPictureFrameModelInfoImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    DBHBuyPictureFrameModelInfo *copy = [[DBHBuyPictureFrameModelInfo alloc] init];
    
    if (copy) {

        copy.content = [self.content copyWithZone:zone];
        copy.pId = [self.pId copyWithZone:zone];
        copy.allImage = [self.allImage copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
    }
    
    return copy;
}


@end
