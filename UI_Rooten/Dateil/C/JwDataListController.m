//
//  JwDataListController.m
//  UI_Rooten
//
//  Created by lanou on 15/11/23.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwDataListController.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "NetHandler.h"
#import "JwDataMain.h"
#import "JwMain.h"
#import "JwRecom.h"
#import "JwDataController.h"
#import "MBProgressHUD+HM.h"
#import "MJRefresh.h"

@interface JwDataListController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) JwDataMain *dataMain;

@property (nonatomic, strong) UIView *headV;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UIButton *backB;

@property (nonatomic, strong) UITableView *tableV;

@property (nonatomic, strong) NSString *lastStr;
@property (nonatomic, strong) NSMutableArray *mainArr;
@end

@implementation JwDataListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addSubviewHead:self.view];
    
    self.tableV = [[UITableView alloc] initWithFrame:(CGRectMake(0, self.headV.y + self.headV.height, self.view.width, self.view.height - 64)) style:(UITableViewStylePlain)];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableV];
    
    self.mainArr = [NSMutableArray array];
    
    self.tableV.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.mainArr = [NSMutableArray array];
            self.lastStr = @"";
            [self dataListHandel];
            [self.tableV.header endRefreshing];
        });
        
    }];
    
    self.tableV.header.automaticallyChangeAlpha = YES;
    self.tableV.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dataListHandel];
            [self.tableV.footer endRefreshing];
        });
    }];

    self.lastStr = @"";
    [self dataListHandel];
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
    
    self.backB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.backB.frame = CGRectMake(self.headV.width/30, self.titleL.y, 20, 20);
    [self.backB setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui (3)"] forState:(UIControlStateNormal)];
    [self.backB addTarget:self action:@selector(backBDataListAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.headV addSubview:self.backB];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mainArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JwDataController *dataVC = [[JwDataController alloc] init];
    JwMain *main = self.mainArr[indexPath.row];
    dataVC.mainId = main.JwId;
    [self.navigationController pushViewController:dataVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifier];
    }
    cell.backgroundColor = JwCellBColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (self.mainArr.count != 0) {
        
        JwMain *main = self.mainArr[indexPath.row];
        cell.textLabel.text = main.title;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@字", main.JwLength];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    return cell;
}

- (void)backBDataListAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dataListHandel{
    self.dataMain = [[JwDataMain alloc] init];
    
    [MBProgressHUD showMessage:@"数据加载中..." toView:self.view];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.doufu.diaobao.la/index.php/post/topic?topic_id=%@&size=20&new=%@", self.topicId, self.lastStr] completion:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (dic == nil) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"网络不给力" toView:self.view];
            return ;
        }

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSDictionary *dicData = [dic objectForKey:@"data"];
            
            [self.dataMain setValuesForKeysWithDictionary:dicData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.dataMain.JwMainArr.count == 0) {
                    [MBProgressHUD hideHUDForView:self.view];
                    [MBProgressHUD showError:@"已没有更多的章节" toView:self.view];

                }else{
                    self.lastStr = [dicData objectForKey:@"last"];
                    [self.mainArr addObjectsFromArray:self.dataMain.JwMainArr];
                    [MBProgressHUD hideHUDForView:self.view];
                }
                [self.tableV reloadData];
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
