//
//  JwMain.h
//  UI_Rooten
//
//  Created by lanou on 15/11/23.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JwMain : NSObject
- (instancetype)init:(id)value;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *JwUpdata_time;
@property (nonatomic, strong) NSString *JwLength;
@property (nonatomic, strong) NSString *JwId;

@end
