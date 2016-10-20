//
//  AppDelegate.m
//  ZPFramework
//
//  Created by XuDong Jin on 14-6-30.
//  Copyright (c) 2014年 XuDong Jin. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+AliPay.h"
#import "AppDelegate+UMShare.h"
#import "LaunchIntroductionView.h"
#import "AppDelegate+JPush.h"




@implementation AppDelegate {
    UINavigationController *nav;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [self _initView];
    
    [MCNetTool updateBaseUrl:kBaseUrl];
    
    //初始化友盟
    [self initUMeng];
    
    //初始化Beeframework相关
    [self initBeeframework];
    
    //初始化引导图，判断是否第一次启动
    //    [self initGuideViewWithRootController:self.ctrl];
    self.window.rootViewController = self.ctrl;
  
    
    [self initJPushWithApplication:application withOptions:launchOptions];
    
    //开启定位
    [[LocationManager sharedInstance] location];
    
    //启动图显示至少1.5秒
    //    [NSThread sleepForTimeInterval:1.5];
    
    
    [self weiXinRegister];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [LaunchIntroductionView sharedWithImages:@[@"launch0.jpg", @"launch1.jpg", @"launch2.jpg", @"launch3.jpg"] buttonImage:@"" buttonFrame:CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45)];
    return YES;
}

- (void)_initView {
    
    self.ctrl = [[BaseTabBarController alloc] init];
    
    HomeViewController *vc1 = [[HomeViewController alloc] init];
    BaseNavigationController *nav1 = [[BaseNavigationController alloc] initWithRootViewController:vc1];
    
    FindViewController *vc2 = [[FindViewController alloc] init];
    BaseNavigationController *nav2 = [[BaseNavigationController alloc] initWithRootViewController:vc2];
    
    UIViewController *vc3 = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil] instantiateInitialViewController];
    BaseNavigationController *nav3 = (BaseNavigationController *)vc3;
    
    MeViewController *vc4 = [[MeViewController alloc] init];
    BaseNavigationController *nav4 = [[BaseNavigationController alloc] initWithRootViewController:vc4];
    
    self.ctrl.viewControllers = @[nav1, nav2, nav3, nav4];
    
    nav1.tabBarItem.title = @"主页";
    nav2.tabBarItem.title = @"发现";
    nav3.tabBarItem.title = @"圈子";
    nav4.tabBarItem.title = @"我";
    
    nav1.tabBarItem.image = [UIImage imageNamed:@"B-2"];
    nav2.tabBarItem.image = [UIImage imageNamed:@"B-4"];
    nav3.tabBarItem.image = [UIImage imageNamed:@"B-6"];
    nav4.tabBarItem.image = [UIImage imageNamed:@"B-8"];
}



