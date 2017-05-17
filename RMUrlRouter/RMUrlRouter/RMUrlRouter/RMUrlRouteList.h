//
//  RMUrlRouteList.h
//  RMUrlRouter
//
//  Created by ohhh on 2017/5/16.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMUrlRouteList : NSObject

+ (RMUrlRouteList *)shareRouteList;

- (NSMutableDictionary *)urlRouteList;

- (void)addUrlRouteWithDict:(NSDictionary *)dict;

- (void)addUrlRouteWithUrlKey:(NSString *)urlKey className:(NSString *)className;

@end
