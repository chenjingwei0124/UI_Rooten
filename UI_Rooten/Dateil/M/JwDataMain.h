//
//  JwDataMain.h
//  UI_Rooten
//
//  Created by lanou on 15/11/23.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JwRecom;
@class JwMain;

@interface JwDataMain : NSObject

@property (nonatomic, strong) JwRecom *recom;
@property (nonatomic, strong) NSString *JwLast;
@property (nonatomic, strong) NSMutableArray *JwMainArr;

@property (nonatomic, strong) NSMutableArray *JwIds;
@property (nonatomic, strong) JwMain *JwMain;

@end
