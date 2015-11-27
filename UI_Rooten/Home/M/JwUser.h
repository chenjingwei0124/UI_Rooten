//
//  JwUser.h
//  UI_Rooten
//
//  Created by lanou on 15/11/20.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JwUser : NSObject

@property (nonatomic, strong) NSString *JwUserId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;

- (instancetype)init:(id)value;

@end
