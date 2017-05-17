//
//  FirstViewController.m
//  RMUrlRouter
//
//  Created by ohhh on 2017/5/16.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (nonatomic,  copy) NSString * title;

@property (nonatomic,  copy) NSString * desc;

@property (nonatomic,  copy) NSString * qw;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    NSLog(@"========  First :   title = %@,    desc = %@",self.title,self.desc);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
