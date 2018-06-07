//
//  UIApplication+YJExtension.m
//  YJExtensionDemo
//
//  Created by cool on 2018/5/31.
//  Copyright © 2018 child. All rights reserved.
//

#import "UIApplication+YJExtension.h"

@implementation UIApplication (YJExtension)

- (NSString *)yj_applicationSize {
    unsigned long long docSize   =  [self yj_sizeOfFolder:[self yj_documentPath]];
    unsigned long long libSize   =  [self yj_sizeOfFolder:[self yj_libraryPath]];
    unsigned long long cacheSize =  [self yj_sizeOfFolder:[self yj_cachePath]];
    
    unsigned long long total = docSize + libSize + cacheSize;
    
    NSString *folderSizeStr = [NSByteCountFormatter stringFromByteCount:total countStyle:NSByteCountFormatterCountStyleFile];
    return folderSizeStr;
}

- (NSString *)yj_documentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}

- (NSString *)yj_libraryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}

- (NSString *)yj_cachePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}

-(unsigned long long)yj_sizeOfFolder:(NSString *)folderPath
{
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *contentsEnumurator = [contents objectEnumerator];
    
    NSString *file;
    unsigned long long folderSize = 0;
    
    while (file = [contentsEnumurator nextObject]) {
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:file] error:nil];
        folderSize += [[fileAttributes objectForKey:NSFileSize] intValue];
    }
    return folderSize;
}

@end
