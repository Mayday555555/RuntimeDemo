//
//  OCViewController.m
//  RuntimeDemo
//
//  Created by xuanze on 2019/7/25.
//  Copyright © 2019 xuanze. All rights reserved.
//

#import "OCViewController.h"
#import "Person.h"
#import "NSObject+runtime.h"
#import "Person+CategoryName.h"
@interface OCViewController ()

@end

@implementation OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arr = [Person getPropertyArray];
    Person * person = [Person objWithDict:@{@"name":@"Tom", @"age":@"15"}];
    person.str = @"haha";
    NSLog(@"%@",person.str);
    
}

@end
