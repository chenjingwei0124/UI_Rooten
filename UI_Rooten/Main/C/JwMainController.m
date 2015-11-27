//
//  JwMainController.m
//  UI_Rooten
//
//  Created by lanou on 15/11/19.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwMainController.h"
#import "JwAcer.h"
#import "UIView+Extension.h"
#import "JwHomeController.h"
#import "JwLeftView.h"

#import "JwNewsController.h"
#import "JwOriginController.h"
#import "JwFanController.h"
#import "JwRankController.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"

#define kMinSK 0.2

@interface JwMainController ()<UITableViewDelegate>

@property (nonatomic, strong)UIView *mainV;
@property (nonatomic, strong)JwLeftView *leftV;
@property (nonatomic, strong)UIView *headV;

@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UIButton *setupB;

@property (nonatomic, strong)UINavigationController *naVC;

@property (nonatomic, strong) UIButton *coverB;
@end

@implementation JwMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftV = [[JwLeftView alloc] initWithFrame:(CGRectMake(-self.view.width*2/6, 0, self.view.width*2/3, self.view.height))];
    self.leftV.backgroundColor = JwBColor;
    self.leftV.tableV.delegate = self;
    [self.view addSubview:self.leftV];
    
    self.mainV = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.view.width, self.view.height))];
    [self.view addSubview:self.mainV];
    
    self.mainV.layer.shadowOffset = CGSizeMake(0, 0);
    self.mainV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.mainV.layer.shadowOpacity = 0.8;
    self.mainV.layer.shadowRadius = 5;
    
    self.naVC = [[UINavigationController alloc] initWithRootViewController:[[JwHomeController alloc] init]];
    [self addChildViewController:self.naVC];
    [self.mainV addSubview:self.naVC.view];
    
    //导航View
    [self addSubviewHead:self.naVC.viewControllers[0].view];
    self.titleL.text = @"推荐";
    
    [self addCover];
    
    //手势
    [self setupGestureRecognizer];
    
}

- (void)addCover{
    self.coverB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.coverB.frame = CGRectMake(0, 0, self.mainV.width, self.mainV.height);
    self.coverB.backgroundColor = [UIColor blackColor];
    self.coverB.alpha = 0;
    [self.coverB addTarget:self action:@selector(coverBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.mainV addSubview:self.coverB];
}

- (void)coverBAction:(UIButton *)button{
    [self setupBAction:self.setupB];
}

- (void)addSubviewHead:(UIView *)view{
    
    self.headV = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, JwWidth, 64))];
    self.headV.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iconfont-miaoshabeijingkuai2x"]];
    [view addSubview:self.headV];
    
    self.titleL = [[UILabel alloc] initWithFrame:(CGRectMake(self.headV.width/5, self.headV.height/2, self.headV.width*3/5, 20))];
    self.titleL.textAlignment = NSTextAlignmentCenter;
    self.titleL.font = [UIFont systemFontOfSize:17 weight:0.2];
    self.titleL.textColor = [UIColor whiteColor];
    [self.headV addSubview:self.titleL];
    
    self.setupB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.setupB.frame = CGRectMake(self.headV.width/30, self.titleL.y, 20, 20);
    [self.setupB setBackgroundImage:[UIImage imageNamed:@"iconfont-caidan (1)"] forState:(UIControlStateNormal)];
    [self.setupB addTarget:self action:@selector(setupBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.headV addSubview:self.setupB];
}

-(void)setupGestureRecognizer{
    //拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self.mainV addGestureRecognizer:pan];
}

