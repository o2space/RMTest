//
//  NSObject+RMRuntime.m
//  RMUrlRouter
//
//  Created by ohhh on 2017/5/16.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import "NSObject+RMRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (RMRuntime)

-(NSArray<NSString *> *)rm_propertyKeys{
    
    unsigned int outCount,i;
    objc_property_t * properties = class_copyPropertyList(self.class, &outCount);
    NSMutableArray * keys = [[NSMutableArray alloc]initWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        NSString * propertyName = [[NSString alloc]initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    return keys;
}

@end
