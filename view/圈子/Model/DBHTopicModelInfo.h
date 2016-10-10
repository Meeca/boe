//
//  DBHTopicModelInfo.h
//
//  Created by DBH  on 16/9/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DBHTopicModelInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *commsList;
@property (nonatomic, strong) NSString *uImage;
@property (nonatomic, strong) NSString *cZamNum;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *coId;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *cZamType;
@property (nonatomic, strong) NSString *gagIt;
@property (nonatomic, strong) NSString *uId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *content;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
