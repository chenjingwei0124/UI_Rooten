//
//  JwRankView.h
//  UI_Rooten
//
//  Created by lanou on 15/11/21.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JwArticle;

typedef void(^rankCellSelectBlock)(JwArticle *article);

@interface JwRankView : UIView

@property (nonatomic, copy) rankCellSelectBlock rankCellSelectBlock;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) UITableView *tableV;
@end
