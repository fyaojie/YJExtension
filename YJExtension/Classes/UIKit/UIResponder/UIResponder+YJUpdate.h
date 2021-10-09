//
//  UIResponder+YJUpdate.h
//  YJExtensionDemo
//
//  Created by cool on 2018/6/7.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (YJUpdate)
// 在ituns 打开某个app的下载地址
- (void)yj_openAppURLForIdentifier:(NSInteger)identifier;
@end
