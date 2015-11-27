//
//  JwAfterController.m
//  UI_Rooten
//
//  Created by lanou on 15/11/24.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwAfterController.h"
#import "UIView+Extension.h"
#import "JwAcer.h"

@interface JwAfterController ()

@end

@implementation JwAfterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubviewHead:self.view];
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
    [self.backB addTarget:self action:@selector(backBAfterListAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.headV addSubview:self.backB];
}

- (void)backBAfterListAction:(UIButton *)button{
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
