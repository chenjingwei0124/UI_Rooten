//
//  JwDataMain.m
//  UI_Rooten
//
//  Created by lanou on 15/11/23.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwDataMain.h"
#import "JwRecom.h"
#import "JwMain.h"

@implementation JwDataMain

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"topic"]) {
        self.recom = [[JwRecom alloc] init:value];
    }
    if ([key isEqualToString:@"last"]) {
        self.JwLast = [value stringValue];
    }
    if ([key isEqualToString:@"detail"]) {
        self.JwMain = [[JwMain alloc] init:value];
    }
    if ([key isEqualToString:@"main"]) {
        self.JwMainArr = [NSMutableArray array];
        
        NSArray *arr = value;
        for (NSDictionary *dic in arr) {
            JwMain *main = [[JwMain alloc] init:dic];
            [self.JwMainArr addObject:main];
        }
    }
    
    if ([key isEqualToString:@"ids"]) {
        self.JwIds = [NSMutableArray array];
        
        NSArray *arr = value;
        for (int i = 0; i < arr.count; i++) {
            [self.JwIds addObject:[arr[i] stringValue]];
        }
    }

}

@end
