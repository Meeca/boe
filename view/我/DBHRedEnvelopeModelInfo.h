//
//  DBHRedEnvelopeModelInfo.h
//
//  Created by DBH  on 16/9/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DBHRedEnvelopeModelInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nike;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *price;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
