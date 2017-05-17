//
//  NSObject+RMRuntime.h
//  RMUrlRouter
//
//  Created by ohhh on 2017/5/16.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RMRuntime)


/**
 运行时获得对象的属性键列表

 @return 列表
 */
- (NSArray <NSString *> *)rm_propertyKeys;

@end
