//
//  HWInputView.h
//  1024
//
//  Created by AndyHu on 17/1/5.
//  Copyright © 2017年 AndAndyHucom.Andy.1024. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HWInputView : UIView

+ (instancetype)inputViewWithConfirmBlock:(void(^)(HWInputView *inputView))confirmBlock
                               closeBlock:(void(^)(HWInputView *inputView))closeBlock;

@end
