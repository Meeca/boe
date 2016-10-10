//
//  DBHRedEnvelopeListModelRList.h
//
//  Created by DBH  on 16/9/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DBHRedEnvelopeListModelRList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nike;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *oId;
@property (nonatomic, strong) NSString *createdAt;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
