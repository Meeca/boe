//
//  DBHTopicModelRCommentList.m
//
//  Created by DBH  on 16/9/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DBHTopicModelRCommentList.h"


NSString *const kDBHTopicModelRCommentListUName = @"u_name";
NSString *const kDBHTopicModelRCommentListUId = @"u_id";
NSString *const kDBHTopicModelRCommentListTitle = @"title";
NSString *const kDBHTopicModelRCommentListRId = @"r_id";
NSString *const kDBHTopicModelRCommentListUImage = @"u_image";
NSString *const kDBHTopicModelRCommentListCreatedAt = @"created_at";
NSString *const kDBHTopicModelRCommentListU_image = @"image";


@interface DBHTopicModelRCommentList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DBHTopicModelRCommentList

@synthesize uName = _uName;
@synthesize uId = _uId;
@synthesize title = _title;
@synthesize rId = _rId;
@synthesize uImage = _uImage;
@synthesize createdAt = _createdAt;
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
            self.uName = [self objectOrNilForKey:kDBHTopicModelRCommentListUName fromDictionary:dict];
            self.uId = [self objectOrNilForKey:kDBHTopicModelRCommentListUId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kDBHTopicModelRCommentListTitle fromDictionary:dict];
            self.rId = [self objectOrNilForKey:kDBHTopicModelRCommentListRId fromDictionary:dict];
            self.uImage = [self objectOrNilForKey:kDBHTopicModelRCommentListUImage fromDictionary:dict];
            self.createdAt = [self objectOrNilForKey:kDBHTopicModelRCommentListCreatedAt fromDictionary:dict];
            self.image = [self objectOrNilForKey:kDBHTopicModelRCommentListU_image fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.uName forKey:kDBHTopicModelRCommentListUName];
    [mutableDict setValue:self.uId forKey:kDBHTopicModelRCommentListUId];
    [mutableDict setValue:self.title forKey:kDBHTopicModelRCommentListTitle];
    [mutableDict setValue:self.rId forKey:kDBHTopicModelRCommentListRId];
    [mutableDict setValue:self.uImage forKey:kDBHTopicModelRCommentListUImage];
    [mutableDict setValue:self.createdAt forKey:kDBHTopicModelRCommentListCreatedAt];
    [mutableDict setValue:self.image forKey:kDBHTopicModelRCommentListU_image];

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

    self.uName = [aDecoder decodeObjectForKey:kDBHTopicModelRCommentListUName];
    self.uId = [aDecoder decodeObjectForKey:kDBHTopicModelRCommentListUId];
    self.title = [aDecoder decodeObjectForKey:kDBHTopicModelRCommentListTitle];
    self.rId = [aDecoder decodeObjectForKey:kDBHTopicModelRCommentListRId];
    self.uImage = [aDecoder decodeObjectForKey:kDBHTopicModelRCommentListUImage];
    self.createdAt = [aDecoder decodeObjectForKey:kDBHTopicModelRCommentListCreatedAt];
    self.image = [aDecoder decodeObjectForKey:kDBHTopicModelRCommentListU_image];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_uName forKey:kDBHTopicModelRCommentListUName];
    [aCoder encodeObject:_uId forKey:kDBHTopicModelRCommentListUId];
    [aCoder encodeObject:_title forKey:kDBHTopicModelRCommentListTitle];
    [aCoder encodeObject:_rId forKey:kDBHTopicModelRCommentListRId];
    [aCoder encodeObject:_uImage forKey:kDBHTopicModelRCommentListUImage];
    [aCoder encodeObject:_createdAt forKey:kDBHTopicModelRCommentListCreatedAt];
    [aCoder encodeObject:_image forKey:kDBHTopicModelRCommentListU_image];

}

- (id)copyWithZone:(NSZone *)zone
{
    DBHTopicModelRCommentList *copy = [[DBHTopicModelRCommentList alloc] init];
    
    if (copy) {

        copy.uName = [self.uName copyWithZone:zone];
        copy.uId = [self.uId copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.rId = [self.rId copyWithZone:zone];
        copy.uImage = [self.uImage copyWithZone:zone];
        copy.createdAt = [self.createdAt copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];

    }
    
    return copy;
}


@end
