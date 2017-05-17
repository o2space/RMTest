//
//  UIAlertView+RMExtension.m
//  RMUrlRouter
//
//  Created by ohhh on 2017/5/15.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import "UIAlertView+RMExtension.h"
#import "RMUrlRouteConfig.h"

@implementation UIAlertView (RMExtension)

+ (void)showMessage:(NSString *)message{
    
#ifdef DEBUG
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@""
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil,
                           nil];
    [alert show];
#endif
}

@end
