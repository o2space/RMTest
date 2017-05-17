//
//  RMUrlRouteHelper.h
//  RMUrlRouter
//
//  Created by ohhh on 2017/5/15.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RMUrlRouteHelper : NSObject

// 判断是否是网址
+ (BOOL)isWebUrl:(NSString *)urlKey;

// 检查urlKey是否为网址
+ (BOOL)checkUrlKey:(NSString *)urlKey;

// 查找urlKey中的参数
+ (NSMutableDictionary *)paramsWithUrlKey:(NSString *)urlKey;

// 根据urlKey找到对应的类名
+ (NSString *)classNameWithUrlKey:(NSString *)urlKey;

// 根据urlKey和参数拼接对应的url
+ (NSString *)urlWithUrlKey:(NSString *)urlKey extraParams:(NSDictionary *)extraParams;

// 根据urlKey和参数找到对应的类并对类内的属性赋值
+ (UIViewController *)viewControllerWithUrlKey:(NSString *)urlKey extraParams:(NSDictionary *)extraParams;

@end
