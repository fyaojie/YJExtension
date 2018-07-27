//
//  NSObject+YJReflection.h
//  YJExtensionDemo
//
//  Created by cool on 2018/6/8.
//  Copyright © 2018 child. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YJReflection)
//类名
- (NSString *)yj_className;
+ (NSString *)yj_className;
//父类名称
- (NSString *)yj_superClassName;
+ (NSString *)yj_superClassName;

//实例属性字典
-(NSDictionary *)yj_propertyDictionary;

//属性名称列表
- (NSArray*)yj_propertyKeys;
+ (NSArray *)yj_propertyKeys;

//属性详细信息列表
- (NSArray *)yj_propertiesInfo;
+ (NSArray *)yj_propertiesInfo;

//格式化后的属性列表
+ (NSArray *)yj_propertiesWithCodeFormat;

//方法列表
-(NSArray*)yj_methodList;
+(NSArray*)yj_methodList;

-(NSArray*)yj_methodListInfo;

//创建并返回一个指向所有已注册类的指针列表
+ (NSArray *)yj_registedClassList;
//实例变量
+ (NSArray *)yj_instanceVariable;

//协议列表
-(NSDictionary *)yj_protocolList;
+ (NSDictionary *)yj_protocolList;


- (BOOL)yj_hasPropertyForKey:(NSString*)key;
- (BOOL)yj_hasIvarForKey:(NSString*)key;
@end
