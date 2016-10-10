//
//  MapController.m
//  V讯
//
//  Created by XuDong Jin on 14-5-16.
//  Copyright (c) 2014年 jxd. All rights reserved.
//

#import "ChooseLocationController.h"

@interface ChooseLocationController ()

@property (strong, nonatomic) MKUserLocation *annotaion;
@property (strong, nonatomic) CLLocation *userLocation;//用户位置坐标
@property (strong, nonatomic) NSMutableArray *placeArr;

@end

@implementation ChooseLocationController

DEF_NOTIFICATION(SELECTEDLOCATION)


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _placeArr = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"地图选取坐标";
    
    self.mapView.showsUserLocation = NO;
    
    _locationManager =[[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    if ([[[UIDevice currentDevice] systemVersion] intValue]>=8.0) {
        [_locationManager requestWhenInUseAuthorization];//添加这句
    }
    _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
    
    if (!_annotaion) {
        _annotaion = [[MKUserLocation alloc]init];
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendMap)];;
}

#pragma mark - map

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //得到当前位置，后刷新tableView
    _userLocation = newLocation;
    
    MKCoordinateSpan span = {0.005,0.005};
    MKCoordinateRegion region = {_userLocation.coordinate,span};
    MKLocalSearchRequest *localSearchRequest = [[MKLocalSearchRequest alloc] init];
    localSearchRequest.region = region;
    localSearchRequest.naturalLanguageQuery = @"hotel";
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:localSearchRequest];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        NSLog(@"the response's count is:%lu",(unsigned long)response.mapItems.count);
        if (error) {
            NSLog(@"error info is：%@",error);
        }else{
            for(MKMapItem *mapitem in response.mapItems)
            {
                MKPointAnnotation *pointk = [[MKPointAnnotation alloc]init];
                pointk.title = mapitem.name;
                MKPlacemark *placemark = mapitem.placemark;
                //获取经纬度
                pointk.coordinate = placemark.location.coordinate;
                pointk.title = placemark.addressDictionary[@"Name"];
                pointk.subtitle = placemark.addressDictionary[@"Street"];
                [_placeArr addObject:placemark];
            }
        }}];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 2000, 2000);
    MKCoordinateRegion adjustRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustRegion animated:YES];
    manager.delegate = nil;
    [manager stopUpdatingLocation];
    
    [self presentLoadingTips:@"定位中……"];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder  reverseGeocodeLocation: newLocation completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         
         _annotaion.title = @"按住拖动选择位置";
         _annotaion.subtitle = ((CLPlacemark *)placemarks[0]).name;
         _annotaion.coordinate = newLocation.coordinate;
         [_locationManager stopUpdatingLocation];
         [_mapView addAnnotation:_annotaion];
         [self dismissTips];
     }];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *annotationView=(MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN_ANNOTATION"];
    
    if (!annotationView) {
        annotationView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"PIN_ANNOTATION"];
    }
    annotationView.canShowCallout=YES;//有气泡显示
    annotationView.pinColor = MKPinAnnotationColorRed;//图钉颜色
    annotationView.animatesDrop = YES;//动态得掉下来
    annotationView.draggable = YES;
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState{
    switch (newState) {
        case MKAnnotationViewDragStateStarting:
            //            NSLog(@"拿起");
            break;
        case MKAnnotationViewDragStateDragging:
            //            NSLog(@"开始拖拽");
            break;
        case MKAnnotationViewDragStateEnding:
            NSLog(@"放下,并将大头针");
        {
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            
            _annotaion = [mapView annotations][0];
            CLLocation *location = [[CLLocation alloc] initWithLatitude:view.annotation.coordinate.latitude longitude:view.annotation.coordinate.longitude];
            [geocoder  reverseGeocodeLocation:location completionHandler:
             ^(NSArray *placemarks, NSError *error) {
                 CLPlacemark *placeeMark = (CLPlacemark *)placemarks[0];
                 _annotaion.title = @"按住拖动选择位置";
                 _annotaion.subtitle = placeeMark.name;
                 _annotaion.coordinate = location.coordinate;
                 
                 MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(_annotaion.coordinate, 2000, 2000);
                 MKCoordinateRegion adjustRegion = [_mapView regionThatFits:viewRegion];
                 [_mapView setRegion:adjustRegion animated:YES];
             }];
        }
            break;
        default:
            break;
    }
}


#pragma mark - sendMap
//以通知的方式发送坐标,
/*
 
//在要接收通知的viewController的viewDidLoad里添加监听语句
[self observeNotification:ChooseLocationController.SELECTEDLOCATION];

//在viewController里添加监听方法，就获取到了坐标
ON_NOTIFICATION3(ChooseLocationController, SELECTEDLOCATION, noti){
    MKUserLocation *location = noti.object;
    NSLog(@"111:%f,%f",location.coordinate.longitude,location.coordinate.latitude);
}
*/
- (void)sendMap{
    
    [self postNotification:self.SELECTEDLOCATION withObject:_annotaion];
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
