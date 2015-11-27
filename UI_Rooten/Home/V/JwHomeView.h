//
//  JwHomeView.h
//  UI_Rooten
//
//  Created by lanou on 15/11/20.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JwAlbums;
@class JwArticle;

typedef void(^homeCellSelectBlock)(void);
typedef void(^homeCellBBlock)(JwAlbums *albums);

typedef void(^noveCellSelectBlock)(void);

typedef void(^articleCellSelectBlock)(JwArticle *article);

@interface JwHomeView : UIView

@property (nonatomic, strong) UITableView *tableV;

@property (nonatomic, strong) NSArray *albmusArr;
@property (nonatomic, strong) NSArray *noveArr;
@property (nonatomic, strong) NSArray *articArr;

@property (nonatomic, copy) homeCellSelectBlock homeCellSelectBlock;
@property (nonatomic, copy) homeCellBBlock homeCellBBlock;
@property (nonatomic, copy) noveCellSelectBlock noveCellSelectBlock;
@property (nonatomic, copy) articleCellSelectBlock articleCellSelectBlock;
@end
