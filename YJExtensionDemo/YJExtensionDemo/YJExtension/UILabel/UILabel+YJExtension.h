//
//  UILabel+YJExtension.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/17.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YJExtension)

/**
 *  改变行间距
 */
+ (void)yj_changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;
- (void)yj_changeLineSpac:(float)space;

/**
 *  改变字间距
 */
+ (void)yj_changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;
- (void)yj_changeWordSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)yj_changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;
- (void)yj_changeSpaceWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
