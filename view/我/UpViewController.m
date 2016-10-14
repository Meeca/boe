//
//  UpViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/1.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "UpViewController.h"
#import "IWTextView.h"
#import "DecimalField.h"
#import "BaseModel.h"
#import "TiCaiCell.h"
#import "UpDataViewController.h"
#import "DuoTuViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define nameTag             512
#define collectPriceTag     522
#define collectKucTag       532
#define openPriceTag        542
#define openKucTag          552

#define contextTag          562
#define biaoQianTag         572

@interface UpViewController () <UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource> {
    UIImageView *imageView;
    BOOL isPublic;  // 是否公开
    NSString *sales_status;  //  售卖状态
    BOOL isOpen;  //  公开价格

    NSString *publicName;   //  作品名
    NSString *publicContext;  //  作品描述
    NSString *defName;   //  私密时的默认作品名
    NSString *defContext;  //  私密时的默认作品描述
    
    NSArray *classArr;  //  所有类别
    NSInteger classIndex;  //  类别索引
    
    NSMutableArray *yearArr;  //  所有年代
    NSInteger yearIndex;   // 年索引
    
    NSArray *ticaiArr;  //  所有题材
    NSMutableArray *ticaiSelArr;  //  多选
    NSMutableArray *selIndexArr;  //  选中的索引数组
    
    NSString *biaoQian;  // 标签
    
    NSString *collectPrice;  // 收藏价
    NSString *collectKuc;   //  收藏量
    
    NSString *openPrice;   //  公开价
    NSString *openKuc;   //   公开量
    
    BaseModel *model;
    
    UIPickerView *picker;
    
    CGFloat ticaiheight;
    CGFloat duotuheight;
    UICollectionView *ticaiView;
    UICollectionView *imgsCollectView;
    NSMutableArray *imgsArr;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *table;

@property (nonatomic, copy) NSString *year;

@end

@implementation UpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"上传作品";
    sales_status = @"1";
    classIndex = -1;
    model = [BaseModel modelWithObserver:self];
    
    [[UserModel sharedInstance] loadCache];
    defName = [NSString stringWithFormat:@"%@的作品", kNike.length>0?kNike:@""];
    defContext = [NSString stringWithFormat:@"%@的作品简介", kNike.length>0?kNike:@""];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChange:) name:UITextViewTextDidChangeNotification object:nil];
    
    self.table.backgroundColor = RGB(234, 234, 234);
    imgsArr = [NSMutableArray array];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENWIDTH*1080/1920)];
    header.backgroundColor = [UIColor grayColor];
    imageView = [[UIImageView alloc] initWithFrame:header.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [header addSubview:imageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 70, 30);
    [header addSubview:btn];
    btn.right = header.width - 15;
    btn.bottom = header.height - 10;
    
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    btn.layer.borderWidth = 1;
    [btn setTitle:@"更换图片" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn addTarget:self action:@selector(changePhoto:) forControlEvents:UIControlEventTouchUpInside];
    
    self.table.tableHeaderView = header;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 90)];
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
//    sure.layer.cornerRadius = 3.f;
//    sure.layer.masksToBounds = YES;
    sure.backgroundColor = KAPPCOLOR;
    sure.frame = CGRectMake(0, 15, KSCALE(1100), 45);
    sure.titleLabel.font = [UIFont systemFontOfSize:16];
    [sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sure setTitle:@"提 交" forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    sure.centerX = footer.width/2;
    [footer addSubview:sure];
    
    self.table.tableFooterView = footer;
    
    [self loadModel];
    [self getYears];
}

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
    }
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    [win dismissTips];
    imageView.image = image;
}

- (void)getYears {
    NSDate *date = [NSDate date];
    NSString *current = [Tool stringFromDate:date withFormatter:@"yyyy"];
    yearArr = [NSMutableArray array];
    for (int i=0; i<20; i++) {
        NSString *s = [NSString stringWithFormat:@"%@", @(([current integerValue]-i))];
        [yearArr addObject:s];
    }
    [self.table reloadData];
}

ON_SIGNAL3(BaseModel, CLASSLIST, signal) {
    classArr = signal.object;
}

ON_SIGNAL3(BaseModel, THEMELIST, signal) {
    ticaiArr = signal.object;
    ticaiSelArr = [NSMutableArray array];
    for (int i=0; i<ticaiArr.count; i++) {
        [ticaiSelArr addObject:@(NO)];
    }
}

