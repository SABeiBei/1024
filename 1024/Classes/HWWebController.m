//
//  HWWebController.m
//  1024
//
//  Created by Andy on 2017/1/5.
//  Copyright © 2017年 AndAndyHucom.Andy.1024. All rights reserved.
//

#import "HWWebController.h"
#import <WebKit/WebKit.h>
#import "HWDefines.h"
#import "HWInputView.h"

@interface HWWebController()

@property (nonatomic, strong) WKWebView             *webView;
@property (nonatomic, strong) UIButton              *amazingBtn;

@property (nonatomic, strong) NSMutableArray        *usableUrlArr;

@end

@implementation HWWebController

- (instancetype)init {
    self = [super init];
    if (self) {
        _usableUrlArr = [NSMutableArray array];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareWebview];
    [self prepareAmazingButton];
    [self loadWebWithURL:[self initialURLString]];
    [self getUsableUrls];
}

- (void)prepareWebview {
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
}

- (void)prepareAmazingButton {
    
    _amazingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _amazingBtn.frame = CGRectMake(kMain_Screen_Width - 60, 60, 50, 50);
    _amazingBtn.clipsToBounds = YES;
    _amazingBtn.layer.cornerRadius = 25;
    _amazingBtn.backgroundColor = [UIColor orangeColor];
    [_amazingBtn setTitle:@"土逼" forState:UIControlStateNormal];
    [_amazingBtn addTarget:self action:@selector(amazing) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_amazingBtn];
}

- (void)amazing {
    
    [HWInputView inputViewWithConfirmBlock:^(HWInputView *inputView, NSString *code) {
        if ([code length] > 0 && [code isEqualToString:[self activateCode]]) {
            if ([_usableUrlArr count] > 0) {
                [inputView valicatedSuccess:YES];
                [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[_usableUrlArr firstObject]]]];
            }
        }
        else {
            [inputView valicatedSuccess:NO];
        }
    } closeBlock:nil];
    // 重新获取可用urls
    [self getUsableUrls];
}

- (void)loadWebWithURL:(NSString *)url {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
}

- (void)getUsableUrls {
    
    [_usableUrlArr removeAllObjects];
    NSArray *urls = [self get1024URLs];
    __weak typeof(self) weakSelf = self;
    for (NSString *urlString in urls) {
        NSURL *URL = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
        [request setHTTPMethod:@"HEAD"];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                @synchronized (weakSelf.usableUrlArr) {
                    [weakSelf.usableUrlArr addObject:urlString];
                }
            }
        }];
        [task resume];
    }
}




#pragma mark -- JSPatch Method
- (NSString *)initialURLString {
    
    return @"https://www.baidu.com";
}

- (NSString *)activateCode {
    
    return @"我是傻逼";
}

- (NSArray *)get1024URLs {
    
    return nil;
}

@end
