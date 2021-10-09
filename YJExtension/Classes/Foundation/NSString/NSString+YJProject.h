//
//  NSString+YJProject.h
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YJProject)
/**
 * 当前App的基本信息字典
 */
+ (NSDictionary *)yj_appInfo;

/**
 包名
 */
+ (NSString *)yj_bundleId;
/**
 * app名称
 */
+ (NSString *)yj_appName;

/**
 * app版本
 */
+ (NSString *)yj_appVersion;

/**
 * app build版本
 */
+ (NSString *)yj_appBuild;
@end
