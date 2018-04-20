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

@implementation UIDevice (YJExtension)

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

+ (BOOL)yj_isSimulator {
    if ([[self yj_deviceModelName] containsString:@"Simulator"]) {
        return YES;
    }
    return NO;
}

#pragma mark 获取当前设备名

+ (NSString*)yj_deviceModelName {
    struct utsname systemInfo;
    
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    /**
     * CDMA电信3G的网络模式
     * GSM是通用的移动联通电信2g模式
     * WCDMA是联通3G的网络模式
     * TD—SCDMA是移动3G
     * 如果有TD-LTE或者FDD-LTE，则证明支持4g网络
     */
    
    NSDictionary *deviceModelDict = @{
                                      //iPhone 系列
                                      @"iPhone1,1":@"iPhone 1G",
                                      @"iPhone1,2":@"iPhone 3G",
                                      @"iPhone2,1":@"iPhone 3GS",
                                      @"iPhone3,1":@"iPhone 4",
                                      @"iPhone3,2":@"Verizon iPhone 4",
                                      @"iPhone4,1":@"iPhone 4S",
                                      @"iPhone5,1":@"iPhone 5",
                                      @"iPhone5,2":@"iPhone 5",
                                      @"iPhone5,3":@"iPhone 5C",
                                      @"iPhone5,4":@"iPhone 5C",
                                      @"iPhone6,1":@"iPhone 5S",
                                      @"iPhone6,2":@"iPhone 5S",
                                      @"iPhone7,1":@"iPhone 6 Plus",
                                      @"iPhone7,2":@"iPhone 6",
                                      @"iPhone8,1":@"iPhone 6s",
                                      @"iPhone8,2":@"iPhone 6s Plus",
                                      @"iPhone9,1":@"iPhone 7 (CDMA)",
                                      @"iPhone9,3":@"iPhone 7 (GSM)",
                                      @"iPhone9,2":@"iPhone 7 Plus (CDMA)",
                                      @"iPhone9,4":@"iPhone 7 Plus (GSM)",
                                      
                                      //iPod 系列
                                      @"iPod1,1":@"iPod Touch 1G",
                                      @"iPod2,1":@"iPod Touch 2G",
                                      @"iPod3,1":@"iPod Touch 3G",
                                      @"iPod4,1":@"iPod Touch 4G",
                                      @"iPod5,1":@"iPod Touch 5G",
                                      
                                      //iPad 系列
                                      
                                      //iPad
                                      @"iPad1,1":@"iPad",
                                      @"iPad2,1":@"iPad 2 (WiFi)",
                                      @"iPad2,2":@"iPad 2 (GSM)",
                                      @"iPad2,3":@"iPad 2 (CDMA)",
                                      @"iPad2,4":@"iPad 2 (32nm)",
                                      @"iPad3,1":@"iPad 3(WiFi)",
                                      @"iPad3,2":@"iPad 3(CDMA)",
                                      @"iPad3,3":@"iPad 3(4G)",
                                      @"iPad3,4":@"iPad 4 (WiFi)",
                                      @"iPad3,5":@"iPad 4 (4G)",
                                      @"iPad3,6":@"iPad 4 (CDMA)",
                                      //iPad mini
                                      @"iPad2,5":@"iPad mini (WiFi)",
                                      @"iPad2,6":@"iPad mini (GSM)",
                                      @"iPad2,7":@"iPad mini (CDMA)",
                                      @"iPad4,4":@"iPad mini 2",
                                      @"iPad4,5":@"iPad mini 2",
                                      @"iPad4,6":@"iPad mini 2",
                                      @"iPad4,7":@"iPad mini 3",
                                      @"iPad4,8":@"iPad mini 3",
                                      @"iPad4,9":@"iPad mini 3",
                                      //iPad Air
                                      @"iPad4,1":@"iPad Air",
                                      @"iPad4,2":@"iPad Air",
                                      @"iPad4,3":@"iPad Air",
                                      @"iPad5,3":@"iPad Air 2",
                                      @"iPad5,4":@"iPad Air 2",
                                      // 模拟器
                                      @"i386":@"Simulator(模拟器)",
                                      @"x86_64":@"Simulator(模拟器)"
                                      };
    return  [deviceModelDict objectForKey:deviceModel] ?: deviceModel;
}

#pragma mark 手机别名： 用户定义的名称
+ (NSString *)yj_phoneAliases {
    return [[UIDevice currentDevice] name];
}

#pragma mark 设备名称
+ (NSString *)yj_deviceName {
    return [[UIDevice currentDevice] systemName];
}

#pragma mark 手机系统版本
+ (NSString *)yj_systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}
#pragma mark 手机型号
+ (NSString *)yj_phoneModel {
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
@end
