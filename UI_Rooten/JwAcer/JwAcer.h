//
//  JwAcer.h
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

//RGB颜色
#define JwColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define JwBColor JwColor(242, 85, 93)

#define JwBuBColor JwColor(244, 124, 131)

#define JwCellBColor JwColor(240, 240, 240)

#define JwTextHColor JwColor(100, 100, 100)

#define JwTextDColor JwColor(130, 130, 130)

#define JwLinColor JwColor(220, 220, 220)

#define JwBang ([self.JwId isEqualToString:@"完结文"] || [self.JwId isEqualToString:@"签约写手"] || [self.JwId isEqualToString:@"驻站大神"] || [self.JwId isEqualToString:@"小说新人榜"] || [self.JwId isEqualToString:@"小说新晋榜"] || [self.JwId isEqualToString:@"小说勤奋榜"] || [self.JwId isEqualToString:@"小说热度月榜"] || [self.JwId isEqualToString:@"小说热度总榜"])

//获取屏幕 宽度、高度
#define JwFrame ([UIScreen mainScreen].applicationFrame)
#define JwWidth ([UIScreen mainScreen].bounds.size.width)
#define JwHeight ([UIScreen mainScreen].bounds.size.height)