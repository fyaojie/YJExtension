//
//  UIDevice+YJExtension.m
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import "UIDevice+YJExtension.h"
#import <sys/sysctl.h>
#import <sys/mount.h>
#import <mach/mach.h>
#import <sys/utsname.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation UIDevice (YJExtension)

#pragma mark 获取当前设备名

+ (NSString *)yj_deviceIdentifier {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (YJDeviceType)yj_deviceTypeWithIdentifier:(NSString *)identifier {
   NSArray<NSArray<NSString *> *> *array = @[@[@"iPod5,1"],
                                              @[@"iPod7,1"],
                                              @[@"iPhone3,1", @"iPhone3,2", @"iPhone3,3"],
                                              @[@"iPhone4,1"],
                                              @[@"iPhone5,1", @"iPhone5,2"],
                                              @[@"iPhone5,3", @"iPhone5,4"],
                                              @[@"iPhone6,1", @"iPhone6,2"],
                                              @[@"iPhone7,2"],
                                              @[@"iPhone7,1"],
                                              @[@"iPhone8,1"],
                                            @[@"iPhone8,2"],
                                            @[@"iPhone9,1", @"iPhone9,3"],
                                            @[@"iPhone9,2", @"iPhone9,4"],
                                            @[@"iPhone8,4"],
                                            @[@"iPhone10,1", @"iPhone10,4"],
                                            @[@"iPhone10,2", @"iPhone10,5"],
                                            @[@"iPhone10,3", @"iPhone10,6"],
                                            @[@"iPad2,1", @"iPad2,2", @"iPad2,3", @"iPad2,4"],
                                            @[@"iPad3,1", @"iPad3,2", @"iPad3,3"],
                                            @[@"iPad3,4", @"iPad3,5", @"iPad3,6"],
                                            @[@"iPad4,1", @"iPad4,2", @"iPad4,3"],
                                            @[@"iPad5,3", @"iPad5,4"],
                                            @[@"iPad6,11", @"iPad6,12"],
                                            @[@"iPad7,5", @"iPad7,6"],
                                            @[@"iPad2,5", @"iPad2,6", @"iPad2,7"],
                                            @[@"iPad4,4", @"iPad4,5", @"iPad4,6"],
                                            @[@"iPad4,7", @"iPad4,8", @"iPad4,9"],
                                            @[@"iPad5,1", @"iPad5,2"],
                                            @[@"iPad6,3", @"iPad6,4"],
                                            @[@"iPad6,7", @"iPad6,8"],
                                            @[@"iPad7,1", @"iPad7,2"],
                                            @[@"iPad7,3", @"iPad7,4"],
                                            @[@"AudioAccessory1,1"],
                                            @[@"i386", @"x86_64"],
                                            ];
    __block YJDeviceType type = YJDeviceType_unknown;
    [array enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(NSString * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            if ([obj1 isEqualToString:identifier]) {
                type = idx + 1;
                *stop1 = YES;
                *stop = YES;
            }
        }];
    }];
    
    if (type > YJDeviceType_homePod) {
        if (type == YJDeviceType_homePod + 1) {
            NSProcessInfo *info = [[NSProcessInfo alloc] init];
            NSString *value = [info.environment objectForKey:@"SIMULATOR_MODEL_IDENTIFIER"] ?: @"iOS" ;
            return [self yj_deviceTypeWithIdentifier:value];
        }
        type = 0;
    }
    return type;
}

+ (YJDeviceType)yj_deviceType {
    return [self yj_deviceTypeWithIdentifier:[self yj_deviceIdentifier]];
}

+ (BOOL)yj_isPod {
    if ([self yj_deviceType] == YJDeviceType_iPodTouch5 || [self yj_deviceType] == YJDeviceType_iPodTouch6) {
        return YES;
    }
    return NO;
}

+ (BOOL)yj_isPhone {
    if ([self yj_deviceType] == YJDeviceType_iPhone4 ||
        [self yj_deviceType] == YJDeviceType_iPhone4s ||
        [self yj_deviceType] == YJDeviceType_iPhone5 ||
        [self yj_deviceType] == YJDeviceType_iPhone5c ||
        [self yj_deviceType] == YJDeviceType_iPhone5s ||
        [self yj_deviceType] == YJDeviceType_iPhone6 ||
        [self yj_deviceType] == YJDeviceType_iPhone6Plus ||
        [self yj_deviceType] == YJDeviceType_iPhone6s ||
        [self yj_deviceType] == YJDeviceType_iPhone6sPlus ||
        [self yj_deviceType] == YJDeviceType_iPhone7 ||
        [self yj_deviceType] == YJDeviceType_iPhone7Plus ||
        [self yj_deviceType] == YJDeviceType_iPhoneSE ||
        [self yj_deviceType] == YJDeviceType_iPhone8 ||
        [self yj_deviceType] == YJDeviceType_iPhone8Plus ||
        [self yj_deviceType] == YJDeviceType_iPhoneX) {
        return YES;
    }
    return NO;
}

