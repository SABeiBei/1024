//
//  HWWebController.m
//  1024
//
//  Created by Andy on 2017/1/5.
//  Copyright © 2017年 AndAndyHucom.Andy.1024. All rights reserved.
//

#import "HWWebController.h"
#import <WebKit/WebKit.h>


@interface HWWebController()

@property (nonatomic, strong) WKWebView             *webView;

@end

@implementation HWWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareWebview];
    [self loadWebWithURL:[self initialURLString]];
}

- (void)prepareWebview {
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
}

- (void)loadWebWithURL:(NSString *)url {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
}





#pragma mark -- JSPatch Method
- (NSString *)initialURLString {
    
    return @"https://www.baidu.com";
}

@end
