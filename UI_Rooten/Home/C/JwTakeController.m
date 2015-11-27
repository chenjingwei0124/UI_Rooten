//
//  JwTakeController.m
//  UI_Rooten
//
//  Created by lanou on 15/11/24.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwTakeController.h"
#import "JwNewsView.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "NetHandler.h"
#import "JwDateilController.h"
#import "JwRecom.h"
#import "MBProgressHUD+HM.h"
#import "MJRefresh.h"

@interface JwTakeController ()

@property (nonatomic, strong) JwNewsView *newsTakeV;
@property (nonatomic, strong) NSMutableArray *newsTakeArr;

@property (nonatomic, strong) NSString *lastStr;
@end

@implementation JwTakeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleL.text = self.titleStr;
    
    __weak typeof(self)selfBlock = self;
    
    self.newsTakeV = [[JwNewsView alloc] initWithFrame:(CGRectMake(0, 64, self.view.width, self.view.height - 64))];
    [self.view addSubview:self.newsTakeV];
    self.newsTakeV.newsSelectBlock = ^(JwRecom *recom){
        JwDateilController *dateilVC = [[JwDateilController alloc] init];
        dateilVC.topicId = recom.JwId;
        [selfBlock.navigationController pushViewController:dateilVC animated:YES];
    };
    
    self.newsTakeArr = [NSMutableArray array];
    
    self.newsTakeV.tableV.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.newsTakeArr = [NSMutableArray array];
            self.lastStr = @"";
            [self newsTakeHandel];
            [self.newsTakeV.tableV.header endRefreshing];
        });
        
    }];
    
    self.newsTakeV.tableV.header.automaticallyChangeAlpha = YES;
    self.newsTakeV.tableV.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self newsTakeHandel];
            [self.newsTakeV.tableV.footer endRefreshing];
        });
    }];

    self.lastStr = @"";
    [self newsTakeHandel];
}


- (void)newsTakeHandel{
    
    [MBProgressHUD showMessage:@"数据加载中..." toView:self.view];

    NSString *urlStr = nil;
    if ([self.JwId isEqualToString:@"推荐小说"]) {
        
        urlStr = [NSString stringWithFormat:@"http://api.doufu.diaobao.la/index.php/topics/moreRecommendedNovels?last=%@&size=20", self.lastStr];
        
    }else if (JwBang) {
        if ([self.JwId isEqualToString:@"完结文"]) {
            urlStr = [NSString stringWithFormat:@"http://api.doufu.diaobao.la/index.php/post/topics?type=18&finished=1&last=%@&size=20", self.lastStr];
        }else{
            self.newsTakeArr = [NSMutableArray array];
            urlStr = [NSString stringWithFormat:@"%@?last=&size=60", self.urlStr];
        }
    }
    else{
        self.newsTakeArr = [NSMutableArray array];
        urlStr = [NSString stringWithFormat:@"http://api.doufu.diaobao.la/index.php/albums/items?id=%@&last=&size=50", self.JwId];
    }
    
    [NetHandler getDataWithUrl:urlStr completion:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (dic == nil) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"网络不给力" toView:self.view];
            return ;
        }

        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSArray *tempArr = nil;
            
            if ([self.JwId isEqualToString:@"推荐小说"]) {
                
                NSDictionary *dicData = [dic objectForKey:@"data"];
                self.lastStr = [dicData objectForKey:@"last"];
                tempArr = [dicData objectForKey:@"novels"];
                
            }else if ([self.JwId isEqualToString:@"完结文"]) {
                
                NSDictionary *dicData = [dic objectForKey:@"data"];
                self.lastStr = [dicData objectForKey:@"last"];
                tempArr = [dicData objectForKey:@"main"];
            }
            else{
                tempArr = [dic objectForKey:@"data"];
            }

            
            for (NSDictionary *dic in tempArr) {
                
                JwRecom *recom = [[JwRecom alloc] init];
                [recom setValuesForKeysWithDictionary:dic];
                [self.newsTakeArr addObject:recom];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.newsTakeV.array = self.newsTakeArr;
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
