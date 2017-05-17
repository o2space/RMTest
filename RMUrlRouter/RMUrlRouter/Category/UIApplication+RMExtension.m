//
//  UIApplication+RMExtension.m
//  RMUrlRouter
//
//  Created by ohhh on 2017/5/16.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import "UIApplication+RMExtension.h"
#import <objc/runtime.h>

@implementation UIApplication (RMExtension)

-(void)setCurrentViewController:(UIViewController *)currentViewController{
    
    objc_setAssociatedObject(self, @selector(currentViewController), currentViewController, OBJC_ASSOCIATION_ASSIGN);
}


-(UIViewController *)currentViewController{
    
    UIViewController * appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController * topVC = appRootVC;
    
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }else if ([topVC isKindOfClass:[UITabBarController class]]){
        topVC = [(UITabBarController *)topVC selectedViewController];
    }else if([topVC isKindOfClass:[UINavigationController class]]){
        topVC = [(UINavigationController *)topVC viewControllers][0];
    }
    return topVC;
}


@end
