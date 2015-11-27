//
//  JwRankView.m
//  UI_Rooten
//
//  Created by lanou on 15/11/21.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwRankView.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "JwArticle.h"
#import "JwArticleCell.h"

@interface JwRankView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation JwRankView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableV = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, frame.size.width, frame.size.height)) style:(UITableViewStylePlain)];
        self.tableV.dataSource = self;
        self.tableV.delegate = self;
        self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableV.backgroundColor = JwCellBColor;
        [self addSubview:self.tableV];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.rankCellSelectBlock(self.array[indexPath.row]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"reuseIdentifier";
    JwArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[JwArticleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.article = self.array[indexPath.row];
    cell.backgroundColor = JwCellBColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setArray:(NSArray *)array{
    _array = array;
    
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
