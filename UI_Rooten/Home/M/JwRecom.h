//
//  JwRecom.h
//  UI_Rooten
//
//  Created by lanou on 15/11/20.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwUser.h"
#import "JwTags.h"

@interface JwRecom : NSObject

- (instancetype)init:(id)value;

@property (nonatomic, strong) NSString *JwImage;
@property (nonatomic, strong) NSString *JwId;
@property (nonatomic, strong) JwUser *JwUser;
@property (nonatomic, strong) NSMutableArray *JwTagsArr;
@property (nonatomic, strong) NSString *JwArticle_Nmu;

@property (nonatomic, strong) NSString *JwUpdate_time;
@property (nonatomic, strong) NSString *Jwlength;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSString *author;

@property (nonatomic, strong) NSString *read_times;

@property (nonatomic, strong) NSString *add_time;
@property (nonatomic, strong) NSString *finished;

@property (nonatomic, strong) NSString *collect_times;
@property (nonatomic, strong) NSString *comment_times;

@property (nonatomic, strong) NSString *description2;
@property (nonatomic, strong) NSString *tags2;

@property (nonatomic, strong) NSString *JwTids;
@end
