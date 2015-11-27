//
//  JwBaseController.m
//  UI_Rooten
//
//  Created by lanou on 15/11/19.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwBaseController.h"
#import "UIView+Extension.h"
#import "JwAcer.h"

@interface JwBaseController ()

@end

@implementation JwBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
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
