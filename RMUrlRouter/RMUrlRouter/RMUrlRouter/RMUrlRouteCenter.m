//
//  RMUrlRouteCenter.m
//  RMUrlRouter
//
//  Created by ohhh on 2017/5/15.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import "RMUrlRouteCenter.h"
#import "RMUrlRouteConfig.h"
#import "UIAlertView+RMExtension.h"
#import "UIApplication+RMExtension.h"
#import "RMUrlRouteHelper.h"
#import "RMWebViewController.h"

@implementation RMUrlRouteCenter


+ (RMUrlRouteCenter *)shareCenter{
    
    static RMUrlRouteCenter * urlRouterCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        urlRouterCenter = [[self alloc]init];
    });
    return urlRouterCenter;
}

#pragma mark-回调方法
// 从其他app回到本app的回调方法 (要在APPDelegate的- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options方法中调用)
- (void)openUrlScheme:(NSURL *)url animated:(BOOL)animated sourceAppBundleID:(NSString *)sourceAppBundleID pageJumpType:(RMUrlRouterPageJumpType)type{

    if (![RM_URL_SCHEME isEqualToString:url.scheme]) {

        [UIAlertView showMessage:RM_METHOD_STRING(@"urlScheme 与 预设的 scheme 不同")];
        return;
    }
    
    NSString * urlKey = [NSString stringWithFormat:@"%@://%@%@",url.scheme,url.host,url.path];
    NSString * query = url.query;
    
    NSArray <NSString *> * queries = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary * extraParams = [NSMutableDictionary new];
    [queries enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSArray <NSString *> * queryComponents = [obj componentsSeparatedByString:@"="];
        if (queryComponents.count == 2) {
            
            [extraParams setObject:queryComponents[1] forKey:queryComponents[0]];
        }
    }];
    
    [self open:urlKey animated:animated pageJumpType:type extraParams:extraParams];
}

#pragma mark -跳转路由
// 默认push跳转 且无参数
- (void)open:(NSString *)urlKey animated:(BOOL)animted{
    
    [self open:urlKey animated:animted pageJumpType:kRMUrlRouterPageJumpTypePush extraParams:@{}];
}

// 无参数
- (void)open:(NSString *)urlKey animated:(BOOL)animted pageJumpType:(RMUrlRouterPageJumpType)type{
    
    [self open:urlKey animated:animted pageJumpType:type extraParams:@{}];
}

// 默认push跳转 有参数
- (void)open:(NSString *)urlKey animted:(BOOL)animted extraParams:(NSDictionary *)extraParaqms{
    
    [self open:urlKey animated:animted pageJumpType:kRMUrlRouterPageJumpTypePush extraParams:extraParaqms];
}


// 跳转路由
- (void)open:(NSString *)urlKey animated:(BOOL)animated pageJumpType:(RMUrlRouterPageJumpType)type extraParams:(NSDictionary *)extraParams{
    
    if (urlKey.length <= 0) {
        [UIAlertView showMessage:RM_METHOD_STRING(@"urlKey不能为空")];
        return;
    }
    
    if ([urlKey isKindOfClass:[NSURL class]]) {
        urlKey = [(NSURL *)urlKey absoluteString];
    }
    
    if ([RMUrlRouteHelper isWebUrl:urlKey]) {
        
        NSString * url = [RMUrlRouteHelper urlWithUrlKey:urlKey extraParams:extraParams];
        [self openWebViewWithUrl:url animated:animated pageJumpType:type];
    }else{
        
        NSDictionary * paramDict = [NSDictionary dictionaryWithDictionary:[RMUrlRouteHelper paramsWithUrlKey:urlKey]];
        __block NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:extraParams];
        [paramDict.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [dict setObject:paramDict.allValues[idx] forKey:obj];
        }];
        
        UIViewController * vc = [RMUrlRouteHelper viewControllerWithUrlKey:urlKey extraParams:dict];
        [self openViewController:vc animated:animated pageJumpType:type];
    }
}

// 打开一个webview页面
- (void)openWebViewWithUrl:(NSString *)urlString animated:(BOOL)animated pageJumpType:(RMUrlRouterPageJumpType)type{
    
    RMWebViewController * viewContr = [[RMWebViewController alloc]init];
    viewContr.url = urlString;
    [self openViewController:viewContr animated:animated pageJumpType:type];
}

// 打开一个ViewController
- (void)openViewController:(UIViewController *)viewController animated:(BOOL)animated pageJumpType:(RMUrlRouterPageJumpType)type{
    
    switch (type) {
        case kRMUrlRouterPageJumpTypePush:
            [self pushToVC:viewController animated:animated];
            break;
        case kRMUrlRouterPageJumpTypePop:
            [self popToVC:viewController animated:animated];
            break;
        case kRMUrlRouterPageJumpTypePopRoot:
            [self popToRootVC:animated];
            break;
        case kRMUrlRouterPageJumpTypePopLast:
            [self popToLastVC:animated];
            break;
        case kRMUrlRouterPageJumpTypePresent:
            [self presentVC:viewController animated:animated];
            break;
        case kRMUrlRouterPageJumpTypeDismiss:
            [self dismissVC:animated];
            break;
        default:
            [UIAlertView showMessage:RM_METHOD_STRING(@"Error RMUrlRouterPageJumpType")];
            break;
    }
}

#pragma mark -跳转方式不同的处理
- (void)pushToVC:(UIViewController *)viewController animated:(BOOL)animated{

    if (viewController) {
        RMUrlRoutePushToViewController(viewController, animated);
    }else{
        [UIAlertView showMessage:RM_METHOD_STRING(@"Error ViewController")];
    }
}

- (void)popToVC:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (viewController) {
        RMUrlRoutePopToViewController(viewController, animated);
    }else{
        RMUrlRoutePopRootViewController(animated);
    }
}

- (void)popToRootVC:(BOOL)animated{
    RMUrlRoutePopRootViewController(animated);
}

- (void)popToLastVC:(BOOL)animated{
    RMUrlRoutePopViewController(animated);
}


- (void)presentVC:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (viewController) {
        RMUrlRoutePresentViewController(viewController, animated);
    }else{
        [UIAlertView showMessage:RM_METHOD_STRING(@"Error ViewController")];
    }
}

- (void)dismissVC:(BOOL)animated{
    RMUrlRouteDismissViewController(animated);
}


@end
