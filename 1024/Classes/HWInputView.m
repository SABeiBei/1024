//
//  HWInputView.m
//  1024
//
//  Created by AndyHu on 17/1/5.
//  Copyright © 2017年 AndAndyHucom.Andy.1024. All rights reserved.
//

#import "HWInputView.h"
#import "HWDefines.h"

#define kWidth      280
#define kHeight     200

typedef void(^HWConfirmBlock)(HWInputView *inputView,NSString *code);
typedef void(^HWCloseBlock)(HWInputView *inputView);

@interface HWInputView()

@property (nonatomic, copy) HWConfirmBlock  confirmBlock;
@property (nonatomic, copy) HWCloseBlock    closeBlock;

@property (nonatomic, strong) UITextField   *tf;

@end

@implementation HWInputView

+ (instancetype)inputViewWithConfirmBlock:(void(^)(HWInputView *inputView,NSString *code))confirmBlock
                               closeBlock:(void(^)(HWInputView *inputView))closeBlock {
    
    HWInputView *inputView = [[HWInputView alloc] initWithFrame:CGRectMake(0, 0, kMain_Screen_Width, kMain_Screen_Height)];
    inputView.confirmBlock = confirmBlock;
    inputView.closeBlock = closeBlock;
    [[UIApplication sharedApplication].keyWindow addSubview:inputView];
    return inputView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [self prepareSubviews];
        
    }
    return self;
}

- (void)prepareSubviews {
    
    float bgW = kMain_Screen_Width - 40;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, bgW , 200)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.clipsToBounds = YES;
    bgView.layer.cornerRadius = 6;
    [self addSubview:bgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgW, 30)];
    label.text = @"输入code";
    label.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:label];
    
    _tf = [[UITextField alloc] initWithFrame:CGRectMake(20, 50, bgW - 40, 80)];
    _tf.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3];
    _tf.placeholder = @"土逼，大声说你是傻逼";
    [bgView addSubview:_tf];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 150, bgW, 50);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
}

- (void)clickConfirmButton {
    
    if (_confirmBlock) {
        NSString *code = _tf.text ? :@"";
        _confirmBlock(self,code);
    }
    _confirmBlock = nil;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            [self removeFromSuperview];
        }];
    });
    
}

- (void)valicatedSuccess:(BOOL)isSuccess {
    
    if (isSuccess) {
        _tf.text = @"成功";
    }
    else {
        _tf.text = @"不对";
    }
}

@end
