//  BaseVC.m
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "BaseVC.h"
@interface BaseVC ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@end
@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        //  标题
        NSDictionary * attributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
        [self.navigationController.navigationBar setTitleTextAttributes:attributes];
        // 设置状态栏覆盖
        [self.navigationController.navigationBar setTranslucent:NO];
        // shadowline
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
        
        self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        
        [self setNeedsStatusBarAppearanceUpdate];
    }
    [self setBackwardButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//返回按钮
- (void)setBackwardButton{
    NSArray *viewControllers = [self.navigationController viewControllers];
    if (viewControllers.count > 1) {
        UIImage *image =[UIImage imageNamed:@"arrow_left"];
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
        [leftBtn setImage:image forState:UIControlStateNormal];
        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, -5.0, 0.0, 5.0);
        [leftBtn addTarget:self action:@selector(navigationBarLeftButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    }
}

#pragma mark - NavigationItem
- (void)setLeftButtonWithImage:(UIImage *)image
{
    if (image) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:image forState:UIControlStateNormal];
        // button size
        btn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, -4.0, 0.0, 4.0);
        // button target
        [btn addTarget:self action:@selector(navigationBarLeftButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = barItem;
    } else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc]init]];
    }
}

- (void)setLeftButtonText:(NSString *)text
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn sizeToFit];
    // button target
    [btn addTarget:self action:@selector(navigationBarLeftButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barItem;
}

- (void)setRightButtonWithImage:(UIImage *)image
{
    if (image) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:image forState:UIControlStateNormal];
        // button size
        btn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 4.0, 0.0, -4.0);
        // button target
        [btn addTarget:self action:@selector(navigationBarRightButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.rightBarButtonItem = barItem;
    }else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc]init]];
    }
}

- (void)setRightButtonText:(NSString *)text
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, -4);
    // button target
    [btn addTarget:self action:@selector(navigationBarRightButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;
}

#pragma mark - Actions
- (void)navigationBarLeftButtonEvent:(UIButton *)sender
{
    
}
- (void)navigationBarRightButtonEvent:(UIButton *)sender
{
}
- (void)backViewController
{   //加一个保险下哈哈
    [SVProgressHUD dismiss];
    NSArray *viewControllers = [self.navigationController viewControllers];
    // 根据viewControllers的个数来判断此控制器是被present的还是被push的
    if (1 <= viewControllers.count && 0 < [viewControllers indexOfObject:self])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
//刷新列表
- (void)setViewRefresh:(UITableView *)tableView withHeaderAction:(SEL)hAction andFooterAction:(SEL)fAction target:(id)target
{
    // 设置header
    if (hAction) {
        tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:hAction];
    }
    //header.lastUpdatedTimeLabel.hidden = YES;
    if (fAction) {
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:fAction];
    }
    //设置空的数据
    [self setEmptyTableView:tableView];
}
-(void)setEmptyTableView:(UITableView *)tableView
{
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"当前数据为空";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:17],
                                 NSForegroundColorAttributeName:GrayFontColor
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

@end
