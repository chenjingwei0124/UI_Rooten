//
//  JwHomeView.m
//  UI_Rooten
//
//  Created by lanou on 15/11/20.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwHomeView.h"
#import "UIView+Extension.h"
#import "JwHomeCell.h"
#import "JwNoveCell.h"
#import "JwAcer.h"
#import "JwArticleCell.h"

@interface JwHomeView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation JwHomeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableV = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, frame.size.width, frame.size.height)) style:(UITableViewStylePlain)];
        self.tableV.delegate = self;
        self.tableV.dataSource = self;
        self.tableV.backgroundColor = JwCellBColor;
        self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.tableV];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return (tableView.width - 54)/3 + 85;
    }
    if (indexPath.row == 1) {
        return 374;
    }
    else{
        return 130;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *identifier = @"albumsCell";
        JwHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[JwHomeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        }
        cell.backgroundColor = JwCellBColor;
        cell.array = self.albmusArr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.oneB addTarget:self action:@selector(homeCellBAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell.twoB addTarget:self action:@selector(homeCellBAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell.threB addTarget:self action:@selector(homeCellBAction:) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    }
    if (indexPath.row == 1) {
        static NSString *identifier = @"noveCell";
        JwNoveCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[JwNoveCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        }
        cell.backgroundColor = JwCellBColor;
        cell.array = self.noveArr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        static NSString *identifier = @"homeCell";
        JwArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[JwArticleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        }
        cell.backgroundColor = JwCellBColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.article = self.articArr[indexPath.row - 2];
        return cell;
    }
}

- (void)homeCellBAction:(UIButton *)button{
    self.homeCellBBlock(self.albmusArr[[button.titleLabel.text integerValue]]);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        self.homeCellSelectBlock();
    }
    if (indexPath.row == 1) {
        self.noveCellSelectBlock();
    }
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
        self.articleCellSelectBlock(self.articArr[indexPath.row - 2]);
    }
}

- (void)setAlbmusArr:(NSArray *)albmusArr{
    _albmusArr = albmusArr;
    
    [self.tableV reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
