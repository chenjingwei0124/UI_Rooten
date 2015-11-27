//
//  JwTags.m
//  UI_Rooten
//
//  Created by lanou on 15/11/20.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwTags.h"

@implementation JwTags

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.JwId = [NSString stringWithFormat:@"%@", value];
    }
    if ([key isEqualToString:@"count"]) {
        self.JwCount = [NSString stringWithFormat:@"%@", value];
    }
}

- (instancetype)init:(id)value{
    self = [super init];
    if (self!= nil) {
        [self setValuesForKeysWithDictionary:value];
    }
    return self;
}

@end
