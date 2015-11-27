//
//  JwHomeCell.m
//  UI_Rooten
//
//  Created by lanou on 15/11/20.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwHomeCell.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "JwAlbums.h"
#import "UIButton+WebCache.h"

@interface JwHomeCell ()

@property (nonatomic, strong) UIView *backV;

@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *moreL;
@property (nonatomic, strong) UIImageView *moreV;


@property (nonatomic, strong) UILabel *oneL;


@property (nonatomic, strong) UILabel *twoL;


@property (nonatomic, strong) UILabel *threL;
@end

@implementation JwHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backV = [[UIView alloc] init];
        [self.contentView addSubview:self.backV];
        
        self.titleL = [[UILabel alloc] init];
        [self.backV addSubview:self.titleL];
        
        self.moreL = [[UILabel alloc] init];
        [self.backV addSubview:self.moreL];
        
        self.moreV = [[UIImageView alloc] init];
        [self.backV addSubview:self.moreV];
        
        self.oneB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.backV addSubview:self.oneB];
        self.oneL = [[UILabel alloc] init];
        [self.backV addSubview:self.oneL];
        
        self.twoB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.backV addSubview:self.twoB];
        self.twoL = [[UILabel alloc] init];
        [self.backV addSubview:self.twoL];
        
        self.threB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.backV addSubview:self.threB];
        self.threL = [[UILabel alloc] init];
        [self.backV addSubview:self.threL];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.backV.frame = CGRectMake(7, 7, self.contentView.width - 14, self.contentView.height - 10);
    self.backV.backgroundColor = [UIColor whiteColor];
    
    self.titleL.frame = CGRectMake(10, 10, 100, 20);
    self.titleL.text = @"活动专题";
    self.titleL.textColor = JwTextHColor;
    self.titleL.font = [UIFont systemFontOfSize:14 weight:0.2];
    
    self.moreV.frame = CGRectMake(self.backV.width + self.backV.x - 30, self.titleL.y, 20, 20);
    self.moreV.image = [UIImage imageNamed:@"iconfont-youjiantou"];
    
    self.moreL.frame = CGRectMake(self.moreV.x - 30, self.moreV.y, 30, 20);
    self.moreL.text = @"更多";
    self.moreL.textColor = JwTextDColor;
    self.moreL.font = [UIFont systemFontOfSize:12];
    
    CGFloat Vspac = (self.backV.width - 40)/3;
    
    self.oneB.frame = CGRectMake(10, self.titleL.y + self.titleL.height + 10, Vspac, Vspac);
    self.oneL.frame = CGRectMake(self.oneB.x, self.oneB.y + self.oneB.height + 5, self.oneB.width, 20);
    self.oneL.textColor = JwTextHColor;
    self.oneL.font = [UIFont systemFontOfSize:13 weight:0.1];
    self.oneL.textAlignment = NSTextAlignmentCenter;
    
    self.twoB.frame = CGRectMake(self.oneB.x + self.oneB.width + 10, self.oneB.y, Vspac, Vspac);
    self.twoL.frame = CGRectMake(self.twoB.x, self.twoB.y + self.twoB.height + 5, self.twoB.width, 20);
    self.twoL.textColor = JwTextHColor;
    self.twoL.font = [UIFont systemFontOfSize:13 weight:0.1];
    self.twoL.textAlignment = NSTextAlignmentCenter;
    
    self.threB.frame = CGRectMake(self.twoB.x + self.twoB.width + 10, self.oneB.y, Vspac, Vspac);
    self.threL.frame = CGRectMake(self.threB.x, self.threB.y + self.threB.height + 5, self.threB.width, 20);
    self.threL.textColor = JwTextHColor;
    self.threL.font = [UIFont systemFontOfSize:13 weight:0.1];
    self.threL.textAlignment = NSTextAlignmentCenter;

    self.oneB.titleLabel.text = @"0";
    self.twoB.titleLabel.text = @"1";
    self.threB.titleLabel.text = @"2";
}

- (void)setArray:(NSArray *)array{
    _array = array;
    
    JwAlbums *one = self.array[0];
    [self.oneB sd_setBackgroundImageWithURL:[NSURL URLWithString:one.cover] forState:(UIControlStateNormal)];
    self.oneL.text = one.name;
    
    JwAlbums *two = self.array[1];
    [self.twoB sd_setBackgroundImageWithURL:[NSURL URLWithString:two.cover] forState:(UIControlStateNormal)];
    self.twoL.text = two.name;
    
    JwAlbums *thre = self.array[2];
    [self.threB sd_setBackgroundImageWithURL:[NSURL URLWithString:thre.cover] forState:(UIControlStateNormal)];
    self.threL.text = thre.name;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
