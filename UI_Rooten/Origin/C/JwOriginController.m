//
//  JwOriginController.m
//  UI_Rooten
//
//  Created by lanou on 15/11/21.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwOriginController.h"
#import "JwNewsView.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "NetHandler.h"
#import "JwRecom.h"
#import "JwDateilController.h"

#import "MBProgressHUD+HM.h"
#import "MJRefresh.h"

@interface JwOriginController ()

@property (nonatomic, strong) JwNewsView *newsOriginV;

@property (nonatomic, strong) NSMutableArray *originArr;
@property (nonatomic, strong) NSString *lastStr;
@end

@implementation JwOriginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.newsOriginV = [[JwNewsView alloc] initWithFrame:(CGRectMake(0, 64, self.view.width, self.view.height - 64))];
    [self.view addSubview:self.newsOriginV];
    
        self.originArr = [NSMutableArray array];
    
    self.newsOriginV.tableV.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.originArr = [NSMutableArray array];
            self.lastStr = @"";
            [self originHandel];
            [self.newsOriginV.tableV.header endRefreshing];
        });
        
    }];
    
    self.newsOriginV.tableV.header.automaticallyChangeAlpha = YES;
    self.newsOriginV.tableV.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self originHandel];
            [self.newsOriginV.tableV.footer endRefreshing];
        });
    }];

    
    
    __weak typeof(self)selfBlock = self;
    self.newsOriginV.newsSelectBlock = ^(JwRecom *recom){
        JwDateilController *dateilVC = [[JwDateilController alloc] init];
        dateilVC.topicId = recom.JwId;
        [selfBlock.navigationController pushViewController:dateilVC animated:YES];
    };
    
    self.lastStr = @"";
    [self originHandel];
}

- (void)originHandel{
    
    [MBProgressHUD showMessage:@"数据加载中..." toView:self.view];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.doufu.diaobao.la/index.php/topics/novels?last=%@&size=20&type=1", self.lastStr] completion:^(NSData *data) {
        
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
                [self.originArr addObject:recom];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.newsOriginV.array = self.originArr;
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
