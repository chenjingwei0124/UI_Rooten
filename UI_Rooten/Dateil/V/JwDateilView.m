//
//  JwDateilView.m
//  UI_Rooten
//
//  Created by lanou on 15/11/21.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwDateilView.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "UIButton+WebCache.h"
#import "JwRecom.h"
#import "JwUser.h"
#import "JwTags.h"

@interface JwDateilView ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *autouL;
@property (nonatomic, strong) UILabel *autL;

@property (nonatomic, strong) UILabel *cataL;

@property (nonatomic, strong) UILabel *dataL;
@property (nonatomic, strong) UILabel *desL;

@end

@implementation JwDateilView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 0, frame.size.width, frame.size.height))];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.bounces = YES;
        [self addSubview:self.scrollView];
        
        self.autImgB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.autImgB.frame = CGRectMake(20, 20, 50, 50);
        self.autImgB.layer.cornerRadius = self.autImgB.width/2;
        self.autImgB.layer.masksToBounds = YES;
        [self.scrollView addSubview:self.autImgB];
        
        self.autouL = [[UILabel alloc] initWithFrame:(CGRectMake(self.autImgB.x + self.autImgB.width + 5, self.autImgB.y, self.scrollView.width/2 - self.autImgB.x - self.autImgB.width - 5, 20))];
        self.autouL.text = @"作者:";
        self.autouL.textColor = JwTextHColor;
        self.autouL.font = [UIFont systemFontOfSize:13];
        [self.scrollView addSubview:self.autouL];
        
        self.autL = [[UILabel alloc] initWithFrame:(CGRectMake(self.autouL.x, self.autouL.y + self.autouL.height, self.autouL.width, 30))];
        self.autL.textColor = JwColor(147, 86, 60);
        self.autL.font = [UIFont systemFontOfSize:16];
        [self.scrollView addSubview:self.autL];
        
        self.cataL = [[UILabel alloc] initWithFrame:(CGRectMake(self.scrollView.width - 60, self.autL.y + 10, 40, 20))];
        self.cataL.text = @"目录";
        self.cataL.textColor = JwTextHColor;
        self.cataL.font = [UIFont systemFontOfSize:14];
        self.cataL.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:self.cataL];
        
        self.cataB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.cataB.frame = (CGRectMake(0, self.cataL.y - 25, 20, 20));
        [self.cataB setBackgroundImage:[UIImage imageNamed:@"iconfont-mulu"] forState:(UIControlStateNormal)];
        self.cataB.centerX = self.cataL.centerX;
        [self.scrollView addSubview:self.cataB];
        
        UIView *linView = [[UIView alloc] initWithFrame:(CGRectMake(10, self.autImgB.y + self.autImgB.height + 10, self.scrollView.width - self.autImgB.x, 2))] ;
        linView.backgroundColor = JwCellBColor;
        [self.scrollView addSubview:linView];
        
        self.dataL = [[UILabel alloc] initWithFrame:(CGRectMake(self.autImgB.x, linView.y + linView.height + 20, self.scrollView.width - self.autImgB.x * 2, 30))];
        self.dataL.textColor = [UIColor blackColor];
        self.dataL.font = [UIFont systemFontOfSize:15];
        [self.scrollView addSubview:self.dataL];
        
        self.desL = [[UILabel alloc] initWithFrame:(CGRectMake(self.dataL.x, self.dataL.y + self.dataL.height + 10, self.dataL.width, 0))];
        self.desL.textColor = JwTextHColor;
        self.desL.font = [UIFont systemFontOfSize:15];
        self.desL.numberOfLines = 0;
        [self.scrollView addSubview:self.desL];
        
    }
    return self;
}

- (void)setRecom:(JwRecom *)recom{
    _recom = recom;
    
    [self.autImgB sd_setBackgroundImageWithURL:[NSURL URLWithString:self.recom.JwUser.icon] forState:(UIControlStateNormal) placeholderImage:nil];
    
    self.autL.text = self.recom.JwUser.name;
    
    self.dataL.text = [NSString stringWithFormat:@"字数:%@ 章节:%@", self.recom.Jwlength, self.recom.JwArticle_Nmu];
    
    self.desL.text = [NSString stringWithFormat:@"简介:%@", self.recom.des];
    
    [self.desL sizeToFit];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, self.desL.height + self.autImgB.height + self.dataL.height + 70);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
