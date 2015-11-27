//
//  JwNewsView.h
//  UI_Rooten
//
//  Created by lanou on 15/11/21.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JwRecom;

typedef void(^newsSelectBlock)(JwRecom *recom);

@interface JwNewsView : UIView

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, copy) newsSelectBlock newsSelectBlock;

@property (nonatomic, strong) UITableView *tableV;

@end
