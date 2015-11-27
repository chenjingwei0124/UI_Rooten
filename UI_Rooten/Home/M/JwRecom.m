//
//  JwRecom.m
//  UI_Rooten
//
//  Created by lanou on 15/11/20.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwRecom.h"

@implementation JwRecom

- (instancetype)init:(id)value{
    self = [super init];
    if (self!= nil) {
        [self setValuesForKeysWithDictionary:value];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.JwId = [value stringValue];
    }
    if ([key isEqualToString:@"images"]) {
        NSArray *arr = value;
        NSDictionary *dic = arr[0];
        self.JwImage = [dic objectForKey:@"imgUrl"];
    }
    if ([key isEqualToString:@"user"]) {
        self.JwUser = [[JwUser alloc] init:value];
    }
    
    if ([key isEqualToString:@"update_time"]) {
        self.JwUpdate_time = [value stringValue];
    }
    if ([key isEqualToString:@"length"]) {
        self.Jwlength = [value stringValue];
    }
    if ([key isEqualToString:@"article_num"]) {
        self.JwArticle_Nmu = [value stringValue];
    }

    if ([key isEqualToString:@"tags"]) {
        NSArray *arr = value;
        
        self.JwTagsArr = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            JwTags *tag = [[JwTags alloc] init:dic];
            [self.JwTagsArr addObject:tag];
        }
    }
}

@end
