//
//  NSObject+runtime.h
//  RuntimeDemo
//
//  Created by xuanze on 2019/7/25.
//  Copyright © 2019 xuanze. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (runtime)
+ (NSArray *) getPropertyArray;
+ (instancetype)objWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
