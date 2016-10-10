//
//  MapController.h
//  V讯
//
//  Created by XuDong Jin on 14-5-16.
//  Copyright (c) 2014年 jxd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ChooseLocationController : UIViewController<CLLocationManagerDelegate>

//将坐标以通知的方式发送
AS_NOTIFICATION(SELECTEDLOCATION)

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;


@end
