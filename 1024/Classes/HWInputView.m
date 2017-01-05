//
//  HWInputView.m
//  1024
//
//  Created by AndyHu on 17/1/5.
//  Copyright © 2017年 AndAndyHucom.Andy.1024. All rights reserved.
//

#import "HWInputView.h"
#import "HWDefines.h"

#define kWidth      200
#define kHeight     100

typedef void(^HWConfirmBlock)(HWInputView *inputView);
typedef void(^HWCloseBlock)(HWInputView *inputView);

@interface HWInputView()

@property (nonatomic, copy) HWConfirmBlock  confirmBlock;
@property (nonatomic, copy) HWCloseBlock    closeBlock;

@end

@implementation HWInputView

+ (instancetype)inputViewWithConfirmBlock:(void(^)(HWInputView *inputView))confirmBlock
                               closeBlock:(void(^)(HWInputView *inputView))closeBlock {
    
    HWInputView *inputView = [[HWInputView alloc] initWithFrame:CGRectMake((kMain_Screen_Width - kWidth)/2, (kMain_Screen_Height - kHeight)/2, kWidth, kHeight)];
    inputView.confirmBlock = confirmBlock;
    inputView.closeBlock = closeBlock;
    return inputView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareSubviews];
    }
    return self;
}

- (void)prepareSubviews {
    
    
}

@end
