//
//  JwFanController.m
//  UI_Rooten
//
//  Created by lanou on 15/11/21.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwFanController.h"
#import "JwNewsView.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "NetHandler.h"
#import "JwRecom.h"
#import "JwFanHeadView.h"
#import "JwDateilController.h"
#import "MBProgressHUD+HM.h"
#import "MJRefresh.h"

@interface JwFanController ()

@property (nonatomic, strong) JwFanHeadView *headV;
@property (nonatomic, strong) JwNewsView *fanNewsV;
@property (nonatomic, strong) NSMutableArray *fanArr;

@property (nonatomic, strong) NSString *nowStr;
@property (nonatomic, strong) NSString *lastStr;
@end

@implementation JwFanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.headV = [[JwFanHeadView alloc] initWithFrame:(CGRectMake(0, 64, self.view.width, 50))];
    self.headV.backgroundColor = JwCellBColor;
    self.headV.oneB.backgroundColor = JwBuBColor;
    [self.headV.oneB addTarget:self action:@selector(headBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.headV.twoB addTarget:self action:@selector(headBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.headV.theB addTarget:self action:@selector(headBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.headV];
    
    self.fanNewsV = [[JwNewsView alloc] initWithFrame:(CGRectMake(0, self.headV.y + self.headV.height, self.view.width, self.view.height - 114))];
    [self.view addSubview:self.fanNewsV];
    
    self.fanArr = [NSMutableArray array];
    
    self.fanNewsV.tableV.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.fanArr = [NSMutableArray array];
            self.lastStr = @"";
            [self fanHandelForValue:self.nowStr];
            [self.fanNewsV.tableV.header endRefreshing];
        });
        
    }];
    
    self.fanNewsV.tableV.header.automaticallyChangeAlpha = YES;
    self.fanNewsV.tableV.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self fanHandelForValue:self.nowStr];
            [self.fanNewsV.tableV.footer endRefreshing];
        });
    }];

    
    __weak typeof(self)selfBlock = self;
    self.fanNewsV.newsSelectBlock = ^(JwRecom *recom){
        JwDateilController *dateilVC = [[JwDateilController alloc] init];
        dateilVC.topicId = recom.JwId;
        [selfBlock.navigationController pushViewController:dateilVC animated:YES];
    };

    
    self.nowStr = @"2.5";
    [self fanHandelForValue:self.nowStr];
}

- (void)headBAction:(UIButton *)button{
    self.headV.oneB.backgroundColor = [UIColor clearColor];
    self.headV.twoB.backgroundColor = [UIColor clearColor];
    self.headV.theB.backgroundColor = [UIColor clearColor];
    self.fanNewsV.tableV.contentOffset = CGPointZero;
    self.lastStr = @"";
    self.fanArr = [NSMutableArray array];
    
    if ([button.titleLabel.text isEqualToString:@"全部"]) {
        self.headV.oneB.backgroundColor = JwBuBColor;
        self.nowStr = @"2.5";
        [self fanHandelForValue:self.nowStr];
    }
    if ([button.titleLabel.text isEqualToString:@"二次元"]) {
        self.headV.twoB.backgroundColor = JwBuBColor;
        self.nowStr = @"2";
        [self fanHandelForValue:self.nowStr];
    }
    if ([button.titleLabel.text isEqualToString:@"三次元"]) {
        self.headV.theB.backgroundColor = JwBuBColor;
        self.nowStr = @"3";
        [self fanHandelForValue:self.nowStr];
    }
}

- (void)fanHandelForValue:(NSString *)value{
    
    [MBProgressHUD showMessage:@"数据加载中..." toView:self.view];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.doufu.diaobao.la/index.php/topics/novels?last=%@&size=20&type=%@", self.lastStr, value] completion:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (dic == nil) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"网络不给力" toView:self.view];
            return ;
        }

        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSDictionary *dicData = [dic objectForKey:@"data"];
            
            self.lastStr = [dicData objectForKey:@"last"];
            
            NSArray *arr = [dicData objectForKey:@"novels"];
            
            for (NSDictionary *dic in arr) {
                
                JwRecom *recom = [[JwRecom alloc] init];
                [recom setValuesForKeysWithDictionary:dic];
                [self.fanArr addObject:recom];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.fanNewsV.array = self.fanArr;
                
                [MBProgressHUD hideHUDForView:self.view];
            });
        });
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
