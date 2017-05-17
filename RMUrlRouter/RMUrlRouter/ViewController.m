//
//  ViewController.m
//  RMUrlRouter
//
//  Created by ohhh on 2017/5/15.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import "ViewController.h"
#import "RMUrlRoute.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [[RMUrlRouteList shareRouteList] addUrlRouteWithUrlKey:@"rm://com.rm.conch/second" className:@"SecondViewController"];
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 80, 40)];
    
    btn.backgroundColor = [UIColor redColor];
    
    [btn addTarget:self action:@selector(redBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
    UIButton * blueBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 160, 80, 40)];
    
    blueBtn.backgroundColor = [UIColor blueColor];
    
    [blueBtn addTarget:self action:@selector(blueBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:blueBtn];
    
    
    UIButton * orangeBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 80, 40)];
    
    orangeBtn.backgroundColor = [UIColor orangeColor];
    
    [orangeBtn addTarget:self action:@selector(orangeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:orangeBtn];
    
}


- (void)redBtnClick{
    
//    [[RMUrlRouteCenter shareCenter] open:@"rm://com.rm.conch/first?title=sdsd&desc=AAAAAAA" animated:YES];
    [[RMUrlRouteCenter shareCenter] open:@"rm://com.rm.conch/first" animted:YES extraParams:@{@"title":@"qwe",@"desc":@12}];
}

- (void)blueBtnClick{
    
//    [[RMUrlRouteCenter shareCenter] open:@"rm://com.rm.conch/second" animated:YES];
    [[RMUrlRouteCenter shareCenter] open:@"rm://com.rm.conch/second" animated:YES pageJumpType:kRMUrlRouterPageJumpTypePresent];
}

- (void)orangeBtnClick{
    
//    [[RMUrlRouteCenter shareCenter] open:@"https://www.baidu.com" animated:YES];
    [[RMUrlRouteCenter shareCenter] open:nil animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
