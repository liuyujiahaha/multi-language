//
//  LanguageTool.m
//  PlayCarParadise
//
//  Created by liuyujia on 2018/5/11.
//  Copyright © 2018年 MyApp. All rights reserved.
//

#import "LanguageTool.h"

@implementation LanguageTool

-(NSString*)getPreferredLanguage{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString * preferredLang = [allLanguages objectAtIndex:0];
    if ([preferredLang containsString:@"en"]) {
        preferredLang = @"en";
    }
    return preferredLang;
}

+(NSString*)getLanguageStr{
    
    NSLock *lock = [[NSLock alloc]init];
    [lock lock];
    
    NSString *langStr = UDTakeData(kChangeLanguage)?UDTakeData(kChangeLanguage):@"";
    if ([langStr isEqualToString:@""]) {
        langStr = [[[LanguageTool alloc]init] getPreferredLanguage];
    }
    [lock unlock];
    return langStr;
}

+(BOOL)isEnglish{
    BOOL isEnglish = [[LanguageTool getLanguageStr] containsString:@"en"];
    if (isEnglish) {
        return YES;
    }
        return NO;
}

@end
