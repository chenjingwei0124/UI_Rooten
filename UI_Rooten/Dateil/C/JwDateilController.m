//
//  JwDateilController.m
//  UI_Rooten
//
//  Created by lanou on 15/11/21.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwDateilController.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "NetHandler.h"
#import "JwRecom.h"
#import "UIImageView+WebCache.h"
#import "JwDateilView.h"
#import "JwDataListController.h"
#import "JwDataController.h"
#import "MBProgressHUD+HM.h"
#import "UMSocial.h"

@interface JwDateilController ()

@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UIButton *backB;
@property (nonatomic, strong) UIButton *shareB;

@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *dateL;
@property (nonatomic, strong) UIButton *setinB;

@property (nonatomic, strong) JwRecom *recom;

@property (nonatomic, strong) JwDateilView *dateilV;

@property (nonatomic, strong) UIImage *shareImg;
@end

@implementation JwDateilController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self.topicId);
    
    self.headImgV = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, self.view.width, self.view.width/2))];
    self.headImgV.userInteractionEnabled = YES;
    [self.view addSubview:self.headImgV];
    
    self.backB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.backB.frame = CGRectMake(10, 20, 25, 25);
    [self.headImgV addSubview:self.backB];
    [self.backB setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui (3)"] forState:(UIControlStateNormal)];
    [self.backB addTarget:self action:@selector(dateilBackAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.shareB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.shareB.frame = CGRectMake(self.headImgV.width - 35, 20, 25, 25);
    [self.headImgV addSubview:self.shareB];
    [self.shareB setBackgroundImage:[UIImage imageNamed:@"iconfont-fenxiang (6)"] forState:(UIControlStateNormal)];
    [self.shareB addTarget:self action:@selector(shareBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIView *popView = [[UIView alloc] init];
    [self.headImgV addSubview:popView];
    [popView.layer addSublayer:[self shadowAsInverse]];
    
    self.dateL = [[UILabel alloc] initWithFrame:(CGRectMake(10, self.headImgV.height - 30, self.headImgV.width/2, 20))];
    self.dateL.textColor = [UIColor whiteColor];
    self.dateL.font = [UIFont systemFontOfSize:13];
    [self.headImgV addSubview:self.dateL];
    
    self.titleL = [[UILabel alloc] initWithFrame:(CGRectMake(self.dateL.x, self.dateL.y - 20, self.dateL.width, self.dateL.height))];
    self.titleL.textColor = [UIColor whiteColor];
    self.titleL.font = [UIFont systemFontOfSize:15];
    [self.headImgV addSubview:self.titleL];
    
    self.setinB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.setinB.frame = CGRectMake(self.headImgV.width - 100, self.titleL.y + 10, 90, 30);
    self.setinB.layer.cornerRadius = 15;
    self.setinB.backgroundColor = JwBColor;
    [self.setinB setTitle:@"进入阅读" forState:(UIControlStateNormal)];
    [self.setinB setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.setinB addTarget:self action:@selector(setinBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.headImgV addSubview:self.setinB];
    
    self.dateilV = [[JwDateilView alloc] initWithFrame:(CGRectMake(0 ,self.headImgV.y + self.headImgV.height, self.view.width, self.view.height - self.headImgV.y - self.headImgV.height))];
    [self.view addSubview:self.dateilV];
//    [self.dateilV.autImgB addTarget:self action:@selector(autImgBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.dateilV.autImgB.userInteractionEnabled = NO;
    [self.dateilV.cataB addTarget:self action:@selector(cataBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self dateilHandel];
}

- (void)setinBAction:(UIButton *)button{
    JwDataController *dataVC = [[JwDataController alloc] init];
    dataVC.mainId = self.recom.JwTids;
    [self.navigationController pushViewController:dataVC animated:YES];
}

- (void)autImgBAction:(UIButton *)button{
    NSLog(@"作者头像");
}

- (void)cataBAction:(UIButton *)button{
    JwDataListController *dataListVC = [[JwDataListController alloc] init];
    dataListVC.topicId = self.recom.JwId;
    [self.navigationController pushViewController:dataListVC animated:YES];
}

- (void)dateilHandel{
    self.recom = [[JwRecom alloc] init];
    
    [MBProgressHUD showMessage:@"数据加载中..." toView:self.view];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.doufu.diaobao.la/index.php/topic/novel?topic_id=%@", self.topicId] completion:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (dic == nil) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"网络不给力" toView:self.view];
            return ;
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSDictionary *dicData = [dic objectForKey:@"data"];
            NSDictionary *dicTopic = [dicData objectForKey:@"topic"];
            
            [self.recom setValuesForKeysWithDictionary:dicTopic];
            
            NSArray *idsArr = [dicData objectForKey:@"ids"];
            self.recom.JwTids = [idsArr[0] stringValue];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.dateilV.recom = self.recom;
                
                self.titleL.text = self.recom.title;
//                [self.headImgV sd_setImageWithURL:[NSURL URLWithString:self.recom.JwImage] placeholderImage:nil];
                [self.headImgV sd_setImageWithURL:[NSURL URLWithString:self.recom.JwImage] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    self.shareImg = image;
                }];

                NSString *finStr = @"";
                if ([self.recom.finished isEqualToString:@"0"]) {
                    finStr = @"连载中";
                }else{
                    finStr = @"已完结";
                }
                
                NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:[NSDate dateWithTimeIntervalSince1970:[self.recom.JwUpdate_time integerValue]]];
                
                if (timeInterval < 60) {
                    self.dateL.text = [NSString stringWithFormat:@"%@ 更新:刚刚", finStr];
                }else if (60 < timeInterval && timeInterval < 3600){
                    self.dateL.text = [NSString stringWithFormat:@"%@ 更新:%.f分钟前", finStr, timeInterval / 60];
                }else if (timeInterval > 3600 && timeInterval < 3600 * 24){
                    self.dateL.text = [NSString stringWithFormat:@"%@ 更新:%.f小时前", finStr,   timeInterval / 60 / 60];
                }else if (timeInterval > 3600 * 24){
                    self.dateL.text = [NSString stringWithFormat:@"%@ 更新:%.f天之前", finStr, timeInterval / 60 / 60 / 24];
                }
                
                [MBProgressHUD hideHUDForView:self.view];
            });
        });
    }];
}

- (CAGradientLayer *)shadowAsInverse
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    CGRect newShadowFrame = (CGRectMake(0, self.headImgV.height - 60, self.headImgV.width, 60));
    newShadow.frame = newShadowFrame;
    newShadow.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor,(id)JwColor(100, 100, 100).CGColor,nil];
    return newShadow;
}

- (void)dateilBackAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareBAction:(UIButton *)button{
//    NSLog(@"分享");
    [self umSocial];
}

- (void)umSocial{
    
    NSString *shareStr = [NSString stringWithFormat:@"我正在使用#浪小说#APP看小说，分享作品《%@》简介:%@", self.recom.title, self.recom.des];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56556679e0f55adcc1000894"
                                      shareText:shareStr
                                     shareImage:self.shareImg
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ, UMShareToTencent, UMShareToWechatTimeline, UMShareToQzone, UMShareToRenren, UMShareToDouban, UMShareToEmail, UMShareToSms, UMShareToFacebook, UMShareToTwitter,nil]
                                       delegate:nil];
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