+ (BOOL)yj_isPad {
    if ([self yj_deviceType] == YJDeviceType_iPad2 ||
        [self yj_deviceType] == YJDeviceType_iPad3 ||
        [self yj_deviceType] == YJDeviceType_iPad4 ||
        [self yj_deviceType] == YJDeviceType_iPadAir ||
        [self yj_deviceType] == YJDeviceType_iPadAir2 ||
        [self yj_deviceType] == YJDeviceType_iPad5 ||
        [self yj_deviceType] == YJDeviceType_iPad6 ||
        [self yj_deviceType] == YJDeviceType_iPadMini ||
        [self yj_deviceType] == YJDeviceType_iPadMini2 ||
        [self yj_deviceType] == YJDeviceType_iPadMini3 ||
        [self yj_deviceType] == YJDeviceType_iPadMini4 ||
        [self yj_deviceType] == YJDeviceType_iPadPro9Inch ||
        [self yj_deviceType] == YJDeviceType_iPadPro12Inch ||
        [self yj_deviceType] == YJDeviceType_iPadPro12Inch2 ||
        [self yj_deviceType] == YJDeviceType_iPadPro10Inch) {
        return YES;
    }
    return NO;
}

+ (BOOL)yj_isSimulator {
    __block BOOL isExist = NO;
    [@[@"i386", @"x86_64"]  enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[self yj_deviceIdentifier] isEqualToString:obj]) {
            isExist = YES;
            *stop = YES;
        }
    }];
    return isExist;
}

/// 屏幕宽高比
+ (double)yj_screenRatio {
    
    switch ([self yj_deviceType]) {
        case YJDeviceType_iPodTouch5:
        case YJDeviceType_iPodTouch6:
        case YJDeviceType_iPhone5c:
        case YJDeviceType_iPhone5s:
        case YJDeviceType_iPhone6:
        case YJDeviceType_iPhone6Plus:
        case YJDeviceType_iPhone6s:
        case YJDeviceType_iPhone6sPlus:
        case YJDeviceType_iPhone7:
        case YJDeviceType_iPhone7Plus:
        case YJDeviceType_iPhoneSE:
        case YJDeviceType_iPhone8:
        case YJDeviceType_iPhone8Plus:
            return 9/16.f;
            break;
        case YJDeviceType_iPhone4:
        case YJDeviceType_iPhone4s:
            return 2/3.f;
            break;
        case YJDeviceType_iPhoneX:
            return 9/19.5f;
            break;
        case YJDeviceType_homePod:
            return 4/5.f;
            break;
        case YJDeviceType_iPad2:
        case YJDeviceType_iPad3:
        case YJDeviceType_iPad4:
        case YJDeviceType_iPadAir:
        case YJDeviceType_iPadAir2:
        case YJDeviceType_iPad5:
        case YJDeviceType_iPad6:
        case YJDeviceType_iPadMini:
        case YJDeviceType_iPadMini2:
        case YJDeviceType_iPadMini3:
        case YJDeviceType_iPadMini4:
        case YJDeviceType_iPadPro9Inch:
        case YJDeviceType_iPadPro12Inch:
        case YJDeviceType_iPadPro12Inch2:
        case YJDeviceType_iPadPro10Inch:
            return 3/4.f;
            break;
        default:
            break;
    }
    return -1;
}
// 亮度
+ (int)yj_screenBrightness {
    return [UIScreen mainScreen].brightness * 100;
}

