//
//  AreaViewController.m
//  wanhucang
//
//  Created by 郝志宇 on 16/2/22.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "AreaViewController.h"

@interface AreaViewController () <UITableViewDelegate, UITableViewDataSource> {
    UserModel *userModel;
    
    Provi *selProvi;
    City *selCity;
    Area *selArea;
}

@property (strong, nonatomic) NSArray *provis;
@property (strong, nonatomic) NSArray *citys;
@property (strong, nonatomic) NSArray *areas;
@property (copy, nonatomic) void(^block)(Provi *selProvi, City *selCity, Area *selArea);

@end

@implementation AreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"选择区域";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(back)];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    userModel = [UserModel modelWithObserver:self];
    [userModel getProvi];
    
    self.table1.frame = CGRectMake(0, 0, KSCREENWIDTH/3, KSCREENHEIGHT-64);
    self.table2.frame = CGRectMake(KSCREENWIDTH/3, 0, KSCREENWIDTH/3, KSCREENHEIGHT-64);
    self.table3.frame = CGRectMake(KSCREENWIDTH/3*2, 0, KSCREENWIDTH/3, KSCREENHEIGHT-64);
    
    self.table1.separatorInset = UIEdgeInsetsMake(0, self.table1.width, 0, 0);
    self.table2.separatorInset = UIEdgeInsetsMake(0, self.table2.width, 0, 0);
    self.table3.separatorInset = UIEdgeInsetsMake(0, self.table3.width, 0, 0);
    
    self.table1.backgroundColor = RGB(222, 222, 222);
    self.table2.backgroundColor = RGB(232, 232, 232);
    self.table2.backgroundColor = RGB(242, 242, 242);
}

ON_SIGNAL3(UserModel, PROVIINFO, signal) {
    self.provis = signal.object;
    [self.table1 reloadData];
}

ON_SIGNAL3(UserModel, CITYINFO, signal) {
    self.citys = signal.object;
    [self.table2 reloadData];
}

ON_SIGNAL3(UserModel, AREAINFO, signal) {
    self.areas = signal.object;
    [self.table3 reloadData];
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.table1) {
        return self.provis.count;
    }
    if (tableView == self.table2) {
        return self.citys.count;
    }
    if (tableView == self.table3) {
        return self.areas.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = tableView.backgroundColor;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    if (tableView == self.table1) {
        Provi *provi = self.provis[indexPath.row];
        cell.textLabel.text = provi.title;
    }
    if (tableView == self.table2) {
        City *city = self.citys[indexPath.row];
        cell.textLabel.text = city.title;
    }
    if (tableView == self.table3) {
        Area *area = self.areas[indexPath.row];
        cell.textLabel.text = area.title;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.table1) {
        Provi *provi = self.provis[indexPath.row];
        selProvi = provi;
        
        self.citys = nil;
        self.areas = nil;
        selCity = nil;
        selArea = nil;
        
        [self.table2 reloadData];
        [self.table3 reloadData];
        
        [userModel getCityWithProviId:provi.sheng_id];
    }
    if (tableView == self.table2) {
        City *city = self.citys[indexPath.row];
        selCity = city;
        
        self.areas = nil;
        selArea = nil;
        
        self.table3.hidden = NO;
        [self.table3 reloadData];
        
        [userModel getAreaWithCityId:city.shi_id];
    }
    if (tableView == self.table3) {
        Area *area = self.areas[indexPath.row];
        selArea = area;
        
        _block(selProvi, selCity, selArea);
        
        [self back];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)selAreaSucc:(void(^)(Provi *selProvi, City *selCity, Area *selArea))block {
    self.block = block;
}

- (void)back {
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
