//  UIVieW+myFrame.m
//  GuomeiDemo
//  Created by bailing on 2018/6/12.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import "UIVieW+myFrame.h"

@implementation UIView (myFrame)
///获取x
-(CGFloat)zf_x{
    return self.frame.origin.x;
}
///设置X
-(void)setZf_x:(CGFloat)zf_x
{
    CGRect zfFrame = self.frame;
    zfFrame.origin.x = zf_x;
    self.frame = zfFrame;
}
///获取y
-(CGFloat)zf_y
{
    return self.frame.origin.y;
}
///设置y
-(void)setZf_y:(CGFloat)zf_y
{
    CGRect zfFrame = self.frame;
    zfFrame.origin.y = zf_y;
    self.frame = zfFrame;
}
///获取起点坐标
-(CGPoint)zf_origin
{
    return self.frame.origin;
}
///设置坐标点
-(void)setZf_origin:(CGPoint)zf_origin
{
    CGRect zfFrame = self.frame;
    zfFrame.origin = zf_origin;
    self.frame = zfFrame;
}
///获取宽度
-(CGFloat)zf_width
{
    return  self.frame.size.width;
}
///设置坐标
-(void)setZf_width:(CGFloat)zf_width
{
    CGRect zfFrame = self.frame;
    zfFrame.size.width = zf_width;
    self.frame = zfFrame;
}
///获取高度
-(CGFloat)zf_height
{
    return self.frame.size.height;
}
///设置坐标
-(void)setZf_height:(CGFloat)zf_height
{
    CGRect zfFrame = self.frame;
    zfFrame.size.height = zf_height;
    self.frame = zfFrame;
}
///得到宽和高
-(CGSize)zf_size
{
    return self.frame.size;
}
///设置坐标点
-(void)setZf_size:(CGSize)zf_size
{
    CGRect zfFrame = self.frame;
    zfFrame.size = zf_size;
    self.frame = zfFrame;
}
///中心坐标的x
-(CGFloat)zf_centerX
{
    return self.center.x;
}
///设置中心坐标的x
-(void)setZf_centerX:(CGFloat)zf_centerX
{
    CGPoint zfFrame  = self.center;
    zfFrame.x = zf_centerX;
    self.center = zfFrame;
}
///中心坐标的y
-(CGFloat)zf_centerY
{
    return self.center.y;
}
///设置中心坐标的y
-(void)setZf_centerY:(CGFloat)zf_centerY
{
    CGPoint zfFrame = self.center;
    zfFrame.y = zf_centerY;
    self.center = zfFrame;
}
///获取最大的x
-(CGFloat)zf_right
{
    return CGRectGetMaxX(self.frame);
}
///获取最大的y
-(CGFloat)zf_bottom
{
    return  CGRectGetMaxY(self.frame);
}
///设置最大的x
-(void)setZf_right:(CGFloat)zf_right
{
    self.zf_x = zf_right - self.zf_width;
}
///设置最大的y
-(void)setZf_bottom:(CGFloat)zf_bottom
{
    self.zf_y = zf_bottom - self.zf_height;
    
}

@end
