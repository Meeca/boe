//
//  CircleMembersTableViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/25.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CircleMembersTableViewController;
@protocol PickerViewControllerDelegate <NSObject>

- (void)contactsPickerViewControllerDidFinish:(CircleMembersTableViewController *)controller withSelectedContacts:(NSArray *)contacts;

@end


@interface CircleMembersTableViewController : UIViewController

@property (nonatomic, strong) NSSet* selectedContactIds;
@property (nonatomic, strong) NSSet* disabledContactIds;
@property (nonatomic, strong) id<PickerViewControllerDelegate>delegate;

@property (nonatomic, strong) NSString *cID;


@end
