//
//  DBHRedEnvelopeListModelInfo.h
//
//  Created by DBH  on 16/9/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DBHRedEnvelopeListModelInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *rList;
@property (nonatomic, strong) NSString *uId;
@property (nonatomic, strong) NSString *uNike;
@property (nonatomic, strong) NSString *allprice;
@property (nonatomic, strong) NSString *uImage;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
