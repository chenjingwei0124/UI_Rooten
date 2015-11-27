//
//  JwNewsCell.m
//  UI_Rooten
//
//  Created by lanou on 15/11/21.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwNewsCell.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "JwRecom.h"
#import "JwUser.h"
#import "UIImageView+WebCache.h"

@interface JwNewsCell ()

@property (nonatomic, strong) UIView *backV;

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *autL;
@property (nonatomic, strong) UILabel *dateL;
@property (nonatomic, strong) UILabel *desL;
@end

@implementation JwNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backV = [[UIView alloc] init];
        [self.contentView addSubview:self.backV];
        
        self.imageV = [[UIImageView alloc] init];
        [self.backV addSubview:self.imageV];
        
        self.titleL = [[UILabel alloc] init];
        [self.backV addSubview:self.titleL];
        
        self.autL = [[UILabel alloc] init];
        [self.backV addSubview:self.autL];
        
        self.dateL = [[UILabel alloc] init];
        [self.backV addSubview:self.dateL];
        
        self.desL = [[UILabel alloc] init];
        [self.backV addSubview:self.desL];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.backV.frame = CGRectMake(10, 10, self.contentView.width - 20, self.contentView.height - 10);
    self.backV.backgroundColor = [UIColor whiteColor];
    
    self.imageV.frame = CGRectMake(10, 10, 130, 100);
    
    self.titleL.frame = CGRectMake(self.imageV.x + self.imageV.width + 10, self.imageV.y, self.backV.width - self.imageV.x - self.imageV.width - 20, self.imageV.height/3);
    self.titleL.textColor = [UIColor blackColor];
    self.titleL.font = [UIFont systemFontOfSize:18];
    
    self.autL.frame = CGRectMake(self.titleL.x, self.titleL.y + self.titleL.height, self.titleL.width, self.titleL.height);
    self.autL.textColor = JwTextDColor;
    self.autL.font = [UIFont systemFontOfSize:14];
    
    self.dateL.frame = CGRectMake(self.autL.x, self.autL.y + self.autL.height, self.autL.width, self.autL.height);
    self.dateL.font = [UIFont systemFontOfSize:14];
    self.dateL.textColor = JwTextDColor;
    
    self.desL.frame = CGRectMake(self.imageV.x, self.imageV.y + self.imageV.height + 10, self.backV.width - self.imageV.x * 2, 0);
    self.desL.textColor = JwTextHColor;
    self.desL.font = [UIFont systemFontOfSize:15];
    self.desL.numberOfLines = 0;
    [self.desL sizeToFit];
}

- (void)setRecom:(JwRecom *)recom{
    _recom = recom;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:self.recom.JwImage] placeholderImage:nil];
    
    self.titleL.text = self.recom.title;
    
    self.autL.text = [NSString stringWithFormat:@"作者:%@", self.recom.JwUser.name];
    
    NSString *finStr = @"";
    if ([self.recom.finished isEqualToString:@"0"]) {
        finStr = @"连载中";
    }else{
        finStr = @"已完结";
    }
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:[NSDate dateWithTimeIntervalSince1970:[self.recom.JwUpdate_time integerValue]]];
                                   
    if (timeInterval < 60) {
        self.dateL.text = [NSString stringWithFormat:@"刚刚"];
    }else if (60 < timeInterval && timeInterval < 3600){
        self.dateL.text = [NSString stringWithFormat:@"%.f分钟前 %@", timeInterval / 60, finStr];
    }else if (timeInterval > 3600 && timeInterval < 3600 * 24){
        self.dateL.text = [NSString stringWithFormat:@"%.f小时前 %@",  timeInterval / 60 / 60, finStr];
    }else if (timeInterval > 3600 * 24){
        self.dateL.text = [NSString stringWithFormat:@"%.f天之前 %@",timeInterval / 60 / 60 / 24, finStr];
    }
    
    self.desL.text = self.recom.des;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
