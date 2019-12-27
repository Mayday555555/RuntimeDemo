//
//  Person+CategoryName.m
//  RuntimeDemo
//
//  Created by xuanze on 2019/7/25.
//  Copyright © 2019 xuanze. All rights reserved.
//

#import "Person+CategoryName.h"
#import <objc/runtime.h>
//给分类添加属性
const void *PersonStrKey = @"PersonStrKey";
@implementation Person (CategoryName)

- (void)setStr:(NSString *)str {
    objc_setAssociatedObject(self, &PersonStrKey, str, OBJC_ASSOCIATION_COPY);
}

-(NSString *)str {
    return objc_getAssociatedObject(self, &PersonStrKey);
}

@end
