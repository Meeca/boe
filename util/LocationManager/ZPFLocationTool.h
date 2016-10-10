//
//  ZPFLocationTool.h
//  云商通
//
//  Created by XuDong Jin on 15/7/13.
//  Copyright (c) 2015年 zipingfang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ZPFLocationTool : NSObject


//判断是否已经超出中国范围
+ (BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;

//转GCJ-02
+ (CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc;

@end
