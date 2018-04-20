//
//  UIView+YJNib.h
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YJNib)

+ (instancetype)loadNib;
+ (instancetype)loadNibNamed:(NSString*)nibName;
+ (instancetype)loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle;

@end
