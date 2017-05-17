//
//  RMUrlRouteList.m
//  RMUrlRouter
//
//  Created by ohhh on 2017/5/16.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import "RMUrlRouteList.h"
#import "RMUrlRouteConfig.h"
#import "UIAlertView+RMExtension.h"

@implementation RMUrlRouteList{

    NSMutableDictionary * routeListDict;
}

+ (RMUrlRouteList *)shareRouteList{
    
    static RMUrlRouteList * list = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        list = [[self alloc]init];
    });
    return list;
}

-(instancetype)init{
    if (self = [super init]) {
        
        [self urlRouteDict];
    }
    return self;
}

- (NSMutableDictionary *)urlRouteList{
    
    return routeListDict;
}

- (NSMutableDictionary *)urlRouteDict{
    
    routeListDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                     @"FirstViewController",[NSString stringWithFormat:@"%@%@",RM_URL_HOST,@"/first"],// 登陆页面
                     nil];
    return routeListDict;
}

- (void)addUrlRouteWithUrlKey:(NSString *)urlKey className:(NSString *)className{
    
    if (routeListDict) {
        [routeListDict setValue:className forKey:urlKey];
    }else{
        routeListDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                         className,urlKey,
                         nil];
    }
}

- (void)addUrlRouteWithDict:(NSDictionary *)dict{
    
    if (!routeListDict) {
        routeListDict = [NSMutableDictionary dictionary];
    }
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [routeListDict setValue:obj forKey:key];
    }];
}


@end
