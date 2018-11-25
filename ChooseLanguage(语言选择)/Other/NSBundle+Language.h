//
//  NSBundle+Language.h
//  PlayCarParadise
//
//  Created by liuyujia on 2018/4/11.
//  Copyright © 2018年 MyApp. All rights reserved.
//  动态的切换string文件

#import <Foundation/Foundation.h>

@interface NSBundle (Language)
///设置语言
+ (void)setLanguage:(NSString *)language;
@end
