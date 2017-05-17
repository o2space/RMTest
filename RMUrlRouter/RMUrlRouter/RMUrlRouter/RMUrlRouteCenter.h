//
//  RMUrlRouteCenter.h
//  RMUrlRouter
//
//  Created by ohhh on 2017/5/15.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,RMUrlRouterPageJumpType) {

    kRMUrlRouterPageJumpTypePush = 1,
    kRMUrlRouterPageJumpTypePop,
    kRMUrlRouterPageJumpTypePopRoot,
    kRMUrlRouterPageJumpTypePopLast,
    kRMUrlRouterPageJumpTypePresent,
    kRMUrlRouterPageJumpTypeDismiss
};

@interface RMUrlRouteCenter : NSObject

+ (RMUrlRouteCenter *)shareCenter;


// 默认push跳转 且无参数
- (void)open:(NSString *)urlKey animated:(BOOL)animted;

// 无参数
- (void)open:(NSString *)urlKey animated:(BOOL)animted pageJumpType:(RMUrlRouterPageJumpType)type;

// 默认push跳转 有参数
- (void)open:(NSString *)urlKey animted:(BOOL)animted extraParams:(NSDictionary *)extraParaqms;

// 跳转路由
- (void)open:(NSString *)urlKey animated:(BOOL)animated pageJumpType:(RMUrlRouterPageJumpType)type extraParams:(NSDictionary *)extraParams;



// 从其他app回到本app的回调方法 (要在APPDelegate的- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options方法中调用)
- (void)openUrlScheme:(NSURL *)url animated:(BOOL)animated sourceAppBundleID:(NSString *)sourceAppBundleID pageJumpType:(RMUrlRouterPageJumpType)type;

@end
