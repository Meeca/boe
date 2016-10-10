//
//  UserInfoModel.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/22.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel


#pragma mark-NSCoding

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    
    [aCoder encodeObject:self.collection_num forKey:@"collection_num"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.fans forKey:@"fans"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.nike forKey:@"nike"];
    [aCoder encodeObject:self.tel forKey:@"tel"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    
    
    [aCoder encodeObject:self.uid forKey:@"type"];

    
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self == [super init]) {
        self.collection_num =  [aDecoder decodeObjectForKey:@"collection_num"];
        self.content =  [aDecoder decodeObjectForKey:@"content"];
        self.fans =  [aDecoder decodeObjectForKey:@"fans"];
        self.image =  [aDecoder decodeObjectForKey:@"image"];
        self.nike =  [aDecoder decodeObjectForKey:@"nike"];
        self.tel =  [aDecoder decodeObjectForKey:@"tel"];
        self.token =  [aDecoder decodeObjectForKey:@"token"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        
        
        self.type = [aDecoder decodeObjectForKey:@"type"];
     
    }
    
    return self;
}



@end
