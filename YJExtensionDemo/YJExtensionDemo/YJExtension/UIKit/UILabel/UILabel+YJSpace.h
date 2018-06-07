//
//  UILabel+YJSpace.h
//  YJExtensionDemo
//
//  Created by cool on 2018/6/7.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YJSpace)
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
