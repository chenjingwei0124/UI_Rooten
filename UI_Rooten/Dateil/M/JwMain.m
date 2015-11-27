//
//  JwMain.m
//  UI_Rooten
//
//  Created by lanou on 15/11/23.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwMain.h"

@implementation JwMain

- (instancetype)init:(id)value{
    self = [super init];
    if (self!= nil) {
        [self setValuesForKeysWithDictionary:value];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"update_time"]) {
        self.JwUpdata_time = [value stringValue];
    }
    if ([key isEqualToString:@"length"]) {
        self.JwLength = [value stringValue];
    }
    if ([key isEqualToString:@"id"]) {
        self.JwId = [value stringValue];
    }
}

@end
