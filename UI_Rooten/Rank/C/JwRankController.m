//
//  JwRankController.m
//  UI_Rooten
//
//  Created by lanou on 15/11/21.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwRankController.h"
#import "JwRankView.h"
#import "JwArticle.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "NetHandler.h"
#import "JwTakeController.h"

#import "MBProgressHUD+HM.h"
#import "MJRefresh.h"

@interface JwRankController ()

@property (nonatomic, strong) JwRankView *rankV;
@property (nonatomic, strong) NSMutableArray *rankArr;
@end

@implementation JwRankController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self)blockSelf = self;
    
    self.rankV = [[JwRankView alloc] initWithFrame:(CGRectMake(0, 64, self.view.width, self.view.height - 64))];
    [self.view addSubview:self.rankV];
    
    self.rankV.tableV.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self rankHandel];
            [self.rankV.tableV.header endRefreshing];
        });
        
    }];

    
    self.rankV.rankCellSelectBlock = ^(JwArticle *article){
        JwTakeController *takeVC = [[JwTakeController alloc] init];
        takeVC.titleStr = article.name;
        takeVC.JwId = article.name;
        takeVC.urlStr = article.url;
        [blockSelf.navigationController pushViewController:takeVC animated:YES];
        
    };

    
    [self rankHandel];
}

- (void)rankHandel{
    
    self.rankArr = [NSMutableArray array];
    
    [MBProgressHUD showMessage:@"数据加载中..." toView:self.view];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.doufu.diaobao.la/index.php/albums/items?id=74?last=&size=20"] completion:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (dic == nil) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"网络不给力" toView:self.view];
            return ;
        }

        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSArray *arrData = [dic objectForKey:@"data"];

            for (NSDictionary *dic in arrData) {
                
                JwArticle *artic = [[JwArticle alloc] init];
                [artic setValuesForKeysWithDictionary:dic];
                [self.rankArr addObject:artic];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.rankV.array = self.rankArr;
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