ON_SIGNAL3(BaseModel, WORKSADD, signal) {
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    [win presentMessageTips:@"上传成功"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATASUCC object:@(isPublic)];
    
    [Tool performBlock:^{
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    } afterDelay:1];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (isPublic) {
        return 8;
//        return 7;  // 没有细节图
    } else {
        return 3;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    } else if (section==1) {
        return 1;
    } else if (section==2) {
        return 2;
    } else if (section==3) {
        return 1;
    } else if (section==4) {
        return 4;
    } else if (section==5) {
        return 2;
    } else if (section==6) {
        return 4;
    } else if (section==7) {
        return 2;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    CGFloat x = cell.separatorInset.left;
    
    if (indexPath.section==0) {
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, KSCREENWIDTH-2*x, 50)];
        field.placeholder = @" 作品名称";
        if (isPublic) {
            field.text = publicName;
        } else {
            field.text = defName;
        }
        field.borderStyle = UITextBorderStyleNone;
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        field.font = cell.textLabel.font;
        field.tag = nameTag;
        [field addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        
        [cell.contentView addSubview:field];
    } else if (indexPath.section==1) {
        IWTextView *field = [[IWTextView alloc] initWithFrame:CGRectMake(x, 0, KSCREENWIDTH-2*x, 70)];
        field.placeholder = @"输入作品描述";
        if (isPublic) {
            field.text = publicContext;
        } else {
            field.text = defContext;
        }
        field.tag = contextTag;
        field.font = cell.textLabel.font;
        
        [cell.contentView addSubview:field];
    } else if (indexPath.section==2) {
        if (indexPath.row==0) {
            UIButton *public = [UIButton buttonWithType:UIButtonTypeCustom];
            public.frame = CGRectMake(x, 0, 80, 50);
            public.titleLabel.font = cell.textLabel.font;
            [public setTitle:@"公开" forState:UIControlStateNormal];
            [public setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            public.tag = 555;
            [public addTarget:self action:@selector(state:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:public];
            
            UIButton *private = [UIButton buttonWithType:UIButtonTypeCustom];
            private.frame = CGRectMake(public.right+40, 0, 80, 50);
            private.titleLabel.font = cell.textLabel.font;
            [private setTitle:@"私密" forState:UIControlStateNormal];
            [private setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            private.tag = 666;
            [private addTarget:self action:@selector(state:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:private];
            if (isPublic) {
                [public setImage:[UIImage imageNamed:@"未标题-1-2"] forState:UIControlStateNormal];
                [private setImage:[UIImage imageNamed:@"未标题-1-1"] forState:UIControlStateNormal];
            } else {
                [public setImage:[UIImage imageNamed:@"未标题-1-1"] forState:UIControlStateNormal];
                [private setImage:[UIImage imageNamed:@"未标题-1-2"] forState:UIControlStateNormal];
            }
            [public setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 6)];
            [private setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 6)];
        } else if (indexPath.row==1) {
            cell.textLabel.textColor = [UIColor lightGrayColor];
            if (isPublic) {
                cell.textLabel.text = @"审核通过后可公开及售卖";
            } else {
                cell.textLabel.text = @"无需审核仅供自己欣赏";
            }
            
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, KSCREENWIDTH-x-x, .5)];
            line.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:line];
        }
    } else if (indexPath.section==3) {
        cell.textLabel.text = @"类别";
        cell.detailTextLabel.text = @"请选择类别";
        if (classIndex>=0) {
            ClassList *list = classArr[classIndex];
            cell.detailTextLabel.text = list.title.length>0 ? list.title : @"";
        }
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"B-17-1"]];
        imgView.contentMode = UIViewContentModeRight;
        imgView.frame = CGRectMake(0, 0, 30, 30);
        cell.accessoryView = imgView;
    } else if (indexPath.section==4) {
        if (indexPath.row==0) {
            cell.textLabel.text = @"创作年代";
//            if (yearIndex>=0) {
//                cell.detailTextLabel.text = yearArr[yearIndex];
//            }
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"B-17-1"]];
            imgView.contentMode = UIViewContentModeRight;
            imgView.frame = CGRectMake(0, 0, 30, 30);
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
            UILabel *yearLabel = [[UILabel alloc]init];
            yearLabel.font = [UIFont systemFontOfSize:14];
            yearLabel.textColor = [UIColor blackColor];
            yearLabel.text = @"年";
            [yearLabel sizeToFit];
            
            yearLabel.right = view.right;
            yearLabel.centerY = view.centerY;
            
            UITextField *textfield = [[UITextField alloc]init];
            textfield.width = yearLabel.left;
            textfield.height = view.height - 1;
            textfield.centerY = view.centerY;
            textfield.borderStyle = UITextBorderStyleRoundedRect;
            textfield.placeholder = @"手动输入年份";
            textfield.font = [UIFont systemFontOfSize:14];
            textfield.textColor = [UIColor blackColor];
             [textfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
            textfield.tag = 10001;
            
            textfield.text = self.year;
            
            [view addSubview:textfield];
            [view addSubview:yearLabel];
            
            cell.accessoryView = view;
        } else if (indexPath.row==1) {
            cell.backgroundColor = tableView.backgroundColor;
            
            cell.textLabel.text = @"作品题材：多选";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:cell.textLabel.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(5, 2)];
            cell.textLabel.attributedText = str;
        } else if (indexPath.row==2) {
            cell.backgroundColor = tableView.backgroundColor;
            cell.clipsToBounds = YES;
            
            if (!ticaiView) {
                UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
                layout.itemSize = CGSizeMake((KSCREENWIDTH-91)/4, (KSCREENWIDTH-91)/8);
                layout.minimumLineSpacing = 15;
                layout.minimumInteritemSpacing = 20;
                ticaiView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 0) collectionViewLayout:layout];
                ticaiView.delegate = self;
                ticaiView.backgroundColor = tableView.backgroundColor;
                ticaiView.dataSource = self;
                [ticaiView registerClass:[TiCaiCell class] forCellWithReuseIdentifier:@"ticai"];
            }
            [cell.contentView addSubview:ticaiView];
            
            [ticaiView reloadData];
            [Tool performBlock:^{
                CGSize size = ticaiView.contentSize;
                if (ticaiheight != size.height) {
                    ticaiView.height = size.height;
                    ticaiheight = size.height;
                    [tableView reloadData];
                }
            } afterDelay:.1];
        } else if (indexPath.row==3) {
            IWTextView *field = [[IWTextView alloc] initWithFrame:CGRectMake(x, 0, KSCREENWIDTH-2*x, 70)];
            field.placeholder = @"标签：最多输入5个，用空格隔开";
            field.text = biaoQian;
            field.tag = biaoQianTag;
            field.font = cell.textLabel.font;
            
            [cell.contentView addSubview:field];
        }
    } else if (indexPath.section==5) {
        if (indexPath.row==0) {
            cell.textLabel.text = @"电子版收藏：选填";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:cell.textLabel.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(6, 2)];
            cell.textLabel.attributedText = str;
        } else if (indexPath.row==1) {
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
            label1.font = cell.textLabel.font;
            label1.text = @"￥";
            [cell.contentView addSubview:label1];
            [label1 sizeToFit];
            label1.x = x;
            
            DecimalField *price = [[DecimalField alloc] initWithFrame:CGRectMake(label1.right+5, 0, (KSCREENWIDTH-130)/2, 33)];
            price.borderStyle = UITextBorderStyleRoundedRect;
            price.clearButtonMode = UITextFieldViewModeWhileEditing;
            price.font = cell.textLabel.font;
            price.placeholder = @"价格";
            price.text = collectPrice;
            price.tag = collectPriceTag;
            price.layer.borderWidth = .5;
            price.layer.cornerRadius = 3;
            price.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [cell.contentView addSubview:price];
            [price addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
            label1.centerY = price.centerY;
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
            label2.font = cell.textLabel.font;
            label2.text = @"元";
            [cell.contentView addSubview:label2];
            [label2 sizeToFit];
            label2.x = price.right+5;
            label2.centerY = price.centerY;
            
            DecimalField *kuc = [[DecimalField alloc] initWithFrame:CGRectMake(label2.right+15, 0, price.width, price.height)];
            kuc.borderStyle = UITextBorderStyleRoundedRect;
            kuc.clearButtonMode = UITextFieldViewModeWhileEditing;
            kuc.font = cell.textLabel.font;
            kuc.placeholder = @"库存量";
            kuc.text = collectKuc;
            kuc.tag = collectKucTag;
            kuc.layer.borderWidth = .5;
            kuc.layer.cornerRadius = 3;
            kuc.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [cell.contentView addSubview:kuc];
            [kuc addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
            kuc.centerY = price.centerY;
            
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectZero];
            label3.font = cell.textLabel.font;
            label3.text = @"个";
            [cell.contentView addSubview:label3];
            [label3 sizeToFit];
            label3.x = kuc.right+5;
            label3.centerY = price.centerY;
        }
    } else if (indexPath.section==6) {
        if (indexPath.row==0) {
            cell.textLabel.text = @"真品：";
        } else if (indexPath.row==1) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = cell.textLabel.font;
            label.text = @"是否出售：";
            [cell.contentView addSubview:label];
            [label sizeToFit];
            label.x = x;
            label.centerY = 50/2;
            
            UIButton *notForSale = [UIButton buttonWithType:UIButtonTypeCustom];
            notForSale.frame = CGRectMake(label.right+5, 0, 80, 50);
            notForSale.titleLabel.font = cell.textLabel.font;
            [notForSale setTitle:@"非卖品" forState:UIControlStateNormal];
            [notForSale setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            notForSale.tag = 101;
            [notForSale addTarget:self action:@selector(state:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:notForSale];
            
            UIButton *sale = [UIButton buttonWithType:UIButtonTypeCustom];
            sale.frame = CGRectMake(notForSale.right+10, 0, 60, 50);
            sale.titleLabel.font = cell.textLabel.font;
            [sale setTitle:@"出售" forState:UIControlStateNormal];
            [sale setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            sale.tag = 102;
            [sale addTarget:self action:@selector(state:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:sale];
            
            UIButton *outOfStock = [UIButton buttonWithType:UIButtonTypeCustom];
            outOfStock.frame = CGRectMake(sale.right+10, 0, 60, 50);
            outOfStock.titleLabel.font = cell.textLabel.font;
            [outOfStock setTitle:@"已售" forState:UIControlStateNormal];
            [outOfStock setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            outOfStock.tag = 103;
            [outOfStock addTarget:self action:@selector(state:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:outOfStock];
            
            if ([sales_status integerValue]==1) {
                [notForSale setImage:[UIImage imageNamed:@"未标题-1-2"] forState:UIControlStateNormal];
                [sale setImage:[UIImage imageNamed:@"未标题-1-1"] forState:UIControlStateNormal];
                [outOfStock setImage:[UIImage imageNamed:@"未标题-1-1"] forState:UIControlStateNormal];
            } else if ([sales_status integerValue]==2) {
                [notForSale setImage:[UIImage imageNamed:@"未标题-1-1"] forState:UIControlStateNormal];
                [sale setImage:[UIImage imageNamed:@"未标题-1-2"] forState:UIControlStateNormal];
                [outOfStock setImage:[UIImage imageNamed:@"未标题-1-1"] forState:UIControlStateNormal];
            } else if ([sales_status integerValue]==3) {
                [notForSale setImage:[UIImage imageNamed:@"未标题-1-1"] forState:UIControlStateNormal];
                [sale setImage:[UIImage imageNamed:@"未标题-1-1"] forState:UIControlStateNormal];
                [outOfStock setImage:[UIImage imageNamed:@"未标题-1-2"] forState:UIControlStateNormal];
            }
            [notForSale setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 6)];
            [sale setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 6)];
            [outOfStock setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 6)];
        } else if (indexPath.row==2) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = cell.textLabel.font;
            label.text = @"是否公开价格：";
            [cell.contentView addSubview:label];
            [label sizeToFit];
            label.x = x;
            label.centerY = 50/2;
            
            UIButton *yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            yesBtn.frame = CGRectMake(label.right+5, 0, 80, 50);
            yesBtn.titleLabel.font = cell.textLabel.font;
            [yesBtn setTitle:@"是" forState:UIControlStateNormal];
            [yesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            yesBtn.tag = 111;
            [yesBtn addTarget:self action:@selector(state:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:yesBtn];
            
            UIButton *noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            noBtn.frame = CGRectMake(yesBtn.right+15, 0, 80, 50);
            noBtn.titleLabel.font = cell.textLabel.font;
            [noBtn setTitle:@"否" forState:UIControlStateNormal];
            [noBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            noBtn.tag = 112;
            [noBtn addTarget:self action:@selector(state:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:noBtn];
            
            if (isOpen) {
                [yesBtn setImage:[UIImage imageNamed:@"未标题-1-2"] forState:UIControlStateNormal];
                [noBtn setImage:[UIImage imageNamed:@"未标题-1-1"] forState:UIControlStateNormal];
            } else {
                [yesBtn setImage:[UIImage imageNamed:@"未标题-1-1"] forState:UIControlStateNormal];
                [noBtn setImage:[UIImage imageNamed:@"未标题-1-2"] forState:UIControlStateNormal];
            }
            [yesBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 6)];
            [noBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 6)];
        } else if (indexPath.row==3) {
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
            label1.font = cell.textLabel.font;
            label1.text = @"￥";
            [cell.contentView addSubview:label1];
            [label1 sizeToFit];
            label1.x = x;
            
            DecimalField *price = [[DecimalField alloc] initWithFrame:CGRectMake(label1.right+5, 0, (KSCREENWIDTH-130)/2, 33)];
            price.borderStyle = UITextBorderStyleRoundedRect;
            price.clearButtonMode = UITextFieldViewModeWhileEditing;
            price.font = cell.textLabel.font;
            price.placeholder = @"单价";
            price.text = openPrice;
            price.tag = openPriceTag;
            price.layer.borderWidth = .5;
            price.layer.cornerRadius = 3;
            price.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [cell.contentView addSubview:price];
            [price addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
            label1.centerY = price.centerY;
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
            label2.font = cell.textLabel.font;
            label2.text = @"元";
            [cell.contentView addSubview:label2];
            [label2 sizeToFit];
            label2.x = price.right+5;
            label2.centerY = price.centerY;
            
            DecimalField *kuc = [[DecimalField alloc] initWithFrame:CGRectMake(label2.right+15, 0, price.width, price.height)];
            kuc.borderStyle = UITextBorderStyleRoundedRect;
            kuc.clearButtonMode = UITextFieldViewModeWhileEditing;
            kuc.font = cell.textLabel.font;
            kuc.placeholder = @"库存量";
            kuc.text = openKuc;
            kuc.tag = openKucTag;
            kuc.layer.borderWidth = .5;
            kuc.layer.cornerRadius = 3;
            kuc.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [cell.contentView addSubview:kuc];
            [kuc addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
            kuc.centerY = price.centerY;
            
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectZero];
            label3.font = cell.textLabel.font;
            label3.text = @"个";
            [cell.contentView addSubview:label3];
            [label3 sizeToFit];
            label3.x = kuc.right+5;
            label3.centerY = price.centerY;
        }
    } else if (indexPath.section==7) {
        if (indexPath.row==0) {
            UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
            add.frame = CGRectMake(x, 10, 150, 30);
            add.titleLabel.font = cell.textLabel.font;
            [add setTitle:@"＋ 添加作品细节图" forState:UIControlStateNormal];
            [add setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [add setImage:[UIImage imageNamed:@"C-11-3"] forState:UIControlStateNormal];
            [add addTarget:self action:@selector(addPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:add];
            add.layer.borderWidth = 1;
            add.layer.cornerRadius = 5;
            add.layer.borderColor = [UIColor grayColor].CGColor;

//            [add setImageEdgeInsets:UIEdgeInsetsMake(0, -3, 0, 3)];
//            [add setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, -3)];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = cell.textLabel.font;
            label.text = [NSString stringWithFormat:@"%@张/最多9张", @(imgsArr.count)];
            [cell.contentView addSubview:label];
            [label sizeToFit];
            label.right = KSCREENWIDTH-x;
            label.centerY = add.centerY;
        } else if (indexPath.row==1) {
            cell.clipsToBounds = YES;
            
            if (imgsArr.count>0) {
                
                if (!imgsCollectView) {
                    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
                    layout.itemSize = CGSizeMake((KSCREENWIDTH-51)/3, (KSCREENWIDTH-51)/3);
                    layout.minimumLineSpacing = 10;
                    layout.minimumInteritemSpacing = 10;
                    imgsCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 0) collectionViewLayout:layout];
                    imgsCollectView.delegate = self;
                    imgsCollectView.backgroundColor = [UIColor whiteColor];
                    imgsCollectView.dataSource = self;
                    [imgsCollectView registerClass:[DuoTuViewCell class] forCellWithReuseIdentifier:@"DuoTuViewCell"];
                }
                [cell.contentView addSubview:imgsCollectView];
                NSLog(@"%@", imgsArr);

                [imgsCollectView reloadData];
                [Tool performBlock:^{
                    CGSize size = imgsCollectView.contentSize;
                    if (duotuheight != size.height) {
                        imgsCollectView.height = size.height;
                        duotuheight = size.height;
                        [tableView reloadData];
                    }
                } afterDelay:.1];
                
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        NSLog(@"类别");
        [self showMune:212];
    }
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            NSLog(@"年代");
//            [self showMune:313];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 50;
    } else if (indexPath.section==1) {
        return 70;
    } else if (indexPath.section==2) {
        return 50;
    } else if (indexPath.section==4) {
        if (indexPath.row==2) {
            return ticaiheight;
        } else if (indexPath.row==3) {
            return 70;
        }
    } else if (indexPath.section==7) {
        if (indexPath.row==1) {
            if (imgsArr.count==0) {
                return 0;
            }
            return duotuheight;
        }
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01f;
}

#pragma mark -----

- (void)state:(UIButton *)btn {
    if (btn.tag == 555) { // 公开
        if (!isPublic) {
            isPublic = YES;
            [self.table reloadData];
        }
    } else if (btn.tag == 666) {  // 私密
        if (isPublic) {
            isPublic = NO;
            [self.table reloadData];
        }
    } else if (btn.tag == 101) {  // 非卖品
        if ([sales_status integerValue]!=1) {
            sales_status = @"1";
            openPrice = @"";
            openKuc = @"";
            [self.table reloadData];
        }
    } else if (btn.tag == 102) {  // 出售
        if ([sales_status integerValue]!=2) {
            sales_status = @"2";
            [self.table reloadData];
        }
    } else if (btn.tag == 103) {  // 已售
        if ([sales_status integerValue]!=3) {
            sales_status = @"3";
            openPrice = @"";
            openKuc = @"";
            [self.table reloadData];
        }
    } else if (btn.tag == 111) {  // 价格公开 是
        if (!isOpen) {
            isOpen = YES;
            [self.table reloadData];
        }
    } else if (btn.tag == 112) {  // 价格公开 否
        if (isOpen) {
            isOpen = NO;
            [self.table reloadData];
        }
    }
}

- (void)addPhotoAction:(UIButton *)btn {  // 添加详情图片
    
    if (imgsArr.count >= 9) {
        [self presentMessageTips:@"最多可选9张"];
        return;
    }
    
    UpDataViewController *vc = [[UpDataViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    vc.title = @"选择图片";
    [vc currentCount:imgsArr.count block:^(NSArray *arr) {
        [imgsArr addObjectsFromArray:arr];
        [self.table reloadData];
    }];
    [self presentViewController:nav animated:YES completion:NULL];
}

#pragma mark - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView==ticaiView) {
        return ticaiArr.count;
    } else if (collectionView==imgsCollectView) {
        return imgsArr.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView==ticaiView) {
        TiCaiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ticai" forIndexPath:indexPath];
        cell.data = ticaiArr[indexPath.item];
        cell.sel = [ticaiSelArr[indexPath.item] boolValue];
        [cell setNeedsLayout];
        return cell;
    } else if (collectionView==imgsCollectView) {
        DuoTuViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DuoTuViewCell" forIndexPath:indexPath];
        cell.backgroundColor = KAPPCOLOR;
        if ([imgsArr[indexPath.item] isKindOfClass:[ALAsset class]]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                ALAsset *result = imgsArr[indexPath.item];
                CGImageRef imageRef = [result aspectRatioThumbnail];  //  缩略图
                UIImage *image = [UIImage imageWithCGImage:imageRef];
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.data = image;
                    [cell setNeedsLayout];
                });
            });
        } else {
            cell.data = imgsArr[indexPath.item];
            [cell setNeedsLayout];
        }

        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView==ticaiView) {
        BOOL sel = [ticaiSelArr[indexPath.item] boolValue];
        [ticaiSelArr removeObjectAtIndex:indexPath.item];
        [ticaiSelArr insertObject:@(!sel) atIndex:indexPath.item];
        [collectionView reloadData];
    } else if (collectionView==imgsCollectView) {
        BlockUIAlertView *alert = [[BlockUIAlertView alloc] initWithTitle:@"" message:@"您确定移除这张图片" cancelButtonTitle:@"取消" clickButton:^(NSInteger index) {
            if (index==1) {
                [imgsArr removeObjectAtIndex:indexPath.item];
                [collectionView deleteItemsAtIndexPaths:@[indexPath]];
                [Tool performBlock:^{
                    [self.table reloadData];
                } afterDelay:.3];
            }
        } otherButtonTitles:@"确定"];
        [alert show];
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView==ticaiView) {
        return UIEdgeInsetsMake(0, 15, 15, 15);
    } else if (collectionView==imgsCollectView) {
        return UIEdgeInsetsMake(5, 15, 15, 15);
    }
    return UIEdgeInsetsZero;
}

#pragma mark - UIPickerViewDataSource, UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag==212) {  //  类别
        return classArr.count;
    } else if (pickerView.tag==313) {  //  年
        return yearArr.count;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectZero];
    text.font = [UIFont systemFontOfSize:15];
    if (pickerView.tag==212) {  //  类别
        ClassList *list = classArr[row];
        text.text = list.title.length>0 ? list.title : @"";
        [text sizeToFit];
    } else if (pickerView.tag==313) {  //  年
        text.text = yearArr[row];
        [text sizeToFit];
    }
    return text;
}

