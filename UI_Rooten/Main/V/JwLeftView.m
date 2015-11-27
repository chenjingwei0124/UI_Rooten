//
//  JwLeftView.m
//  UI_Rooten
//
//  Created by lanou on 15/11/20.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwLeftView.h"
#import "UIView+Extension.h"

@interface JwLeftView ()<UITableViewDataSource>

@end

@implementation JwLeftView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imgLg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, frame.size.width/3, frame.size.width/3))];
        imgLg.center = CGPointMake(frame.size.width/2, frame.size.height/4/2.5);
        imgLg.image = [UIImage imageNamed:@"lgz"];
        imgLg.layer.cornerRadius = imgLg.width/2;
        imgLg.layer.masksToBounds = YES;
        [self addSubview:imgLg];
        
        UIImageView *imgLgz = [[UIImageView alloc] initWithFrame:(CGRectMake(0, imgLg.y + imgLg.height, 60, 30))];
        imgLgz.image = [UIImage imageNamed:@"lg"];
        imgLgz.centerX = imgLg.centerX;
        [self addSubview:imgLgz];
        
        self.tableV = [[UITableView alloc] initWithFrame:(CGRectMake(0, frame.size.height/4, frame.size.width, frame.size.height*3/4)) style:(UITableViewStylePlain)];
        self.tableV.dataSource = self;
        self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.tableV];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-weinituijian"];
        cell.textLabel.text = @"推荐";
    }
    if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-xinxiaoxiwangzhanbiaozhi"];
        cell.textLabel.text = @"最新";
    }
    if (indexPath.row == 2) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-jishiben (2)"];
        cell.textLabel.text = @"原耽";
    }
    if (indexPath.row == 3) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-yuan"];
        cell.textLabel.text = @"同人";
    }
    if (indexPath.row == 4) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-iconfontpaixing"];
        cell.textLabel.text = @"排行";
    }
    if (indexPath.row == 5) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-shuibei"];
        cell.textLabel.text = @"版本";
        cell.detailTextLabel.text = @"1.0.1";
    }
    if (indexPath.row == 6) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-dasao"];
        cell.textLabel.text = @"缓存";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
