//
//  MapController.m
//  V讯
//
//  Created by XuDong Jin on 14-5-16.
//  Copyright (c) 2014年 jxd. All rights reserved.
//

#import "NavigateController.h"

@interface NavigateController ()

@property (strong, nonatomic) MKUserLocation *annotaion;
@property (strong, nonatomic) CLLocation *userLocation;//用户位置坐标

@end

@implementation NavigateController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"导航";
    
    _locationManager =[[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    if ([[[UIDevice currentDevice] systemVersion] intValue]>=8.0) {
        [_locationManager requestWhenInUseAuthorization];//添加这句
    }
    _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    _mapView.showsUserLocation = NO;
    
    if (!_annotaion) {
        _annotaion = [[MKUserLocation alloc]init];
    }
    
    [self presentLoadingTips:@"定位中……"];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.lat longitude:self.lon];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(_annotaion.coordinate, 2000, 2000);
    MKCoordinateRegion adjustRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustRegion animated:YES];
    
    [geocoder  reverseGeocodeLocation:location completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         CLPlacemark *placeeMark = (CLPlacemark *)placemarks[0];
         _annotaion.title = placeeMark.addressDictionary[@"Name"];
         _annotaion.subtitle = placeeMark.addressDictionary[@"Street"];
         _annotaion.coordinate = location.coordinate;
         [_mapView addAnnotation:_annotaion];
         [self dismissTips];
         MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(_annotaion.coordinate, 2000, 2000);
         MKCoordinateRegion adjustRegion = [_mapView regionThatFits:viewRegion];
         [_mapView setRegion:adjustRegion animated:YES];
     }];
   
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"开始" style:UIBarButtonItemStylePlain target:self action:@selector(navigate)];;
}

#pragma mark - map


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *annotationView=(MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN_ANNOTATION"];
    
    if (!annotationView) {
        annotationView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"PIN_ANNOTATION"];
    }
    annotationView.canShowCallout=YES;//有气泡显示
    annotationView.pinColor = MKPinAnnotationColorRed;//图钉颜色
    annotationView.animatesDrop = YES;//动态得掉下来
    annotationView.draggable = NO;
    return annotationView;
}



#pragma mark -
//导航
- (void)navigate{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否打开系统导航？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
    
}

//打开导航
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:self.lat longitude:self.lon];
        
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:location.coordinate addressDictionary:nil]];
        toLocation.name = self.name;
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    }
}

#pragma mark - other
- (void)viewDidUnload {
	self.mapView.delegate = nil;
	self.mapView = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
