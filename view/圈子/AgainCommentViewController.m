//
//  AgainCommentViewController.m
//  jingdongfang
//
//  Created by mac on 16/10/27.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "AgainCommentViewController.h"
#import "MCTextView.h"
#import "UIViewController+XHPhoto.h"

@interface AgainCommentViewController (){


    NSString * _imageUrl;

}
@property (weak, nonatomic) IBOutlet MCTextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *addImageBtn;
@property (weak, nonatomic) IBOutlet UIView *desView;


@end

@implementation AgainCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评论";

    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    right.frame = CGRectMake(0, 0, 50, 50);
    [right setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    //    [right setImage:[UIImage imageNamed:@"C-11-3"] forState:UIControlStateNormal];
    [right setTitle:[NSString stringWithFormat:@"发布"] forState:UIControlStateNormal];
    [right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(addCircle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _textView.placeholder = @"你想说些什么呢";

    // Do any additional setup after loading the view from its nib.
}

- (IBAction)addImageBtn:(id)sender {
    
    [self showCanEdit:NO photo:^(UIImage *photo, NSData *imageData) {
        
        [_addImageBtn setBackgroundImage:photo forState:UIControlStateNormal];
        
        
        
        NSString *path = @"/app.php/User/image_add";
         NSDictionary *params = @{
                                 @"image":photo,
                                  };

        [MCNetTool uploadDataWithURLStr:path withDic:params imageKey:@"image" withData:imageData uploadProgress:^(NSString *progress) {
            
            [self showProgress:[progress floatValue]];
            
        } success:^(NSDictionary *requestDic, NSString *msg) {
            
            
            _imageUrl = requestDic[@"image_url"];
            
            _desView.hidden = YES;
            

        } failure:^(NSString *error) {
            
        }];
        
        
    }];
    

    
}


- (void)addCircle:(UIButton *)btn{

    [self loadNetData];

}


#pragma mark------- 加载网络
- (void)loadNetData
{
    if (_textView.text.length == 0) {
        [self showErrorText:@"请输入评论内容"];
        return;
    }
    
    
    
    NSString *path = @"/app.php/Circles/comm_add";
    
    NSMutableDictionary * params = [NSMutableDictionary new];
    params[@"uid"] = kUserId;
    params[@"co_id"] = self.coId;
    params[@"title"] = self.textView.text;
     params[@"image"] = _imageUrl;
    
    [MCNetTool postWithUrl:path params:params hud:YES
                   success:^(NSDictionary *requestDic, NSString *msg)
     {
         [self showToastWithMessage:msg];
         [self.navigationController popViewControllerAnimated:YES];
         
     } fail:^(NSString *error) {
         
         
         
     }];
    
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
