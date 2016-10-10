//
//  AreaViewController.h
//  wanhucang
//
//  Created by 郝志宇 on 16/2/22.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *table1;
@property (weak, nonatomic) IBOutlet UITableView *table2;
@property (weak, nonatomic) IBOutlet UITableView *table3;

- (void)selAreaSucc:(void(^)(Provi *selProvi, City *selCity, Area *selArea))block;

@end
