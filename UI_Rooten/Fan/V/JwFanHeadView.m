//
//  JwFanHeadView.m
//  UI_Rooten
//
//  Created by lanou on 15/11/21.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwFanHeadView.h"
#import "UIView+Extension.h"
#import "JwAcer.h"

@interface JwFanHeadView ()

@end

@implementation JwFanHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.oneB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.oneB.frame = CGRectMake(0, 10, 60, 30);
        self.oneB.centerX = frame.size.width/6;
        self.oneB.layer.cornerRadius = 3;
        [self addSubview:self.oneB];
        
        self.twoB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.twoB.frame = CGRectMake(0, 10, 60, 30);
        self.twoB.centerX = frame.size.width/2;
        self.twoB.layer.cornerRadius = 3;
        [self addSubview:self.twoB];
        
        self.theB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.theB.frame = CGRectMake(0, 10, 60, 30);
        self.theB.centerX = frame.size.width*5/6;
        self.theB.layer.cornerRadius = 3;
        [self addSubview:self.theB];
        
        [self.oneB setTitle:@"全部" forState:(UIControlStateNormal)];
        [self.twoB setTitle:@"二次元" forState:(UIControlStateNormal)];
        [self.theB setTitle:@"三次元" forState:(UIControlStateNormal)];
        [self.oneB setTitleColor:JwTextHColor forState:(UIControlStateNormal)];
        [self.twoB setTitleColor:JwTextHColor forState:(UIControlStateNormal)];
        [self.theB setTitleColor:JwTextHColor forState:(UIControlStateNormal)];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