#pragma mark - showMune

- (void)showMune:(NSInteger)tag {
    UIControl *ctrl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT)];
    ctrl.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    ctrl.tag = 868;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT-250, KSCREENWIDTH, 250)];
    view.backgroundColor = [UIColor whiteColor];
    CGFloat height = [self createSubview:view tag:tag];
    view.height = height;
    view.y = KSCREENHEIGHT-height;
    [ctrl addSubview:view];
    ctrl.alpha = 0;
    
    [ctrl addTarget:self action:@selector(ctrlAction:) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:ctrl];
    
    [UIView animateWithDuration:.2 animations:^{
        ctrl.alpha = 1;
    }];
}

- (CGFloat)createSubview:(UIView *)view tag:(NSInteger)tag {
    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 44)];
    nav.backgroundColor = [UIColor whiteColor];
    [view addSubview:nav];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(10, 0, 50, 44);
    left.titleLabel.font = [UIFont systemFontOfSize:16];
    [left setTitle:@"取消" forState:UIControlStateNormal];
    [left setTitleColor:KAPPCOLOR forState:UIControlStateNormal];
    [left addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:left];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(KSCREENWIDTH-60, 0, 50, 44);
    right.titleLabel.font = [UIFont systemFontOfSize:16];
    [right setTitle:@"确定" forState:UIControlStateNormal];
    [right setTitleColor:KAPPCOLOR forState:UIControlStateNormal];
    [right addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:right];
    
    if (!picker) {
        picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, KSCREENWIDTH, view.height-44)];
        picker.backgroundColor = [UIColor whiteColor];
        picker.delegate = self;
        picker.dataSource = self;
        picker.showsSelectionIndicator = YES;
    }
    picker.tag = tag;
    [view addSubview:picker];
    
    if (tag==212) { //  类别
        if (classIndex>=0) {
            [picker selectRow:classIndex inComponent:0 animated:YES];
        }
    } else if (tag==313) {   //  年
        if (yearIndex>=0) {
            [picker selectRow:yearIndex inComponent:0 animated:YES];
        }
    }
    [picker reloadAllComponents];
    return picker.height+44;
}

