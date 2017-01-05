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
    
    
}

- (void)loadWebWithURL:(NSString *)url {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
}

- (NSArray *)urls {
    
    return @[@"https://www.teld.cn"];
}



#pragma mark -- JSPatch Method
- (NSString *)initialURLString {
    
    return @"https://www.baidu.com";
}

@end
