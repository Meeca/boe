//
//  DBHTopicModelRCommentList.h
//
//  Created by DBH  on 16/9/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DBHTopicModelRCommentList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *uName;
@property (nonatomic, strong) NSString *uId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *rId;
@property (nonatomic, strong) NSString *uImage;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *image;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