- (void)doneAction:(UIButton *)btn {
    
    NSInteger row =[picker selectedRowInComponent:0];
    
    if (picker.tag==212) {  //  类别
        classIndex = row;
    } else if (picker.tag==313) {  //  年
        yearIndex = row;
    }
    
    [self.table reloadData];
    [self hiddenCtrl];
}

- (void)ctrlAction:(UIControl *)ctrl {
    [self hiddenCtrl];
}

- (void)cancelAction:(UIButton *)btn {
    [self hiddenCtrl];
}

- (void)hiddenCtrl {
    UIControl *ctrl = [[UIApplication sharedApplication].keyWindow viewWithTag:868];
    
    [UIView animateWithDuration:.2 animations:^{
        ctrl.alpha = 0;
    } completion:^(BOOL finished) {
        [ctrl removeFromSuperview];
    }];
}

- (void)textChange:(UITextField *)textField {
    if (textField.tag == nameTag) {
        if (isPublic) {
            publicName = textField.text;
        } else {
            defName = textField.text;
        }
    } else if (textField.tag == collectPriceTag) {
        collectPrice = textField.text;
    } else if (textField.tag == collectKucTag) {
        collectKuc = textField.text;
    } else if (textField.tag == openPriceTag) {
        if ([sales_status isEqualToString:@"1"]) {
            [self presentMessageTips:@"此作品为非卖品"];
            textField.text = @"";
            return;
        }
        if ([sales_status isEqualToString:@"3"]) {
            [self presentMessageTips:@"此作品已售"];
            textField.text = @"";
            return;
        }
        openPrice = textField.text;
    } else if (textField.tag == openKucTag) {
        if ([sales_status isEqualToString:@"1"]) {
            [self presentMessageTips:@"此作品为非卖品"];
            textField.text = @"";
            return;
        }
        if ([sales_status isEqualToString:@"3"]) {
            [self presentMessageTips:@"此作品已售"];
            textField.text = @"";
            return;
        }
        openKuc = textField.text;
    }
    else if (textField.tag == 10001)
    {
        self.year = textField.text;
    }
}

