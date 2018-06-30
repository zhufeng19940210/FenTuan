//
//  UIViewController+LCENavigationBar.m
//  LCElevator
//
//  Created by HJR on 2017/6/12.
//  Copyright © 2017年 HJR. All rights reserved.
//

#import "UIViewController+LCENavigationBar.h"

@implementation UIViewController (LCENavigationBar)


- (UIColor *)lce_navigationBarThemeColor
{
    return [UIColor colorWithRed:31/255.0 green:172/255.0 blue:160/255.0 alpha:1];
}

- (void)lce_setNavigationBarThemeColor
{
    
    //[self lce_setNavigationBarColor:[UIColor colorWithRed:(31/255.0f) green:(172/255.0f) blue:(160/255.0f) alpha:1.0]];
   [self lce_setNavigationBarColor:[UIColor colorWithRed:31/255.0 green:172/255.0 blue:160/255.0 alpha:1] alpha:1];
    
}

- (void)lce_setNavigationBarClearColor
{
    [self lce_setNavigationBarColor:[UIColor clearColor] alpha:0];
}

/**
 *  给targetController的导航条设置颜色和透明度
 */
- (void)lce_setNavigationBarColor:(UIColor *)color
                            alpha:(CGFloat)alpha
{
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    UIImage *image = [self createAImageWithColor:color alpha:alpha];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - pravite method
/**
 *  根据颜色和透明度生成一张图片
 */
- (UIImage *)createAImageWithColor:(UIColor *)color
                             alpha:(CGFloat)alpha
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextSetAlpha(context, alpha);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
