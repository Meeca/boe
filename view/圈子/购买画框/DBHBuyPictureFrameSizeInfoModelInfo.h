//
//  DBHBuyPictureFrameSizeInfoModelInfo.h
//
//  Created by DBH  on 16/9/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DBHBuyPictureFrameSizeInfoModelInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *sock;
@property (nonatomic, strong) NSString *aId;
@property (nonatomic, strong) NSString *price;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
