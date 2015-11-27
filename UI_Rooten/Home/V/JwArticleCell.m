//
//  JwArticleCell.m
//  UI_Rooten
//
//  Created by lanou on 15/11/21.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwArticleCell.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "UIImageView+WebCache.h"
#import "JwArticle.h"

@interface JwArticleCell ()

@property (nonatomic, strong) UIView *backV;

@property (nonatomic, strong) UIImageView *imageV;
@end

@implementation JwArticleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backV = [[UIView alloc] init];
        [self.contentView addSubview:self.backV];
        
        self.imageV = [[UIImageView alloc] init];
        [self.backV addSubview:self.imageV];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.backV.frame = CGRectMake(7, 7, self.contentView.width - 14, self.contentView.height - 10);
    self.backV.backgroundColor = [UIColor whiteColor];
    
    self.imageV.frame = CGRectMake(0, 0, self.backV.width, self.backV.height - 5);
}

- (void)setArticle:(JwArticle *)article{
    _article = article;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:self.article.icon] placeholderImage:nil];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
