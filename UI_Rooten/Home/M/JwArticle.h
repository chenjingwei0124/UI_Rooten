//
//  JwArticle.h
//  UI_Rooten
//
//  Created by lanou on 15/11/21.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JwArticle : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *updated_at;

@property (nonatomic, strong) NSString *JwId;

@end
