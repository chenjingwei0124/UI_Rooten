//
//  JwHomeController.m
//  UI_Rooten
//
//  Created by lanou on 15/11/19.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwHomeController.h"
#import "NetHandler.h"
#import "JwCarou.h"
#import "JwAlbums.h"
#import "JwRecom.h"
#import "JwArticle.h"

#import "JwCarouView.h"
#import "JwHomeView.h"
#import "UIView+Extension.h"

#import "JwArticleListController.h"
#import "JwTakeController.h"
#import "JwDateilController.h"
#import "JwAcer.h"
#import "MJRefresh.h"
#import "MBProgressHUD+HM.h"

@interface JwHomeController ()

@property (nonatomic, strong) JwHomeView *homeV;
@property (nonatomic, strong) JwCarouView *carouV;

@property (nonatomic, strong) NSMutableArray *imgArr;
@property (nonatomic, strong) NSMutableArray *albmusArr;
@property (nonatomic, strong) NSMutableArray *novArr;

@property (nonatomic, strong) NSMutableArray *articArr;
@end

@implementation JwHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self)blockSelf = self;
    
    self.homeV = [[JwHomeView alloc] initWithFrame:(CGRectMake(0, 64, self.view.width, self.view.height - 64))];
    [self.view addSubview:self.homeV];
    
    self.homeV.tableV.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self homeHandel];
            [self.homeV.tableV.header endRefreshing];
        });
    }];

    
    self.homeV.homeCellSelectBlock = ^(void){
        JwArticleListController *articleVC = [[JwArticleListController alloc] init];
        [blockSelf.navigationController pushViewController:articleVC animated:YES];
    };
    
    self.homeV.homeCellBBlock = ^(JwAlbums *albums){
        JwTakeController *takeVC = [[JwTakeController alloc] init];
        takeVC.titleStr = albums.name;
        takeVC.JwId = albums.JwId;
        [blockSelf.navigationController pushViewController:takeVC animated:YES];
    };
    
    self.homeV.noveCellSelectBlock = ^(void){
        JwTakeController *takeVC = [[JwTakeController alloc] init];
        takeVC.titleStr = @"推荐小说";
        takeVC.JwId = @"推荐小说";
        [blockSelf.navigationController pushViewController:takeVC animated:YES];

    }; 
    self.homeV.articleCellSelectBlock = ^(JwArticle *article){
        JwTakeController *takeVC = [[JwTakeController alloc] init];
        takeVC.titleStr = article.name;
        takeVC.JwId = article.name;
        takeVC.urlStr = article.url;
        [blockSelf.navigationController pushViewController:takeVC animated:YES];
        
    };

    self.carouV = [[JwCarouView alloc] initWithFrame:(CGRectMake(0, 0, self.view.width, self.view.height/3.5))];
    self.homeV.tableV.tableHeaderView = self.carouV;
    
    [self homeHandel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noveViewNot:) name:@"noveView" object:nil];
}

- (void)noveViewNot:(NSNotification *)not{
    JwDateilController *dateilVC = [[JwDateilController alloc] init];
    JwRecom *recom = not.object;
    dateilVC.topicId = recom.JwId;
    [self.navigationController pushViewController:dateilVC animated:YES];
}
     
- (void)homeHandel{
    self.imgArr = [NSMutableArray array];
    self.albmusArr = [NSMutableArray array];
    self.novArr = [NSMutableArray array];
    self.articArr = [NSMutableArray array];
    
    [MBProgressHUD showMessage:@"数据加载中..." toView:self.view];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.doufu.diaobao.la/index.php/topics/novelRecommendation"] completion:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (dic == nil) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"网络不给力" toView:self.view];
            return ;
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSDictionary *dicData = [dic objectForKey:@"data"];
            
            NSArray *arrCar = [dicData objectForKey:@"carousels"];
            for (NSDictionary *dicCar in arrCar) {
                JwCarou *carou = [[JwCarou alloc] init];
                
                NSArray *imgArr = [dicCar objectForKey:@"images"];
                NSDictionary *imgDic = imgArr[0];
                carou.img = [imgDic objectForKey:@"imgUrl"];
                
                carou.JwId = [dicCar objectForKey:@"id"];
                
                [self.imgArr addObject:carou];
            }
            
            NSArray *albumsArr = [dicData objectForKey:@"novel_activity_albums"];
            for (NSDictionary *albDic in albumsArr) {
                JwAlbums *albmus = [[JwAlbums alloc] init];
                
                [albmus setValuesForKeysWithDictionary:albDic];
                [self.albmusArr addObject:albmus];
            }
            
            NSArray *novArr = [dicData objectForKey:@"novels"];
            for (NSDictionary *novDic in novArr) {
                JwRecom *recom = [[JwRecom alloc] init];
                [recom setValuesForKeysWithDictionary:novDic];
                [self.novArr addObject:recom];
            }
            
            JwArticle *artic1 = [[JwArticle alloc] init];
            [artic1 setValuesForKeysWithDictionary:[dicData objectForKey:@"finished_novel_entry"]];
            [self.articArr addObject:artic1];
            
            JwArticle *artic2 = [[JwArticle alloc] init];
            [artic2 setValuesForKeysWithDictionary:[dicData objectForKey:@"signed_author_novel_album"]];
            [self.articArr addObject:artic2];
            
            JwArticle *artic3 = [[JwArticle alloc] init];
            [artic3 setValuesForKeysWithDictionary:[dicData objectForKey:@"signed_author_album"]];
            [self.articArr addObject:artic3];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.imgArr addObject:self.imgArr[0]];
                self.carouV.array = self.imgArr;
                
                self.homeV.albmusArr = self.albmusArr;
                self.homeV.noveArr = self.novArr;
                
                self.homeV.articArr = self.articArr;
                
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
