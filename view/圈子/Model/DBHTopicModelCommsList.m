//
//  DBHTopicModelCommsList.m
//
//  Created by DBH  on 16/9/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DBHTopicModelCommsList.h"
#import "DBHTopicModelRCommentList.h"


NSString *const kDBHTopicModelCommsListCommId = @"comm_id";
NSString *const kDBHTopicModelCommsListUName = @"u_name";
NSString *const kDBHTopicModelCommsListZamNum = @"zam_num";
NSString *const kDBHTopicModelCommsListRCommentList = @"r_comment_list";
NSString *const kDBHTopicModelCommsListCreatedAt = @"created_at";
NSString *const kDBHTopicModelCommsListTitle = @"title";
NSString *const kDBHTopicModelCommsListZamType = @"zam_type";
NSString *const kDBHTopicModelCommsListUId = @"u_id";
NSString *const kDBHTopicModelCommsListUImage = @"u_image";


@interface DBHTopicModelCommsList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DBHTopicModelCommsList

@synthesize commId = _commId;
@synthesize uName = _uName;
@synthesize zamNum = _zamNum;
@synthesize rCommentList = _rCommentList;
@synthesize createdAt = _createdAt;
@synthesize title = _title;
@synthesize zamType = _zamType;
@synthesize uId = _uId;
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
            self.commId = [self objectOrNilForKey:kDBHTopicModelCommsListCommId fromDictionary:dict];
            self.uName = [self objectOrNilForKey:kDBHTopicModelCommsListUName fromDictionary:dict];
            self.zamNum = [self objectOrNilForKey:kDBHTopicModelCommsListZamNum fromDictionary:dict];
    NSObject *receivedDBHTopicModelRCommentList = [dict objectForKey:kDBHTopicModelCommsListRCommentList];
    NSMutableArray *parsedDBHTopicModelRCommentList = [NSMutableArray array];
    if ([receivedDBHTopicModelRCommentList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedDBHTopicModelRCommentList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedDBHTopicModelRCommentList addObject:[DBHTopicModelRCommentList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedDBHTopicModelRCommentList isKindOfClass:[NSDictionary class]]) {
       [parsedDBHTopicModelRCommentList addObject:[DBHTopicModelRCommentList modelObjectWithDictionary:(NSDictionary *)receivedDBHTopicModelRCommentList]];
    }

    self.rCommentList = [NSArray arrayWithArray:parsedDBHTopicModelRCommentList];
            self.createdAt = [self objectOrNilForKey:kDBHTopicModelCommsListCreatedAt fromDictionary:dict];
            self.title = [self objectOrNilForKey:kDBHTopicModelCommsListTitle fromDictionary:dict];
            self.zamType = [self objectOrNilForKey:kDBHTopicModelCommsListZamType fromDictionary:dict];
            self.uId = [self objectOrNilForKey:kDBHTopicModelCommsListUId fromDictionary:dict];
            self.uImage = [self objectOrNilForKey:kDBHTopicModelCommsListUImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.commId forKey:kDBHTopicModelCommsListCommId];
    [mutableDict setValue:self.uName forKey:kDBHTopicModelCommsListUName];
    [mutableDict setValue:self.zamNum forKey:kDBHTopicModelCommsListZamNum];
    NSMutableArray *tempArrayForRCommentList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.rCommentList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRCommentList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRCommentList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRCommentList] forKey:kDBHTopicModelCommsListRCommentList];
    [mutableDict setValue:self.createdAt forKey:kDBHTopicModelCommsListCreatedAt];
    [mutableDict setValue:self.title forKey:kDBHTopicModelCommsListTitle];
    [mutableDict setValue:self.zamType forKey:kDBHTopicModelCommsListZamType];
    [mutableDict setValue:self.uId forKey:kDBHTopicModelCommsListUId];
    [mutableDict setValue:self.uImage forKey:kDBHTopicModelCommsListUImage];

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

    self.commId = [aDecoder decodeObjectForKey:kDBHTopicModelCommsListCommId];
    self.uName = [aDecoder decodeObjectForKey:kDBHTopicModelCommsListUName];
    self.zamNum = [aDecoder decodeObjectForKey:kDBHTopicModelCommsListZamNum];
    self.rCommentList = [aDecoder decodeObjectForKey:kDBHTopicModelCommsListRCommentList];
    self.createdAt = [aDecoder decodeObjectForKey:kDBHTopicModelCommsListCreatedAt];
    self.title = [aDecoder decodeObjectForKey:kDBHTopicModelCommsListTitle];
    self.zamType = [aDecoder decodeObjectForKey:kDBHTopicModelCommsListZamType];
    self.uId = [aDecoder decodeObjectForKey:kDBHTopicModelCommsListUId];
    self.uImage = [aDecoder decodeObjectForKey:kDBHTopicModelCommsListUImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_commId forKey:kDBHTopicModelCommsListCommId];
    [aCoder encodeObject:_uName forKey:kDBHTopicModelCommsListUName];
    [aCoder encodeObject:_zamNum forKey:kDBHTopicModelCommsListZamNum];
    [aCoder encodeObject:_rCommentList forKey:kDBHTopicModelCommsListRCommentList];
    [aCoder encodeObject:_createdAt forKey:kDBHTopicModelCommsListCreatedAt];
    [aCoder encodeObject:_title forKey:kDBHTopicModelCommsListTitle];
    [aCoder encodeObject:_zamType forKey:kDBHTopicModelCommsListZamType];
    [aCoder encodeObject:_uId forKey:kDBHTopicModelCommsListUId];
    [aCoder encodeObject:_uImage forKey:kDBHTopicModelCommsListUImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    DBHTopicModelCommsList *copy = [[DBHTopicModelCommsList alloc] init];
    
    if (copy) {

        copy.commId = [self.commId copyWithZone:zone];
        copy.uName = [self.uName copyWithZone:zone];
        copy.zamNum = [self.zamNum copyWithZone:zone];
        copy.rCommentList = [self.rCommentList copyWithZone:zone];
        copy.createdAt = [self.createdAt copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.zamType = [self.zamType copyWithZone:zone];
        copy.uId = [self.uId copyWithZone:zone];
        copy.uImage = [self.uImage copyWithZone:zone];
    }
    
    return copy;
}


@end
