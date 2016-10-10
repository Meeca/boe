//
//  LocationManager.m
//  guyizu
//
//  Created by XuDong Jin on 14-7-20.
//  Copyright (c) 2014年 XuDong Jin. All rights reserved.
//

#import "LocationManager.h"
#import "ZPFLocationTool.h"

@implementation LocationManager

DEF_SINGLETON(LocationManager)
DEF_NOTIFICATION(GotLocation)

- (void)location{
    _locationManager =[[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    if ([[[UIDevice currentDevice] systemVersion] intValue]>=8.0) {
        [_locationManager requestWhenInUseAuthorization];//添加这句
    }
    _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder  reverseGeocodeLocation: newLocation completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         
         //判断是不是属于国内范围
         if (![ZPFLocationTool isLocationOutOfChina:[newLocation coordinate]]) {
             //转换后的coord
             CLLocationCoordinate2D coord = [ZPFLocationTool transformFromWGSToGCJ:[newLocation coordinate]];
             
             //位置一改变就赋值 并发送通知
             if (coord.latitude!=0) {
                 _latitude = coord.latitude;
                 _longitude = coord.longitude;
                 _streetAddress = ((CLPlacemark *)placemarks[0]).name;
                 [self postNotification:self.GotLocation];
             }
         }

         
     }];
    
}

@end
