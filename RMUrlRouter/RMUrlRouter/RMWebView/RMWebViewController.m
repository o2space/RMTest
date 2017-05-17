//
//  RMWebViewController.m
//  RMUrlRouter
//
//  Created by ohhh on 2017/5/16.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import "RMWebViewController.h"
#import <WebKit/WebKit.h>

@interface RMWebViewController ()

@property (nonatomic,  weak) WKWebView * webV;

@end

@implementation RMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webV.hidden = NO;
    
}


#pragma mark -set data
-(void)setUrl:(NSString *)url{
    
    _url = url;
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL  URLWithString:url]];
    
    [self.webV loadRequest:request];
}


#pragma mark -make ui
-(WKWebView *)webV{
    
    if (!_webV) {
        
        WKWebView * webV = [[WKWebView alloc]initWithFrame:self.view.bounds];
        webV.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:webV];
        _webV = webV;
    }
    return _webV;
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
