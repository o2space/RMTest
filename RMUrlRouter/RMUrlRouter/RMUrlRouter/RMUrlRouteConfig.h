//
//  RMUrlRouteConfig.h
//  RMUrlRouter
//
//  Created by ohhh on 2017/5/15.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#ifndef RMUrlRouteConfig_h
#define RMUrlRouteConfig_h


/******************************  App相关设置  **************************************/
// 修改为自己APP的scheme
#define RM_URL_SCHEME @"rm"
// 修改为自己APP的host
#define RM_URL_HOST   @"rm://com.rm.conch"



/******************************  打印方便  **************************************/
// 字符串
#define RM_METHOD_STRING(fmt, ...)  [NSString stringWithFormat:(@"\n[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d]\n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__]


/******************************  跳转代码  **************************************/
#define RMUrlRoutePushToViewController(viewController,animated)\
UINavigationController * nav = [UIApplication sharedApplication].currentViewController.navigationController;\
NSAssert(nav != nil, @"========== just navigationController can use push or pop  =========");\
[nav pushViewController:viewController animated:animated];\


#define RMUrlRoutePopToViewController(viewController,animated)\
UINavigationController * nav = [UIApplication sharedApplication].currentViewController.navigationController;\
NSAssert(nav != nil, @"========== just navigationController can use push or pop  =========");\
[nav popToViewController:viewController animated:animated];\


#define RMUrlRoutePopViewController(animated)\
UINavigationController * nav = [UIApplication sharedApplication].currentViewController.navigationController;\
NSAssert(nav != nil, @"========== just navigationController can use push or pop  =========");\
[nav popViewControllerAnimated:animated];\


#define RMUrlRoutePopRootViewController(animated)\
UINavigationController * nav = [UIApplication sharedApplication].currentViewController.navigationController;\
NSAssert(nav != nil, @"========== just navigationController can use push or pop  =========");\
[nav popToRootViewControllerAnimated:animated];\


#define RMUrlRoutePresentViewController(viewController,animated)\
UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:viewController];\
[[UIApplication sharedApplication].currentViewController presentViewController:nav animated:animated completion:nil];\


#define RMUrlRouteDismissViewController(animated)\
UINavigationController * nav = [UIApplication sharedApplication].currentViewController.navigationController;\
if (nav == nil) {\
    [[UIApplication sharedApplication].currentViewController dismissViewControllerAnimated:animated completion:nil];\
}else{\
    [nav dismissViewControllerAnimated:animated completion:nil];\
}\


#endif /* RMUrlRouteConfig_h */