// 设置类型字符串
+ (NSString *)yj_description {
    
    NSString *value = [self yj_deviceIdentifier];
    
    YJDeviceType type = [self yj_deviceType];
    
    switch (type) {
        case YJDeviceType_iPodTouch5:
            value = @"iPod Touch 5";
            break;
        case YJDeviceType_iPodTouch6:
            value = @"iPod Touch 6";
            break;
        case YJDeviceType_iPhone4:
            value = @"iPhone 4";
            break;
        case YJDeviceType_iPhone4s:
            value = @"iPhone 4s";
            break;
        case YJDeviceType_iPhone5:
            value = @"iPhone 5";
            break;
        case YJDeviceType_iPhone5c:
            value = @"iPhone 5c";
            break;
        case YJDeviceType_iPhone5s:
            value = @"iPhone 5s";
            break;
        case YJDeviceType_iPhone6:
            value = @"iPhone 6";
            break;
        case YJDeviceType_iPhone6Plus:
            value = @"iPhone 6 Plus";
            break;
        case YJDeviceType_iPhone6s:
            value = @"iPhone 6s";
            break;
        case YJDeviceType_iPhone6sPlus:
            value = @"iPhone 6s Plus";
            break;
        case YJDeviceType_iPhone7:
            value = @"iPhone 7";
            break;
        case YJDeviceType_iPhone7Plus:
            value = @"iPhone 7 Plus";
            break;
        case YJDeviceType_iPhoneSE:
            value = @"iPhone SE";
            break;
        case YJDeviceType_iPhone8:
            value = @"iPhone 8";
            break;
        case YJDeviceType_iPhone8Plus:
            value = @"iPhone 8 Plus";
            break;
        case YJDeviceType_iPhoneX:
            value = @"iPhone X";
            break;
        case YJDeviceType_iPad2:
            value = @"iPad 2";
            break;
        case YJDeviceType_iPad3:
            value = @"iPad 3";
            break;
        case YJDeviceType_iPad4:
            value = @"iPad 4";
            break;
        case YJDeviceType_iPadAir:
            value = @"iPad Air";
            break;
        case YJDeviceType_iPadAir2:
            value = @"iPad Air 2";
            break;
        case YJDeviceType_iPad5:
            value = @"iPad 5";
            break;
        case YJDeviceType_iPad6:
            value = @"iPad 6";
            break;
        case YJDeviceType_iPadMini:
            value = @"iPad Mini";
            break;
        case YJDeviceType_iPadMini2:
            value = @"iPad Mini 2";
            break;
        case YJDeviceType_iPadMini3:
            value = @"iPad Mini 3";
            break;
        case YJDeviceType_iPadMini4:
            value = @"iPad Mini 4";
            break;
        case YJDeviceType_iPadPro9Inch:
            value = @"iPad Pro (9.7-inch)";
            break;
        case YJDeviceType_iPadPro12Inch:
            value = @"iPad Pro (12.9-inch)";
            break;
        case YJDeviceType_iPadPro12Inch2:
            value = @"iPad Pro (12.9-inch) 2";
            break;
        case YJDeviceType_iPadPro10Inch:
            value = @"iPad Pro (10.5-inch)";
            break;
        case YJDeviceType_homePod:
            value = @"HomePod";
            break;
        default:
            break;
    }
    
    if ([self yj_isSimulator] == YES) {
        value = [NSString stringWithFormat:@"Simulator (%@)",value];
    }
    
    return value;
}

+ (NSUInteger)getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

+ (NSUInteger)yj_totalMemoryBytes
{
    return [self getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger)yj_freeMemoryBytes
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        return 0;
    }
    unsigned long mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}

+ (long long)yj_freeDiskSpaceBytes
{
    struct statfs buf;
    long long freespace;
    freespace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        freespace = (long long)buf.f_bsize * buf.f_bfree;
    }
    return freespace;
}

+ (long long)yj_totalDiskSpaceBytes
{
    struct statfs buf;
    long long totalspace;
    totalspace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        totalspace = (long long)buf.f_bsize * buf.f_blocks;
    }
    return totalspace;
}

#pragma mark 手机别名： 用户定义的名称
+ (NSString *)yj_name {
    return [[UIDevice currentDevice] name];
}

#pragma mark 设备名称
+ (NSString *)yj_systemName {
    return [[UIDevice currentDevice] systemName];
}

#pragma mark 手机系统版本
+ (NSString *)yj_systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}
#pragma mark 手机型号
+ (NSString *)yj_model {
    return [[UIDevice currentDevice] model];
}
#pragma mark 地方型号  （国际化区域名称）
+ (NSString *)yj_localizedModel {
    return  [[UIDevice currentDevice] localizedModel];
}

#pragma mark 获取设备唯一标识符
+ (NSString *)yj_UUID {
    return [[UIDevice currentDevice] identifierForVendor].UUIDString;
}

#pragma mark 获取内网IP
+ (NSString *)yj_deviceIPAdress
{
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0)
    { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL)
        {
            if (temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return address;
}

#pragma mark 获取当前wifi名称
+ (NSString *)yj_WifiName
{
    NSString *wifiName = nil;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}


+ (BOOL)yj_hasCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

@end
