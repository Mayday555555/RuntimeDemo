//
//  UIViewController+Analysis.m
//  RuntimeDemo
//
//  Created by xuanze on 2019/7/25.
//  Copyright © 2019 xuanze. All rights reserved.
//

//#import "UIViewController+Analysis.h"
//#import <objc/runtime.h>
//@implementation UIViewController (Analysis)
//
//// 在类被加载到运行时的时候，就会执行
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        SEL originSelector = @selector(viewDidLoad);
//        SEL swizzleSelector = @selector(userViewDidLoad);
//        Method originalMethod = class_getInstanceMethod([self class], originSelector);
//        Method swizzleMethod = class_getInstanceMethod([self class], swizzleSelector);
//        
//        BOOL didAddMethod = class_addMethod([self class], originSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
//        if (didAddMethod) {
//            class_replaceMethod([self class], swizzleSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzleMethod);
//        }
//    });
//}
//
//- (void)userViewDidLoad {
//    [self userViewDidLoad];
//    
//    NSString *identifier = [NSString stringWithFormat:@"%@",[self class]];
//    NSLog(@"identifier:%@",identifier);
//}
//@end
