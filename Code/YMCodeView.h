//
//  YMCodeView.h
//  Code
//
//  Created by mini on 2018/1/4.
//  Copyright © 2018年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMCodeView;

@protocol YMCodeViewDelegate<NSObject>

-(void)YMCodeView:(YMCodeView *)view inputString:(NSString *)string;

@end


@interface YMCodeView : UIView


@property (nonatomic, weak) id<YMCodeViewDelegate>delegate;


- (void)registFirst;

- (void)becomeFirst;

@end
