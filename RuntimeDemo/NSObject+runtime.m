//
//  NSObject+runtime.m
//  RuntimeDemo
//
//  Created by xuanze on 2019/7/25.
//  Copyright © 2019 xuanze. All rights reserved.
//

#import "NSObject+runtime.h"
#import <objc/runtime.h>
@implementation NSObject (runtime)

// 获取属性名称列表
+ (NSArray *) getPropertyArray{
    //当Person对象属性已经获取的时候，就直接返回，防止多次调用运行时方法提高效率
    const char * kPropertiesListKey = "CZPropertiesListKey";
    NSArray * ptyList = objc_getAssociatedObject(self, kPropertiesListKey);
    if (ptyList != nil) {
        return  ptyList;
    }
    
    unsigned int count = 0;
    //objc_property_t是c语言的结构体指针
    objc_property_t * list = class_copyPropertyList([self class], &count);
    NSLog(@"属性的数量:%d",count);
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (int i = 0; i < count; i ++) {
        objc_property_t pro = list[i];
        const char * cName = property_getName(pro);
        NSString * name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        NSLog(@"%@", name);
        [arr addObject:name];
    }
    free(list);
    
    //绑定关联对象
    objc_setAssociatedObject(self, kPropertiesListKey, [arr copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return  [arr copy];
}

+ (instancetype)objWithDict:(NSDictionary *)dict {
    id object = [[self alloc] init];
    
    NSArray * proList = [self getPropertyArray];
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([proList containsObject:key]) {
            [object setValue:obj forKey:key];
        }
    }];
    return  object;
}

@end
