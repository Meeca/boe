//
//  LocationManager.h
//  guyizu
//
//  Created by XuDong Jin on 14-7-20.
//  Copyright (c) 2014年 XuDong Jin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject<CLLocationManagerDelegate>

//单例模式，只要获取到了坐标，全局都可以使用这个坐标
AS_SINGLETON(LocationManager)
AS_NOTIFICATION(GotLocation)

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;

@property (strong, nonatomic) NSString *streetAddress;//地址

//获取坐标
- (void)location;

/*使用方法：
1.
[[LocationManager sharedInstance] location];


 */

@end
