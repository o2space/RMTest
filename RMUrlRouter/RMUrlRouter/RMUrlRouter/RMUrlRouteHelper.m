//
//  RMUrlRouteHelper.m
//  RMUrlRouter
//
//  Created by ohhh on 2017/5/15.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import "RMUrlRouteHelper.h"
#import "UIAlertView+RMExtension.h"
#import "RMUrlRouteConfig.h"
#import "RMUrlRouteList.h"
#import "NSObject+RMRuntime.h"

@implementation RMUrlRouteHelper

// 判断是否是网址
+ (BOOL)isWebUrl:(NSString *)urlKey{
    
    if (urlKey.length <= 0) {
        [UIAlertView showMessage:RM_METHOD_STRING(@"urlKey为空")];
        return NO;
    }
    
    if ([self checkUrlKey:urlKey]) {
        return YES;
    }
    
    NSString * className = [self classNameWithUrlKey:urlKey];
    if ([self checkUrlKey:className]) {
        return YES;
    }
    return NO;
}

// 检查urlKey是否为网址
+ (BOOL)checkUrlKey:(NSString *)urlKey{
    
    NSURL * url = [NSURL URLWithString:urlKey];
    NSString * scheme = url.scheme;
    NSArray * effectiveScheme = @[@"http",@"https",@"ftp"];
    BOOL isUrl = [effectiveScheme containsObject:scheme];
    return isUrl;
}

// 查找urlKey中的参数
+ (NSMutableDictionary *)paramsWithUrlKey:(NSString *)urlKey{
    
    NSURL * url = [NSURL URLWithString:urlKey];
    
    NSString * query = url.query;
    
    __block NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    NSArray * queryArr = [query componentsSeparatedByString:@"&"];
    
    [queryArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSArray * paramArr = [obj componentsSeparatedByString:@"="];
        
        if (paramArr.count == 2) {
            
            [dict setObject:paramArr[1] forKey:paramArr[0]];
        }
    }];
    return dict;
}


// 根据urlKey找到对应的类名
+ (NSString *)classNameWithUrlKey:(NSString *)urlKey{
    
    if (!urlKey) {
        [UIAlertView showMessage:RM_METHOD_STRING(@"urlKey不可用")];
        return nil;
    }
    
    NSString * key = [urlKey componentsSeparatedByString:@"?"].firstObject;
    NSDictionary * dict = [[RMUrlRouteList shareRouteList] urlRouteList];
    return dict[key];
}

// 根据urlKey找到对应的类
+ (Class)classWithUrlKey:(NSString *)urlKey{
    
    NSString * className = [self classNameWithUrlKey:urlKey];
    
    if (!className) {
        [UIAlertView showMessage:RM_METHOD_STRING(@"className不可用")];
        return nil;
    }
    
    Class class = NSClassFromString(className);
    return class;
}


// 根据urlKey和参数找到对应的类并对类内的属性赋值
+ (UIViewController *)viewControllerWithUrlKey:(NSString *)urlKey extraParams:(NSDictionary *)extraParams{
    
    if (!urlKey) {
        [UIAlertView showMessage:RM_METHOD_STRING(@"urlKey 不存在")];
        return nil;
    }
    
    Class class = [self classWithUrlKey:urlKey];
    UIViewController * vc = nil;
    
    if (class && [class isSubclassOfClass:[UIViewController class]]) {
        vc = [[class alloc]init];
        if (extraParams) {
            NSArray<NSString *> * allPropertyKeys = vc.rm_propertyKeys;
            [extraParams.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([allPropertyKeys containsObject:obj]) {
                    NSString * value = [extraParams objectForKey:obj];
                    [vc setValue:value forKey:obj];
                }else{
                    [UIAlertView showMessage:RM_METHOD_STRING(@"can't find key")];
                }
            }];
        }
    }
    return vc;
}


// 根据urlKey和参数拼接对应的url
+ (NSString *)urlWithUrlKey:(NSString *)urlKey extraParams:(NSDictionary *)extraParams{
    
    if (!urlKey) {
        [UIAlertView showMessage:RM_METHOD_STRING(@"urlKey不可用")];
        return nil;
    }
    
    __block NSString * webUrl = @"";
    if ([self checkUrlKey:urlKey]) {
        webUrl = urlKey;
    }
    
    NSString * className = [self classNameWithUrlKey:urlKey];
    if ([self checkUrlKey:className]) {
        webUrl = className;
    }
    
    [extraParams.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == 0 && ![webUrl containsString:@"?"]) {
            
            webUrl = [webUrl stringByAppendingString:@"?"];
        }else{
            
            if (![webUrl hasSuffix:@"?"]) {
                
                if (![webUrl hasSuffix:@"&"]) {
                    webUrl = [webUrl stringByAppendingString:@"&"];
                }
            }
        }
        NSString * paramStr = [NSString stringWithFormat:@"%@=%@",obj,extraParams.allValues[idx]];
        webUrl = [webUrl stringByAppendingString:paramStr];
    }];
    return webUrl;
}


@end
