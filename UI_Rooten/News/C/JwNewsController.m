//
//  JwNewsController.m
//  UI_Rooten
//
//  Created by lanou on 15/11/21.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwNewsController.h"
#import "JwNewsView.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "NetHandler.h"
#import "JwRecom.h"
#import "JwDateilController.h"
#import "MBProgressHUD+HM.h"
#import "MJRefresh.h"

@interface JwNewsController ()

@property (nonatomic, strong) JwNewsView *newsV;

@property (nonatomic, strong) NSMutableArray *newsArr;
@property (nonatomic, strong) NSString *lastStr;
@end

@implementation JwNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self)selfBlock = self;
    
    self.newsV = [[JwNewsView alloc] initWithFrame:(CGRectMake(0, 64, self.view.width, self.view.height - 64))];
    [self.view addSubview:self.newsV];
    
    self.newsArr = [NSMutableArray array];
    
    self.newsV.tableV.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.newsArr = [NSMutableArray array];
            self.lastStr = @"";
            [self newsHandel];
            [self.newsV.tableV.header endRefreshing];
        });

    }];
    
    self.newsV.tableV.header.automaticallyChangeAlpha = YES;
    self.newsV.tableV.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self newsHandel];
            [self.newsV.tableV.footer endRefreshing];
        });
    }];

    
    self.newsV.newsSelectBlock = ^(JwRecom *recom){
        JwDateilController *dateilVC = [[JwDateilController alloc] init];
        dateilVC.topicId = recom.JwId;
        [selfBlock.navigationController pushViewController:dateilVC animated:YES];
    };
    
    self.lastStr = @"";
    [self newsHandel];
}

- (void)newsHandel{
    
    [MBProgressHUD showMessage:@"数据加载中..." toView:self.view];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.doufu.diaobao.la/index.php/topics/latestNovels?last=%@&size=20", self.lastStr] completion:^(NSData *data) {
        
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
                [self.newsArr addObject:recom];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                self.newsV.array = self.newsArr;
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