//初始化引导图
- (void)initGuideViewWithRootController:(UITabBarController *)vc {
    
    self.window.rootViewController = vc;
    return;
    
    //增加标识，用于判断是否是第一次启动应用
    
    NSString *key = @"CFBundleShortVersionString";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 获取沙盒中版本号
    NSString *lastVersion = [defaults stringForKey:key];//[defaults stringForKey:@"s"];
    
    // 获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if (![lastVersion isEqualToString:currentVersion]) {
        [defaults setValue:currentVersion forKey:key];
        [defaults synchronize];
        
        // Init the pages texts, and pictures.
        ICETutorialPage *layer1 = [[ICETutorialPage alloc] initWithTitle:@""
                                                                subTitle:@""
                                                             pictureName:@"tutorial_background_00@2x.jpg"
                                                                duration:3.0];
        ICETutorialPage *layer2 = [[ICETutorialPage alloc] initWithTitle:@""
                                                                subTitle:@""
                                                             pictureName:@"tutorial_background_01@2x.jpg"
                                                                duration:3.0];
        ICETutorialPage *layer3 = [[ICETutorialPage alloc] initWithTitle:@""
                                                                subTitle:@""
                                                             pictureName:@"tutorial_background_02@2x.jpg"
                                                                duration:3.0];
        ICETutorialPage *layer4 = [[ICETutorialPage alloc] initWithTitle:@""
                                                                subTitle:@""
                                                             pictureName:@"tutorial_background_03@2x.jpg"
                                                                duration:3.0];
        ICETutorialPage *layer5 = [[ICETutorialPage alloc] initWithTitle:@""
                                                                subTitle:@""
                                                             pictureName:@"tutorial_background_04@2x.jpg"
                                                                duration:3.0];
        
        NSArray *tutorialLayers = @[layer1,layer2,layer3,layer4,layer5];
        
        // Set the common style for the title.
        ICETutorialLabelStyle *titleStyle = [[ICETutorialLabelStyle alloc] init];
        [titleStyle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17.0f]];
        [titleStyle setTextColor:[UIColor whiteColor]];
        [titleStyle setLinesNumber:1];
        [titleStyle setOffset:180];
        [[ICETutorialStyle sharedInstance] setTitleStyle:titleStyle];
        
        // Set the subTitles style with few properties and let the others by default.
        [[ICETutorialStyle sharedInstance] setSubTitleColor:[UIColor whiteColor]];
        [[ICETutorialStyle sharedInstance] setSubTitleOffset:150];
        
        // Init tutorial.
        guideViewController = [[ICETutorialController alloc] initWithPages:tutorialLayers
                                                                  delegate:self];
        guideViewController.autoScrollEnabled = NO;
        
        // Run it.
        [guideViewController startScrolling];
        
        self.window.rootViewController = guideViewController;
        
    } else {
        
        self.window.rootViewController = vc;
    }
}


- (void)initBeeframework {
    // 配置提示框
    //[self presentLoadingTips:@"加载中"];
    //[self presentMessageTips:@"加载成功"];
    [BeeUITipsCenter setDefaultContainerView:self.window];
    [BeeUITipsCenter setDefaultBubble:[UIImage imageNamed:@"alertBox.png"]];
    [BeeUITipsCenter setDefaultMessageIcon:[UIImage imageNamed:@"icon.png"]];
    [BeeUITipsCenter setDefaultSuccessIcon:[UIImage imageNamed:@"icon.png"]];
    [BeeUITipsCenter setDefaultFailureIcon:[UIImage imageNamed:@"icon.png"]];
    
    //关闭log
    [BeeLogger sharedInstance].enabled = NO;
    [ServerConfig sharedInstance].config = 0;
}

#pragma mark - ICETutorialController delegate
- (void)tutorialController:(ICETutorialController *)tutorialController scrollingFromPageIndex:(NSUInteger)fromIndex toPageIndex:(NSUInteger)toIndex {
    NSLog(@"Scrolling from page %lu to page %lu.", (unsigned long)fromIndex, (unsigned long)toIndex);
}

- (void)tutorialControllerDidReachLastPage:(ICETutorialController *)tutorialController {
    NSLog(@"Tutorial reached the last page.");
}

- (void)tutorialController:(ICETutorialController *)tutorialController didClickOnLeftButton:(UIButton *)sender {
    NSLog(@"Button 1 pressed.");
}

- (void)tutorialController:(ICETutorialController *)tutorialController didClickOnRightButton:(UIButton *)sender {
    NSLog(@"Button 2 pressed.");
    NSLog(@"Auto-scrolling stopped.");
    
    [guideViewController stopScrolling];
    self.window.rootViewController = self.ctrl;
}


// ------------------------------------------------------
/*
 由于用到支付宝所以这个方法放在 appdelegate 里)
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    [self aLiPayWithApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    
    BOOL isYes = [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    [self UMengActionWithUrl:url];
    return isYes;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}




//------------------------------------------------------

//////////////////////////////////////////////////////////////////////////////////////////
//另加代码

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if(!result){
        //处理其他openrul
        return [self aLiPayWithApplication:app openURL:url sourceApplication:nil annotation:nil];
    }
    return result;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}


@end
