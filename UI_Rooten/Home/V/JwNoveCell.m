//
//  JwNoveCell.m
//  UI_Rooten
//
//  Created by lanou on 15/11/20.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwNoveCell.h"
#import "JwAcer.h"
#import "UIView+Extension.h"
#import "JwRecom.h"
#import "JwNoveView.h"

@interface JwNoveCell ()

@property (nonatomic, strong) UIView *backV;

@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *moreL;
@property (nonatomic, strong) UIImageView *moreV;

@property (nonatomic, strong) JwNoveView *oneNov;
@property (nonatomic, strong) JwNoveView *twoNov;
@property (nonatomic, strong) JwNoveView *theNov;

@property (nonatomic, strong) UIView *oneV;
@property (nonatomic, strong) UIView *twoV;

@end

@implementation JwNoveCell

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
        
        self.oneNov = [[JwNoveView alloc] init];
        [self.backV addSubview:self.oneNov];
        
        self.twoNov = [[JwNoveView alloc] init];
        [self.backV addSubview:self.twoNov];
        
        self.theNov = [[JwNoveView alloc] init];
        [self.backV addSubview:self.theNov];
        
        self.oneV = [[UIView alloc] init];
        [self.backV addSubview:self.oneV];
        
        self.twoV = [[UIView alloc] init];
        [self.backV addSubview:self.twoV];

    
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.backV.frame = CGRectMake(7, 7, self.contentView.width - 14, self.contentView.height - 10);
    self.backV.backgroundColor = [UIColor whiteColor];
    
    self.titleL.frame = CGRectMake(10, 10, 100, 20);
    self.titleL.text = @"推荐小说";
    self.titleL.textColor = JwTextHColor;
    self.titleL.font = [UIFont systemFontOfSize:14 weight:0.2];
    
    self.moreV.frame = CGRectMake(self.backV.width + self.backV.x - 30, self.titleL.y, 20, 20);
    self.moreV.image = [UIImage imageNamed:@"iconfont-youjiantou"];
    
    self.moreL.frame = CGRectMake(self.moreV.x - 30, self.moreV.y, 30, 20);
    self.moreL.text = @"更多";
    self.moreL.textColor = JwTextDColor;
    self.moreL.font = [UIFont systemFontOfSize:12];
    
    self.oneNov.frame = CGRectMake(self.titleL.x, self.titleL.y + self.titleL.height + 10, self.backV.width - self.titleL.x * 2, 90);
    
    self.oneV.frame = CGRectMake(self.oneNov.x, self.oneNov.y + self.oneNov.height + 10, self.oneNov.width, 2);
    self.oneV.backgroundColor = JwCellBColor;
    
    self.twoNov.frame = CGRectMake(self.titleL.x, self.oneV.y + self.oneV.height + 10, self.backV.width - self.titleL.x * 2, 90);

    self.twoV.frame = CGRectMake(self.twoNov.x, self.twoNov.y + self.twoNov.height + 10, self.twoNov.width, 2);
    self.twoV.backgroundColor = JwCellBColor;
    
    self.theNov.frame = CGRectMake(self.titleL.x, self.twoV.y + self.twoV.height + 10, self.backV.width - self.titleL.x * 2, 90);

}

- (void)setArray:(NSArray *)array{
    _array = array;
    
    self.oneNov.recom = self.array[0];
    self.twoNov.recom = self.array[1];
    self.theNov.recom = self.array[2];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
