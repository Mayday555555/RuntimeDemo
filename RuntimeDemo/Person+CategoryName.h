//
//  Person+CategoryName.h
//  RuntimeDemo
//
//  Created by xuanze on 2019/7/25.
//  Copyright © 2019 xuanze. All rights reserved.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CategoryName)
@property (nonatomic, copy) NSString * str;
@end

NS_ASSUME_NONNULL_END
