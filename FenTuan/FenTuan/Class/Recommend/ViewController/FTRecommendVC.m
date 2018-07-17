//  FSBaseViewController.m
//  FSScrollViewNestTableViewDemo
//  Created by huim on 2017/5/23.
//  Copyright © 2017年 fengshun. All rights reserved.
#import "FTRecommendVC.h"
#import "FSBaseTableView.h"
#import "FSBottomTableViewCell.h"
#import "FSPageContentView.h"
#import "FTReTypeView.h"
#import "FTProductsFeaturedVC.h"
#import "FTMarketingVC.h"
#import "FTNoviceVC.h"
#import "FTReHeaderCell.h"
@interface FTRecommendVC ()<UITableViewDelegate,UITableViewDataSource,FSPageContentViewDelegate,FTReTypeViewDelegate>
@property (nonatomic, strong) FSBaseTableView *tableView;
@property (nonatomic, strong) FSBottomTableViewCell *contentCell;
@property (nonatomic, strong) FTReTypeView *titleView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic,strong)NSMutableArray *imageArray;
@end
@implementation FTRecommendVC
-(NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithObjects:@"http://14.29.68.166:8862/advertising/2018/05/3c299c20658f42feabedd3e44e0836e8.png",@"http://14.29.68.166:8862/advertising/2018/05/5ac356e1e0be45bebec509b390c80e44.jpg",@"http://14.29.68.166:8862/advertising/2018/05/aee8867013a845cc826538dfd5f69b62.jpg", nil];
    }
    return _imageArray;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
}
- (void)setupSubViews
{
    self.canScroll = YES;
    self.tableView.backgroundColor = [UIColor whiteColor];
    //刷新的东西
//    __weak typeof(self) weakSelf = self;
//    [self.tableView addPullToRefreshWithActionHandler:^{
//        [weakSelf insertRowAtTop];
//    }];
}
- (void)insertRowAtTop
{
    self.contentCell.isRefresh = YES;
}
#pragma mark notify
- (void)changeScrollStatus//改变主视图的状态
{
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}
#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200;
    }
    return CGRectGetHeight(self.view.bounds);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.titleView = [[NSBundle mainBundle] loadNibNamed:@"FTReTypeView" owner:nil options:nil].firstObject;
    self.titleView.delegate = self;
    self.titleView.backgroundColor = [UIColor redColor];
    return self.titleView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        FTReHeaderCell *cell = [FTReHeaderCell reHeaderCellWithTableView:tableView];
        cell.urls = self.imageArray;
        return cell;
    }if (indexPath.section == 1) {
            _contentCell = [tableView dequeueReusableCellWithIdentifier:@"FSBottomTableViewCell"];
            NSArray *titles = @[@"商品推荐",@"营销素材",@"新手必发"];
            NSMutableArray *contentVCs = [NSMutableArray array];
            for (NSString *title in titles) {
                if ([title isEqualToString:@"商品推荐"]) {
                    FTProductsFeaturedVC *productvc = [[FTProductsFeaturedVC alloc]init];
                    [contentVCs addObject:productvc];
                }if ([title isEqualToString:@"营销素材"]) {
                    FTMarketingVC *marketvc = [[FTMarketingVC alloc]init];
                    [contentVCs addObject:marketvc];
                }if ([title isEqualToString:@"新手必发"]) {
                    FTNoviceVC *novicevc = [[FTNoviceVC alloc]init];
                    [contentVCs addObject:novicevc];
                }
            }
            _contentCell.viewControllers = contentVCs;
            _contentCell.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT - 64) childVCs:contentVCs parentVC:self delegate:self];
            [_contentCell.contentView addSubview:_contentCell.pageContentView];
        }
    return _contentCell;
}
#pragma mark FSSegmentTitleViewDelegate
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    // self.titleView.selectIndex = endIndex;
    self.titleView.btnCurrentIndex = (int)endIndex;
    _tableView.scrollEnabled = YES;//此处其实是监测scrollview滚动，pageView滚动结束主tableview可以滑动，或者通过手势监听或者kvo，这里只是提供一种实现方式
}
- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress
{
    _tableView.scrollEnabled = NO;//pageView开始滚动主tableview禁止滑动
}
#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat bottomCellOffset = [_tableView rectForSection:1].origin.y;
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.contentCell.cellCanScroll = YES;
        }
    }else{
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    self.tableView.showsVerticalScrollIndicator = _canScroll?YES:NO;
}
#pragma mark LazyLoad
- (FSBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[FSBaseTableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[FSBottomTableViewCell class] forCellReuseIdentifier:@"FSBottomTableViewCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
#pragma mark
-(void)FTReTypeViewClickTypeButton:(int)index{
    self.contentCell.pageContentView.contentViewCurrentIndex = index;
}
@end


