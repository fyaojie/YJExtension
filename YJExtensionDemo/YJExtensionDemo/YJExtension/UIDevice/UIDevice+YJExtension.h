//
//  UIDevice+YJExtension.h
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    YJDeviceType_unknown = 0,
    YJDeviceType_iPodTouch5,
    YJDeviceType_iPodTouch6,
    YJDeviceType_iPhone4,
    YJDeviceType_iPhone4s,
    YJDeviceType_iPhone5,
    YJDeviceType_iPhone5c,
    YJDeviceType_iPhone5s,
    YJDeviceType_iPhone6,
    YJDeviceType_iPhone6Plus,
    YJDeviceType_iPhone6s,
    YJDeviceType_iPhone6sPlus,
    YJDeviceType_iPhone7,
    YJDeviceType_iPhone7Plus,
    YJDeviceType_iPhoneSE,
    YJDeviceType_iPhone8,
    YJDeviceType_iPhone8Plus,
    YJDeviceType_iPhoneX,
    YJDeviceType_iPad2,
    YJDeviceType_iPad3,
    YJDeviceType_iPad4,
    YJDeviceType_iPadAir,
    YJDeviceType_iPadAir2,
    YJDeviceType_iPad5,
    YJDeviceType_iPad6,
    YJDeviceType_iPadMini,
    YJDeviceType_iPadMini2,
    YJDeviceType_iPadMini3,
    YJDeviceType_iPadMini4,
    YJDeviceType_iPadPro9Inch,
    YJDeviceType_iPadPro12Inch,
    YJDeviceType_iPadPro12Inch2,
    YJDeviceType_iPadPro10Inch,
    YJDeviceType_homePod
} YJDeviceType;

@interface UIDevice (YJExtension)

+ (NSString *)yj_deviceIdentifier;

+ (YJDeviceType)yj_deviceTypeWithIdentifier:(NSString *)identifier;

+ (YJDeviceType)yj_deviceType;

+ (NSString *)yj_description;

+ (BOOL)yj_isPod;

+ (BOOL)yj_isPhone;

+ (BOOL)yj_isPad;

/**
 屏幕宽高比
 */
+ (double)yj_screenRatio;

/**
 亮度
 */
+ (int)yj_screenBrightness;
/**
 是否是模拟器
 */
+ (BOOL)yj_isSimulator;

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
 * 手机别名： 用户定义的名称 例如：xxx的iphone
 */
+ (NSString *)yj_name;

/**
 * 设备名称 例如：iOS
 */
+ (NSString *)yj_systemName;

/**
 * 手机系统版本 例如：10.3
 */
+ (NSString *)yj_systemVersion;

/**
 * 手机型号 例如：iPhone
 */
+ (NSString *)yj_model;

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
