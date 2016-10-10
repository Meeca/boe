//
//  DBHTopicModelCommsList.h
//
//  Created by DBH  on 16/9/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DBHTopicModelCommsList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *commId;
@property (nonatomic, strong) NSString *uName;
@property (nonatomic, strong) NSString *zamNum;
@property (nonatomic, strong) NSArray *rCommentList;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *zamType;
@property (nonatomic, strong) NSString *uId;
@property (nonatomic, strong) NSString *uImage;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
