//
//  JwDataController.m
//  UI_Rooten
//
//  Created by lanou on 15/11/23.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwDataController.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "JwMain.h"
#import "JwRecom.h"
#import "JwDataMain.h"
#import "NetHandler.h"
#import "MBProgressHUD+HM.h"

@interface JwDataController ()
@property (nonatomic, strong) JwDataMain *dataMain;

@property (nonatomic, strong) UIView *headV;
@property (nonatomic, strong) UIButton *backB;
@property (nonatomic, strong) UIButton *typeB;

@property (nonatomic, strong) UIView *footV;
@property (nonatomic, strong) UILabel *footL;
@property (nonatomic, strong) UIButton *upB;
@property (nonatomic, strong) UIButton *nextB;

@property (nonatomic, strong) UITextView *textV;

@property (nonatomic, assign) NSInteger typeRow;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *ids;
@end

@implementation JwDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.typeRow = 15;
    
    [self addSubviewHead:self.view];
    [self addSubviewFoot:self.view];
    
    self.textV = [[UITextView alloc] initWithFrame:(CGRectMake(0, self.headV.y + self.headV.height, self.view.width, self.footV.y - self.headV.y - self.headV.height))];
    self.textV.textColor = JwTextHColor;
    self.textV.font = [UIFont fontWithName:@"Arial" size:15.0];
    self.textV.scrollEnabled = YES;
    self.textV.editable = NO;
    [self.view addSubview:self.textV];
    
    [self mainHandel];
}

- (void)addSubviewHead:(UIView *)view{
    
    self.headV = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, JwWidth, 64))];
    self.headV.backgroundColor = JwColor(242, 242, 242);
    [view addSubview:self.headV];
    
    self.backB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.backB.frame = CGRectMake(self.headV.width/30, self.headV.height/2, 20, 20);
    [self.backB setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui (5)"] forState:(UIControlStateNormal)];
    [self.backB addTarget:self action:@selector(backBDataAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.headV addSubview:self.backB];
    
    self.typeB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.typeB.frame = CGRectMake(self.headV.width - self.headV.width/30 - 30, self.headV.height/2 - 5, 30, 30);
    [self.typeB setBackgroundImage:[UIImage imageNamed:@"iconfont-zitidaxiao"] forState:(UIControlStateNormal)];
    [self.typeB addTarget:self action:@selector(typeBDataAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.headV addSubview:self.typeB];
}

- (void)typeBDataAction:(UIButton *)button{
    if (self.typeRow == 15) {
        self.typeRow = 20;
    }else if (self.typeRow == 20) {
        self.typeRow = 13;
    }else if (self.typeRow == 13) {
        self.typeRow = 15;
    }
    [self addValue];
}

- (void)addSubviewFoot:(UIView *)view{
    self.footV = [[UIView alloc] initWithFrame:(CGRectMake(0, self.view.height - 50, self.headV.width, 50))];
    self.footV.backgroundColor = JwColor(242, 242, 242);
    [view addSubview:self.footV];
    
    self.upB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.upB.frame = CGRectMake(20, 10, 70, 30);
    self.upB.backgroundColor = JwColor(224, 224, 224);
    self.upB.layer.cornerRadius = 5;
    [self.upB setTitle:@"上一章" forState:(UIControlStateNormal)];
    [self.upB setTitleColor:JwTextHColor forState:(UIControlStateNormal)];
    [self.upB addTarget:self action:@selector(upBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.footV addSubview:self.upB];
    
    self.nextB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.nextB.frame = CGRectMake(self.footV.width - 90, 10, 70, 30);
    self.nextB.backgroundColor = JwColor(224, 224, 224);
    self.nextB.layer.cornerRadius = 5;
    [self.nextB setTitle:@"下一章" forState:(UIControlStateNormal)];
    [self.nextB setTitleColor:JwTextHColor forState:(UIControlStateNormal)];
    [self.nextB addTarget:self action:@selector(nextBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.footV addSubview:self.nextB];
    
    self.footL = [[UILabel alloc] initWithFrame:(CGRectMake(self.upB.x + self.upB.width, 10, self.nextB.x - self.upB.x - self.upB.width, 30))];
    self.footL.font = [UIFont systemFontOfSize:14];
    self.footL.textAlignment = NSTextAlignmentCenter;
    self.footL.textColor = JwTextDColor;
    [self.footV addSubview:self.footL];
}

- (void)addValue{
    
    NSString *content = [NSString stringWithFormat:@"%@\n        %@", self.dataMain.JwMain.title, self.dataMain.JwMain.content];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:self.typeRow],NSParagraphStyleAttributeName:paragraphStyle};
    
    self.textV.contentOffset = CGPointMake(0, 0);
    self.textV.attributedText = [[NSAttributedString alloc] initWithString:content attributes:attributes];
    
    self.footL.text = [NSString stringWithFormat:@"%ld/%lu", self.index + 1, (unsigned long)self.dataMain.JwIds.count];
}

- (void)upBAction:(UIButton *)button{
    if (self.index == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已经是第一章" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        self.index -= 1;
        self.mainId = self.ids[self.index];
        [self mainHandel];
    }
}

- (void)nextBAction:(UIButton *)button{
    if (self.index == self.ids.count - 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已经最后一章" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        self.index += 1;
        self.mainId = self.ids[self.index];
        [self mainHandel];

    }

}

- (void)mainHandel{
    self.dataMain = [[JwDataMain alloc] init];
    
    [MBProgressHUD showMessage:@"数据加载中..." toView:self.view];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.doufu.diaobao.la/index.php/post/view/%@?with_ids=1", self.mainId] completion:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSDictionary *dicData = [dic objectForKey:@"data"];
            
            [self.dataMain setValuesForKeysWithDictionary:dicData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.index = [self.dataMain.JwIds indexOfObject:self.dataMain.JwMain.JwId];
                self.ids = self.dataMain.JwIds;
                [self addValue];
                [MBProgressHUD hideHUDForView:self.view];
            });
        });
    }];
}

- (void)backBDataAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
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
