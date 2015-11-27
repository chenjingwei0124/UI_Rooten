//
//  JwNoveView.m
//  UI_Rooten
//
//  Created by lanou on 15/11/20.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwNoveView.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
#import "JwAcer.h"
#import "JwRecom.h"
#import "JwUser.h"
#import "JwTags.h"

@interface JwNoveView ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *desL;

@property (nonatomic, strong) UIImageView *autV;
@property (nonatomic, strong) UILabel *autL;

@end

@implementation JwNoveView

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.imageV = [[UIImageView alloc] init];
        [self addSubview:self.imageV];
        
        self.titleL = [[UILabel alloc] init];
        [self addSubview:self.titleL];
        
        self.desL = [[UILabel alloc] init];
        [self addSubview:self.desL];
        
        self.autV = [[UIImageView alloc] init];
        [self addSubview:self.autV];
        
        self.autL = [[UILabel alloc] init];
        [self addSubview:self.autL];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageV.frame = CGRectMake(0, 0, self.size.width/3, self.size.height);
    
    self.titleL.frame = CGRectMake(self.imageV.x + self.imageV.width + 10, self.imageV.y, self.size.width - self.imageV.width - 10, 20);
    self.titleL.textColor = [UIColor blackColor];
    self.titleL.font = [UIFont systemFontOfSize:14];
    
    self.desL.frame = CGRectMake(self.titleL.x, self.titleL.y + self.titleL.height, self.titleL.width, self.imageV.height - 40);
    self.desL.textColor = JwTextDColor;
    self.desL.font = [UIFont systemFontOfSize:12];
    self.desL.numberOfLines = 0;
    
    self.autV.frame = CGRectMake(self.titleL.x, self.desL.y + self.desL.height, 20, 20);
    self.autV.layer.cornerRadius = self.autV.width/2;
    
    self.autL.frame = CGRectMake(self.autV.x + self.autV.width + 5, self.autV.y, self.titleL.width - self.autV.width - 5, 20);
    self.autL.textColor = JwTextDColor;
    self.autL.font = [UIFont systemFontOfSize:12];

}

- (void)setRecom:(JwRecom *)recom{
    _recom = recom;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:self.recom.JwImage] placeholderImage:nil];
    self.titleL.text = self.recom.title;
    self.desL.text = self.recom.description2;
    [self.autV sd_setImageWithURL:[NSURL URLWithString:self.recom.JwUser.icon] placeholderImage:nil];
    self.autL.text = self.recom.JwUser.name;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noveView" object:self.recom];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
