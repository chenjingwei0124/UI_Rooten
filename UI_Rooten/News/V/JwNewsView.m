//
//  JwNewsView.m
//  UI_Rooten
//
//  Created by lanou on 15/11/21.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwNewsView.h"
#import "JwNewsCell.h"
#import "JwAcer.h"
#import "JwRecom.h"
#import "UIView+Extension.h"

@interface JwNewsView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation JwNewsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableV = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, frame.size.width, frame.size.height)) style:(UITableViewStylePlain)];
        self.tableV.delegate = self;
        self.tableV.dataSource = self;
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
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    
    JwRecom *recom = self.array[indexPath.row];
    
    CGRect tip = [recom.des boundingRectWithSize:CGSizeMake(self.width - 40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return tip.size.height + 140;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.newsSelectBlock(self.array[indexPath.row]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"reuseIdentifier";
    JwNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[JwNewsCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.backgroundColor = JwCellBColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.recom = self.array[indexPath.row];
    
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
