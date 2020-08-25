//
//  NSString+YJProject.m
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import "NSString+YJProject.h"

@implementation NSString (YJProject)
#pragma mark 当前App的基本信息字典
+ (NSDictionary *)yj_appInfo {
    return [[NSBundle mainBundle] infoDictionary];
}

#pragma mark app名称
+ (NSString *)yj_appName {
    return [[self yj_appInfo] objectForKey:@"CFBundleDisplayName"];
}

#pragma mark 包名
+ (NSString *)yj_bundleId {
    return [[self yj_appInfo] objectForKey:@"CFBundleIdentifier"];
}

#pragma mark app版本
+ (NSString *)yj_appVersion {
    return [[self yj_appInfo] objectForKey:@"CFBundleShortVersionString"];
}
#pragma mark app build版本
+ (NSString *)yj_appBuild {
    return [[self yj_appInfo] objectForKey:@"CFBundleVersion"];
}
@end
