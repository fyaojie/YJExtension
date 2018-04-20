//
//  UIDevice+YJExtension.h
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (YJExtension)

/**
 *  获取手机内存总量, 返回的是字节数
 *
 *  @return 返回字节数
 */
+ (NSUInteger)yj_totalMemoryBytes;


/**
 *  获取手机可用内存, 返回的是字节数
 *
 *  @return 字节数
 */
+ (NSUInteger)yj_freeMemoryBytes;

/**
 *  获取手机硬盘空闲空间, 返回的是字节数
 *
 *  @return 字节数
 */
+ (long long)yj_freeDiskSpaceBytes;


/**
 *  获取手机硬盘总空间, 返回的是字节数
 *
 *  @return 返回字节总数
 */
+ (long long)yj_totalDiskSpaceBytes;

/**
 获取当前设备名
 
 @return 例如：iphone 6
 */
+ (NSString *)yj_deviceModelName;


/**
 是否是模拟器
 */
+ (BOOL)yj_isSimulator;

/**
 * 手机别名： 用户定义的名称 例如：xxx的iphone
 */
+ (NSString *)yj_phoneAliases;

/**
 * 设备名称 例如：iOS
 */
+ (NSString *)yj_deviceName;

/**
 * 手机系统版本 例如：10.3
 */
+ (NSString *)yj_systemVersion;

/**
 * 手机型号 例如：iPhone
 */
+ (NSString *)yj_phoneModel;

/**
 * 地方型号  （国际化区域名称）
 */
+ (NSString *)yj_localizedModel;

/**
 * 获取设备唯一标识符 例如：02FA87BD-B8A9-48AD-A9F2-93376C80AF33
 */
+ (NSString *)yj_UUID;

/**
 * 获取内网IP 例如：192.168.1.104
 */
+ (NSString *)yj_deviceIPAdress;

@end
