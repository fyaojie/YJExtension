//
//  UIResponder+YJUpdate.m
//  YJExtensionDemo
//
//  Created by cool on 2018/6/7.
//  Copyright © 2018 child. All rights reserved.
//

#import "UIResponder+YJUpdate.h"

@implementation UIResponder (YJUpdate)

- (void)yj_openAppURLForIdentifier:(NSInteger)identifier {
    NSString* appURLString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%li", (long)identifier];
    NSURL *URL = [NSURL URLWithString:appURLString];
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 10) {
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:^(BOOL success) {
            
        }];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] openURL:URL];
#pragma clang diagnostic pop
    }
}
@end
