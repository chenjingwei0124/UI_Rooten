//
//  JwTags.h
//  UI_Rooten
//
//  Created by lanou on 15/11/20.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JwTags : NSObject

@property (nonatomic, strong) NSString *JwId;
@property (nonatomic, strong) NSString *JwCount;

@property (nonatomic, strong) NSString *name;

- (instancetype)init:(id)value;
@end
