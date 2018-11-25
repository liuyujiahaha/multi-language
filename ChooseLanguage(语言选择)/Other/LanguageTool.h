//
//  LanguageTool.h
//  PlayCarParadise
//
//  Created by liuyujia on 2018/5/11.
//  Copyright © 2018年 CarFun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageTool : NSObject
//返回当前系统语言
//+(NSString*)getPreferredLanguage;
//返回当前选中的系统语言 如果没有则返回系统默认的语言
+(NSString *)getLanguageStr;
+(BOOL)isEnglish;
@end
