//
//  UIViewController+LCENavigationBar.h
//  LCElevator
//
//  Created by HJR on 2017/6/12.
//  Copyright © 2017年 HJR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LCENavigationBar)

@property (nonatomic, strong, readonly) UIColor *lce_navigationBarThemeColor;

- (void)lce_setNavigationBarThemeColor;

- (void)lce_setNavigationBarClearColor;

/**
 设置导航条颜色、透明度

 @param color 颜色
 @param alpha 透明度
 */
- (void)lce_setNavigationBarColor:(UIColor *)color
                            alpha:(CGFloat)alpha;

@end
