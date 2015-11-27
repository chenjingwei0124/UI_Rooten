//
//  JwUser.m
//  UI_Rooten
//
//  Created by lanou on 15/11/20.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwUser.h"

@implementation JwUser

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"userId"]) {
        self.JwUserId = [value stringValue];
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
