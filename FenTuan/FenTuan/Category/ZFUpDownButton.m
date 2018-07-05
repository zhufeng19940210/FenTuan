//  ZFUpDownButton.m
//  GuomeiDemo
//  Created by bailing on 2018/6/12.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "ZFUpDownButton.h"
#import "UIVieW+myFrame.h"
@implementation ZFUpDownButton
///代码创建的时候会调用这个方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
///xib调用时候会调用
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}
#pragma mark setupUI
-(void)setupUI
{
    ///设置文字的对齐方式和颜色
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.myButtonType == ButtonTypeImageUp ) {
        //图片在下面
        self.titleLabel.zf_centerX = self.zf_width * 0.5;
        self.titleLabel.zf_y =  self.zf_height * 0.5 - 10;
        ///自己使用高度
        [self.titleLabel sizeToFit];
        ///这个是居中显示
        self.imageView.zf_centerX = self.zf_width * 0.5;
        self.imageView.zf_y = self.titleLabel.zf_bottom + 10;
    }else{
        //图片在上面
        self.imageView.zf_centerX = self.zf_width * 0.5;
        self.imageView.zf_y =  self.zf_height * 0.5 -10;
        ///自己使用高度
        [self.titleLabel sizeToFit];
        ///这个是居中显示
        self.titleLabel.zf_centerX = self.zf_width * 0.5;
        self.titleLabel.zf_y = self.imageView.zf_bottom + 0.12;
    }
}
@end
