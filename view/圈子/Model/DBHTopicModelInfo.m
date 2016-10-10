//
//  DBHTopicModelInfo.m
//
//  Created by DBH  on 16/9/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DBHTopicModelInfo.h"
#import "DBHTopicModelCommsList.h"


NSString *const kDBHTopicModelInfoCommsList = @"comms_list";
NSString *const kDBHTopicModelInfoUImage = @"u_image";
NSString *const kDBHTopicModelInfoCZamNum = @"c_zam_num";
NSString *const kDBHTopicModelInfoCreatedAt = @"created_at";
NSString *const kDBHTopicModelInfoTitle = @"title";
NSString *const kDBHTopicModelInfoCoId = @"co_id";
NSString *const kDBHTopicModelInfoImage = @"image";
NSString *const kDBHTopicModelInfoCZamType = @"c_zam_type";
NSString *const kDBHTopicModelInfoGagIt = @"gag_it";
NSString *const kDBHTopicModelInfoUId = @"u_id";
NSString *const kDBHTopicModelInfoName = @"name";
NSString *const kDBHTopicModelInfoContent = @"content";


@interface DBHTopicModelInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DBHTopicModelInfo

@synthesize commsList = _commsList;
@synthesize uImage = _uImage;
@synthesize cZamNum = _cZamNum;
@synthesize createdAt = _createdAt;
@synthesize title = _title;
@synthesize coId = _coId;
@synthesize image = _image;
@synthesize cZamType = _cZamType;
@synthesize gagIt = _gagIt;
@synthesize uId = _uId;
@synthesize name = _name;
@synthesize content = _content;


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
    NSObject *receivedDBHTopicModelCommsList = [dict objectForKey:kDBHTopicModelInfoCommsList];
    NSMutableArray *parsedDBHTopicModelCommsList = [NSMutableArray array];
    if ([receivedDBHTopicModelCommsList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedDBHTopicModelCommsList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedDBHTopicModelCommsList addObject:[DBHTopicModelCommsList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedDBHTopicModelCommsList isKindOfClass:[NSDictionary class]]) {
       [parsedDBHTopicModelCommsList addObject:[DBHTopicModelCommsList modelObjectWithDictionary:(NSDictionary *)receivedDBHTopicModelCommsList]];
    }

    self.commsList = [NSArray arrayWithArray:parsedDBHTopicModelCommsList];
            self.uImage = [self objectOrNilForKey:kDBHTopicModelInfoUImage fromDictionary:dict];
            self.cZamNum = [self objectOrNilForKey:kDBHTopicModelInfoCZamNum fromDictionary:dict];
            self.createdAt = [self objectOrNilForKey:kDBHTopicModelInfoCreatedAt fromDictionary:dict];
            self.title = [self objectOrNilForKey:kDBHTopicModelInfoTitle fromDictionary:dict];
            self.coId = [self objectOrNilForKey:kDBHTopicModelInfoCoId fromDictionary:dict];
            self.image = [self objectOrNilForKey:kDBHTopicModelInfoImage fromDictionary:dict];
            self.cZamType = [self objectOrNilForKey:kDBHTopicModelInfoCZamType fromDictionary:dict];
            self.gagIt = [self objectOrNilForKey:kDBHTopicModelInfoGagIt fromDictionary:dict];
            self.uId = [self objectOrNilForKey:kDBHTopicModelInfoUId fromDictionary:dict];
            self.name = [self objectOrNilForKey:kDBHTopicModelInfoName fromDictionary:dict];
            self.content = [self objectOrNilForKey:kDBHTopicModelInfoContent fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForCommsList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.commsList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCommsList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCommsList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCommsList] forKey:kDBHTopicModelInfoCommsList];
    [mutableDict setValue:self.uImage forKey:kDBHTopicModelInfoUImage];
    [mutableDict setValue:self.cZamNum forKey:kDBHTopicModelInfoCZamNum];
    [mutableDict setValue:self.createdAt forKey:kDBHTopicModelInfoCreatedAt];
    [mutableDict setValue:self.title forKey:kDBHTopicModelInfoTitle];
    [mutableDict setValue:self.coId forKey:kDBHTopicModelInfoCoId];
    [mutableDict setValue:self.image forKey:kDBHTopicModelInfoImage];
    [mutableDict setValue:self.cZamType forKey:kDBHTopicModelInfoCZamType];
    [mutableDict setValue:self.gagIt forKey:kDBHTopicModelInfoGagIt];
    [mutableDict setValue:self.uId forKey:kDBHTopicModelInfoUId];
    [mutableDict setValue:self.name forKey:kDBHTopicModelInfoName];
    [mutableDict setValue:self.content forKey:kDBHTopicModelInfoContent];

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

    self.commsList = [aDecoder decodeObjectForKey:kDBHTopicModelInfoCommsList];
    self.uImage = [aDecoder decodeObjectForKey:kDBHTopicModelInfoUImage];
    self.cZamNum = [aDecoder decodeObjectForKey:kDBHTopicModelInfoCZamNum];
    self.createdAt = [aDecoder decodeObjectForKey:kDBHTopicModelInfoCreatedAt];
    self.title = [aDecoder decodeObjectForKey:kDBHTopicModelInfoTitle];
    self.coId = [aDecoder decodeObjectForKey:kDBHTopicModelInfoCoId];
    self.image = [aDecoder decodeObjectForKey:kDBHTopicModelInfoImage];
    self.cZamType = [aDecoder decodeObjectForKey:kDBHTopicModelInfoCZamType];
    self.gagIt = [aDecoder decodeObjectForKey:kDBHTopicModelInfoGagIt];
    self.uId = [aDecoder decodeObjectForKey:kDBHTopicModelInfoUId];
    self.name = [aDecoder decodeObjectForKey:kDBHTopicModelInfoName];
    self.content = [aDecoder decodeObjectForKey:kDBHTopicModelInfoContent];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_commsList forKey:kDBHTopicModelInfoCommsList];
    [aCoder encodeObject:_uImage forKey:kDBHTopicModelInfoUImage];
    [aCoder encodeObject:_cZamNum forKey:kDBHTopicModelInfoCZamNum];
    [aCoder encodeObject:_createdAt forKey:kDBHTopicModelInfoCreatedAt];
    [aCoder encodeObject:_title forKey:kDBHTopicModelInfoTitle];
    [aCoder encodeObject:_coId forKey:kDBHTopicModelInfoCoId];
    [aCoder encodeObject:_image forKey:kDBHTopicModelInfoImage];
    [aCoder encodeObject:_cZamType forKey:kDBHTopicModelInfoCZamType];
    [aCoder encodeObject:_gagIt forKey:kDBHTopicModelInfoGagIt];
    [aCoder encodeObject:_uId forKey:kDBHTopicModelInfoUId];
    [aCoder encodeObject:_name forKey:kDBHTopicModelInfoName];
    [aCoder encodeObject:_content forKey:kDBHTopicModelInfoContent];
}

- (id)copyWithZone:(NSZone *)zone
{
    DBHTopicModelInfo *copy = [[DBHTopicModelInfo alloc] init];
    
    if (copy) {

        copy.commsList = [self.commsList copyWithZone:zone];
        copy.uImage = [self.uImage copyWithZone:zone];
        copy.cZamNum = [self.cZamNum copyWithZone:zone];
        copy.createdAt = [self.createdAt copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.coId = [self.coId copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.cZamType = [self.cZamType copyWithZone:zone];
        copy.gagIt = [self.gagIt copyWithZone:zone];
        copy.uId = [self.uId copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
    }
    
    return copy;
}


@end
