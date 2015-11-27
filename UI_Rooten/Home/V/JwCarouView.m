//
//  JwCarouView.m
//  UI_Rooten
//
//  Created by lanou on 15/11/20.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwCarouView.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
#import "JwCarou.h"

@interface JwCarouView ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollV;
@property (nonatomic, strong)UIPageControl *pageVC;
@property (nonatomic, strong)NSTimer *timer;
@end

@implementation JwCarouView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.scrollV = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 0, frame.size.width, frame.size.height))];
        self.scrollV.delegate = self;
        self.scrollV.scrollEnabled = YES;
        self.scrollV.pagingEnabled = YES;
        self.scrollV.showsHorizontalScrollIndicator = NO;
        self.scrollV.showsVerticalScrollIndicator = NO;
        self.scrollV.bounces = YES;
        [self addSubview:self.scrollV];
        
        self.pageVC = [[UIPageControl alloc] initWithFrame:(CGRectMake(0, self.scrollV.height - 40, self.scrollV.width, 40))];
        [self addSubview:self.pageVC];
        
    }
    return self;
}

- (void)timerChange:(NSTimer *)time{
    
    NSInteger page = self.scrollV.contentOffset.x / self.scrollV.width;
    
    if (page == self.array.count - 1) {
        [self.scrollV setContentOffset:(CGPointZero) animated:NO];
        [self.scrollV setContentOffset:(CGPointMake(self.scrollV.width, 0)) animated:YES];
    }
    else{
        [self.scrollV setContentOffset:(CGPointMake(self.scrollV.contentOffset.x + self.scrollV.width, 0)) animated:YES];
    }
    self.pageVC.currentPage = self.scrollV.contentOffset.x / self.scrollV.width;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint nowPoint = self.scrollV.contentOffset;
    if (nowPoint.x > (self.array.count - 1) * self.scrollV.width) {
        [self.scrollV setContentOffset:(CGPointZero) animated:NO];
    }
    if (nowPoint.x < 0) {
        [self.scrollV setContentOffset:(CGPointMake((self.array.count - 1) * self.scrollV.width, 0)) animated:NO];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSUInteger page = scrollView.contentOffset.x / scrollView.width;
    if (page == self.array.count || page == 0) {
        self.pageVC.currentPage = self.array.count - 1;
    }else{
        self.pageVC.currentPage = page - 1;
    }
}

- (void)setArray:(NSArray *)array{
    _array = array;
    
    self.scrollV.contentSize = CGSizeMake(self.array.count * self.scrollV.width, self.scrollV.height);
    self.scrollV.contentOffset = CGPointMake(self.scrollV.width, 0);
    
    for (int i = 0; i < self.array.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:(CGRectMake(self.scrollV.width * i, 0, self.scrollV.width, self.scrollV.height))];
        JwCarou *carou = self.array[i];
        [img sd_setImageWithURL:[NSURL URLWithString:carou.img] placeholderImage:nil];
        [self.scrollV addSubview:img];
    }
    
    self.pageVC.numberOfPages = self.array.count - 1;
    self.pageVC.currentPage = 0;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerChange:) userInfo:nil repeats:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
