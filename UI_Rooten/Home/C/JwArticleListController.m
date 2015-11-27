//
//  JwArticleListController.m
//  UI_Rooten
//
//  Created by lanou on 15/11/24.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwArticleListController.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "JwArticleListCell.h"
#import "NetHandler.h"
#import "JwAlbums.h"
#import "JwTakeController.h"
#import "MBProgressHUD+HM.h"
#import "MJRefresh.h"

@interface JwArticleListController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectV;
@property (nonatomic, strong) NSMutableArray *articleArr;

@end

@implementation JwArticleListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleL.text = @"活动专题";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.width/4, self.view.width/3);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(self.view.width/30, self.view.width/30, self.view.width/30, self.view.width/30);
    
    self.collectV = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 64, self.view.width, self.view.height - 64)) collectionViewLayout:layout];
    self.collectV.dataSource = self;
    self.collectV.delegate = self;
    self.collectV.backgroundColor = [UIColor whiteColor];
    [self.collectV registerClass:[JwArticleListCell class] forCellWithReuseIdentifier:@"foundCell"];
    [self.view addSubview:self.collectV];
    
    self.collectV.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self articleHandel];
            [self.collectV.header endRefreshing];
        });
        
    }];

    
    [self articleHandel];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.articleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JwArticleListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"foundCell" forIndexPath:indexPath];
    if (self.articleArr.count != 0) {
        cell.albums = self.articleArr[indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JwTakeController *takeVC = [[JwTakeController alloc] init];
    JwAlbums *albums = self.articleArr[indexPath.item];
    takeVC.titleStr = albums.name;
    takeVC.JwId = albums.JwId;
    [self.navigationController pushViewController:takeVC animated:YES];
}


- (void)articleHandel{
    
    self.articleArr = [NSMutableArray array];
    
    [MBProgressHUD showMessage:@"数据加载中..." toView:self.view];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.doufu.diaobao.la/index.php/albums/items?id=70&last=&size=50"] completion:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (dic == nil) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"网络不给力" toView:self.view];
            return ;
        }

        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSArray *arrData = [dic objectForKey:@"data"];
            
            for (NSDictionary *albDic in arrData) {
                JwAlbums *albmus = [[JwAlbums alloc] init];
                
                [albmus setValuesForKeysWithDictionary:albDic];
                [self.articleArr addObject:albmus];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.collectV reloadData];
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