- (void)textViewChange:(NSNotification *)not {
    UITextView *textView = not.object;
    if ([textView isMemberOfClass:[IWTextView class]]) {
        if (textView.tag == contextTag) {
            if (isPublic) {
                publicContext = textView.text;
            } else {
                defContext = textView.text;
            }
        } else if (textView.tag == biaoQianTag) {
            NSArray *arr = [textView.text componentsSeparatedByString:@" "];
            if (arr.count>5) {
                NSMutableArray *c = [NSMutableArray arrayWithArray:arr];
                [c removeObjectsInRange:NSMakeRange(5, arr.count-5)];
                
                textView.text = [c componentsJoinedByString:@" "];
            }
            
            biaoQian = textView.text;
        }
    }
    
}

#pragma mark — 上传作品

- (void)sureAction:(UIButton *)btn {
    [self.view endEditing:YES];
    
    if (isPublic) {  //公开
        if (publicName.length==0) {
            [self presentMessageTips:@"请输入作品名称"];
            return;
        }
        if (publicContext.length==0) {
            [self presentMessageTips:@"请输入作品描述"];
            return;
        }
        if (classIndex<0) {
            [self presentMessageTips:@"请选择作品类别"];
            return;
        }
        if (self.year.length == 0)
        {
            [self presentMessageTips:@"请填写创作年代"];
            return;
        }
        selIndexArr = [NSMutableArray array];
        for (int i=0; i<ticaiSelArr.count; i++) {
            NSNumber *sel = ticaiSelArr[i];
            if ([sel boolValue]) {
                [selIndexArr addObject:@(i)];
            }
        }
        if (selIndexArr.count==0) {
            [self presentMessageTips:@"至少选择一种题材"];
            return;
        }
        if (biaoQian.length==0) {
            [self presentMessageTips:@"请给作品加上标签"];
            return;
        }
        if ([sales_status isEqualToString:@"2"]) {
            if (openPrice.length==0) {
                [self presentMessageTips:@"请填写公开价"];
                return;
            }
            if (openKuc.length==0) {
                [self presentMessageTips:@"请填写公开库存"];
                return;
            }
        }
        if (openPrice.length>0) {
            if ([collectPrice integerValue]>[openPrice integerValue]) {
                [self presentMessageTips:@"电子版价格不能大于真品价"];
                return;
            }
        }
    } else {
        if (defName.length==0) {
            [self presentMessageTips:@"请输入作品名称"];
            return;
        }
        if (defContext.length==0) {
            [self presentMessageTips:@"请输入作品描述"];
            return;
        }
    }
    
    NSString *urlstr = [@"http://boe.ccifc.cn/" stringByAppendingString:@"/app.php/Index/image_add"];
    
    NSString *url = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = UIImageJPEGRepresentation(self.image, 1);
    //    NSLog(@"%@", data);
    
    NSString *plates;
    if (self.isH) {
        plates = @"1";
    } else {
        plates = @"2";
    }
    
    NSDictionary *parameters = @{@"type" : @"1", @"plates" : plates};
    
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    [win presentLoadingTips:@"图片上传中..."];

    [[BoeHttp shareHttp] postWithUrl:url parameters:parameters data:data progress:^(NSProgress * _Nonnull progress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"result"] isEqualToString:@"succ"]) {
                NSDictionary *imgDic = responseObject[@"info"];
                // 这里处理  有细节图和没有细节图的逻辑  有的话  先上传细节图再传作品   没有的话  直接上传作品
                //        if (有) {  // 有细节图
                //
                //        } else {  //  没有细节图
                [self upZuoPin:imgDic[@"image_url"]];
                //        }
            }
        } else {
            UIWindow *win = [UIApplication sharedApplication].keyWindow;
            [win presentMessageTips:@"数据格式错误"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        [win presentMessageTips:@"上传失败"];
        NSLog(@"%@", error);
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)upZuoPin:(NSString *)imgUrl {
    
    [[UserModel sharedInstance] loadCache];
    REQ_APP_PHP_USER_WORKS_ADD *req = [REQ_APP_PHP_USER_WORKS_ADD new];
    if (self.isH) {
        req.plates = @"1";
    } else {
        req.plates = @"2";
    }
    req.uid = kUserId;
    req.image = imgUrl;
    if (isPublic) {  //公开
        req.title = publicName;
        req.content = publicContext;
        req.secrecy = @"1";
        ClassList *list = classArr[classIndex];
        req.classs = list.c_id.length>0?list.c_id:@"";
        req.years = self.year;
        NSMutableArray *them = [NSMutableArray array];
        for (NSNumber *i in selIndexArr) {
            ThemeList *t = [ticaiArr objectAtIndex:[i integerValue]];
            [them addObject:t.c_id];
        }
        req.theme = [them componentsJoinedByString:@","];
        req.labels = biaoQian;
        req.coll_price = collectPrice.length>0?collectPrice:@"0";
        req.coll_nums = collectKuc.length>0?collectKuc:@"0";
        req.sales_status = sales_status;
        if (isOpen) {
            req.price_open = @"1";
        } else {
            req.price_open = @"2";
        }
        req.open_price = openPrice.length>0?openPrice:@"";
        req.open_nums = openKuc.length>0?openKuc:@"";
        req.open_images = @"";
    } else {  //  私密
        req.title = defName;
        req.content = defContext;
        req.secrecy = @"2";
    }
    
    [model app_php_User_works_add:req];
}

- (void)loadModel {
    [model app_php_Index_class_list];
    [model app_php_Index_theme_list];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)changePhoto:(UIButton *)btn {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
