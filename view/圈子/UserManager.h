//
//  UserManager.h
//  PrettyFactoryProject
//
//  Created by mac on 16/6/14.
//  Copyright © 2016年 fhj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface UserManager : NSObject

+ (void)archiverModel:(UserInfoModel *)model;

+ (UserInfoModel * )readModel;


@end
