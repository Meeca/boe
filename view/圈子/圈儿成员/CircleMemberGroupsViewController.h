//
//  CircleMemberGroupsViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/4.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CircleMemberGroupsViewController;

@protocol PickerViewControllerDelegate <NSObject>

- (void)contactsPickerViewControllerDidFinish:(CircleMemberGroupsViewController *)controller withSelectedContacts:(NSArray *)contacts;

@end
@interface CircleMemberGroupsViewController : UIViewController
@property (nonatomic, strong) NSSet* selectedContactIds;
@property (weak, nonatomic) IBOutlet UICollectionView *contactsPickerView;
@property (nonatomic, strong) NSSet* disabledContactIds;

@property(nonatomic, strong)NSString *cID;

@property(nonatomic, strong)NSString *userId;
@property (nonatomic, strong) id<PickerViewControllerDelegate>delegate;
@end
