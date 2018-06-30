//  BaseVC.h
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController
//初始化的页码
@property (nonatomic,assign)int pageNo;
/// 设置UINavbar左按钮（图片）
- (void)setLeftButtonWithImage:(UIImage *)image;
/// 设置UINavbar左按钮（文字）
- (void)setLeftButtonText:(NSString *)text;
/// 设置UINavbar右按钮（图片）
- (void)setRightButtonWithImage:(UIImage *)image;
/// 设置UINavbar右按钮（文字）
- (void)setRightButtonText:(NSString *)text;

- (void)navigationBarLeftButtonEvent:(UIButton *)sender;
- (void)navigationBarRightButtonEvent:(UIButton *)sender;

- (void)backViewController;
//显示弹窗了
- (void)showTipsView;
//刷新列表
- (void)setViewRefresh:(UITableView *)tableView withHeaderAction:(SEL)hAction andFooterAction:(SEL)fAction target:(id)target;
//显示数据为空
-(void)setEmptyTableView:(UITableView *)tableView;
@end
