//
//  JwArticleListCell.m
//  UI_Rooten
//
//  Created by lanou on 15/11/24.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwArticleListCell.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
#import "JwAlbums.h"

@interface JwArticleListCell ()

@property (nonatomic, strong)UIImageView *titleV;
@property (nonatomic, strong)UILabel *titleL;

@end

@implementation JwArticleListCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.titleV];
        
        self.titleL = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleL];
    }
    return self;
}

- (void)layoutSubviews{
    
    self.titleV.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.width);
//    self.titleV.layer.cornerRadius = self.titleV.width/2;
//    self.titleV.layer.masksToBounds = YES;
    
    self.titleL.frame = CGRectMake(0, self.titleV.height + 10, self.contentView.width, 20);
    self.titleL.font = [UIFont systemFontOfSize:14 weight:0.2];
    self.titleL.textColor = [UIColor blackColor];
    self.titleL.textAlignment = NSTextAlignmentCenter;
}

- (void)setAlbums:(JwAlbums *)albums{
    _albums = albums;
    
    [self.titleV sd_setImageWithURL:[NSURL URLWithString:self.albums.cover] placeholderImage:nil];
    self.titleL.text = self.albums.name;
}

@end
