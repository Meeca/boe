//
//  MapController.h
//  V讯
//
//  Created by XuDong Jin on 14-5-16.
//  Copyright (c) 2014年 jxd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface NavigateController : UIViewController<CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (assign, nonatomic) double lat;//纬度
@property (assign, nonatomic) double lon;//经度
@property (strong, nonatomic) NSString *name;


@end