- (void)panView:(UIPanGestureRecognizer *)pan{
    
    CGPoint transPoint = [pan translationInView:pan.view];
    CGPoint center = pan.view.center;
    CGFloat viewW = self.view.width/2;
    if (transPoint.x > kMinSK) {
        for (float i = 0; i < transPoint.x; i += kMinSK) {
            if (center.x > viewW + self.view.width*2/3)
            {
                break;
            }
            center.x += kMinSK;
        }
    }
    if(transPoint.x < - kMinSK){
        for (float i = 0; i > transPoint.x; i -= kMinSK) {
            if (center.x < viewW)
            {
                break;
            }
            center.x -= kMinSK;
        }
    }
    pan.view.center = center;
    
    
    CGPoint leftCen = CGPointMake((center.x - self.view.width/2)/2, self.leftV.centerY);
    self.leftV.center = leftCen;
    
    [pan setTranslation:(CGPointZero) inView:self.mainV];

    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (self.mainV.x > self.view.width*2/6) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.mainV.frame = CGRectMake(self.view.width*2/3, 0, self.view.width, self.view.height);
                    self.leftV.frame = CGRectMake(0, 0, self.view.width*2/3, self.view.height);
                }];
            }
            else if(self.mainV.x < self.view.width*2/6) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.mainV.frame = CGRectMake(0, 0, self.view.width, self.view.height);
                    self.leftV.frame = CGRectMake(- self.view.width*2/6, 0, self.view.width*2/3, self.view.height);
                }];
            }

        }
            break;
        default:
            break;
    }
    [self calcCache];
    
    self.coverB.alpha = (self.mainV.x/(self.view.width*2/3)) * 0.3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.naVC.view removeFromSuperview];
        [self.naVC removeFromParentViewController];
        
        self.naVC = [[UINavigationController alloc] initWithRootViewController:[[JwHomeController alloc] init]];
        [self addChildViewController:self.naVC];
        [self.mainV addSubview:self.naVC.view];
        [self addSubviewHead:self.naVC.viewControllers[0].view];
        self.titleL.text = @"推荐";
        [self setupBAction:self.setupB];
    }
    if (indexPath.row == 1) {
        [self.naVC.view removeFromSuperview];
        [self.naVC removeFromParentViewController];
        
        self.naVC = [[UINavigationController alloc] initWithRootViewController:[[JwNewsController alloc] init]];
        [self addChildViewController:self.naVC];
        [self.mainV addSubview:self.naVC.view];
        [self addSubviewHead:self.naVC.viewControllers[0].view];
        self.titleL.text = @"最新";
        [self setupBAction:self.setupB];
    }
    if (indexPath.row == 2) {
        [self.naVC.view removeFromSuperview];
        [self.naVC removeFromParentViewController];
        
        self.naVC = [[UINavigationController alloc] initWithRootViewController:[[JwOriginController alloc] init]];
        [self addChildViewController:self.naVC];
        [self.mainV addSubview:self.naVC.view];
        [self addSubviewHead:self.naVC.viewControllers[0].view];
        self.titleL.text = @"原耽";
        [self setupBAction:self.setupB];
    }
    if (indexPath.row == 3) {
        [self.naVC.view removeFromSuperview];
        [self.naVC removeFromParentViewController];
        
        self.naVC = [[UINavigationController alloc] initWithRootViewController:[[JwFanController alloc] init]];
        [self addChildViewController:self.naVC];
        [self.mainV addSubview:self.naVC.view];
        [self addSubviewHead:self.naVC.viewControllers[0].view];
        self.titleL.text = @"同人";
        [self setupBAction:self.setupB];
    }
    if (indexPath.row == 4) {
        [self.naVC.view removeFromSuperview];
        [self.naVC removeFromParentViewController];
        
        self.naVC = [[UINavigationController alloc] initWithRootViewController:[[JwRankController alloc] init]];
        [self addChildViewController:self.naVC];
        [self.mainV addSubview:self.naVC.view];
        [self addSubviewHead:self.naVC.viewControllers[0].view];
        self.titleL.text = @"排行";
        [self setupBAction:self.setupB];
    }
    if (indexPath.row == 5) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"版本" message:@"1.0.1\n新版本持续更新中\n@蒲公英不淡定" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    if (indexPath.row == 6) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"清空缓存" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self clearCahce];
        }];
        [alertVC addAction:cancelAction];
        [alertVC addAction:otherAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    
    if (self.coverB)
    {
        [self.coverB removeFromSuperview];
        [self addCover];
        if (self.mainV.x == 0) {
            self.coverB.alpha = 0;
        }
        else {
            self.coverB.alpha = 0.3;
        }
    }

}

- (void)setupBAction:(UIButton *)button{
    if (self.mainV.x == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            self.leftV.frame = CGRectMake(0, 0, self.view.width*2/3, self.view.height);
            self.mainV.frame = CGRectMake(self.view.width*2/3, 0, self.view.width, self.view.height);
            self.coverB.alpha = 0.3;
        }];
    }
    else {
        [UIView animateWithDuration:0.3 animations:^{
            self.leftV.frame = CGRectMake(- self.view.width*2/6, 0, self.view.width*2/3, self.view.height);
            self.mainV.frame = CGRectMake(0, 0, self.view.width, self.view.height);
            self.coverB.alpha = 0;
        }];
    }
    [self calcCache];
}

- (void)calcCache{
    if (self.leftV.x == 0) {
       
        float tmpSize = [[SDWebImageManager sharedManager].imageCache getSize];
        NSString *clearCacheName = tmpSize >= 1 ? [NSString stringWithFormat:@"%.2fM",tmpSize/1024/1024] : [NSString stringWithFormat:@"%.2fK",tmpSize/1024/1024];
        
        UITableViewCell *cell = [self.leftV.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForItem:6 inSection:0]];
        cell.detailTextLabel.text = clearCacheName;
        [self.leftV.tableV reloadData];
    }
}

- (void)clearCahce{
    [[SDWebImageManager sharedManager].imageCache clearDisk];
    [self calcCache];
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
