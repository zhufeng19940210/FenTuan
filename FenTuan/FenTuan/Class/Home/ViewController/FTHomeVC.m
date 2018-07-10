//  FTHomeVC.m
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTHomeVC.h"
#import "FTBanaerCell.h"
#import "FTProductCell.h"
#import "ADModel.h"
#import "ZJScrollPageView.h"
@interface FTHomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *imageUrl;
//横向滚动视图
@property (nonatomic, weak) ZJScrollPageView *scrollPageView;
@property (nonatomic,strong)NSMutableArray *titleArray;
@end
@implementation FTHomeVC
-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    }
    return _titleArray;
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)imageUrl
{
    if (!_imageUrl) {
        _imageUrl = [NSMutableArray array];
    }
    return _imageUrl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    [self setupNav];
    [self  requestAdURL];
    [self  requestContentData];
    [self setupTableView];
}
#pragma mark --请求轮播图片
-(void)requestAdURL
{
    [[FTNetWorkTool shareInstacne]GetWithUrl:[NSString stringWithFormat:@"%@%@",FTBASE_URL,FT_HOME_BANAER_URL] paramter:nil success:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        FTResponeModel *res = [FTResponeModel mj_objectWithKeyValues:responseObject];
        if (res.head.retCode == 0) {
            NSMutableArray *array = [NSMutableArray array];
            [self.imageUrl removeAllObjects];
            array = [ADModel mj_objectArrayWithKeyValuesArray:res.data];
            for (ADModel *model in array) {
                [self.imageUrl addObject:model.shufflingFigure];
            }
            [self.tableview reloadData];
            NSLog(@"self.imagurl:%lu",(unsigned long)self.imageUrl.count);
        }
    } failrue:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"服务器请求失败"];
        return ;
    }];
}

#pragma mark -- requestContentData
-(void)requestContentData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"pageStart"] = @"1";
    [[FTNetWorkTool shareInstacne]PostWithUrl:[NSString stringWithFormat:@"%@%@",FTBASE_URL,FT_HOME_TUIJIAN_URL] paramter:param success:^(id responseObject) {
        NSLog(@"responseobject:%@",responseObject);
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark -- setupNav
-(void)setupNav
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH*0.8, 34)];
    [button setTitle:@"搜索你想要的" forState:UIControlStateNormal];
    button.backgroundColor = HEXCOLORAL(0x50ADA9, 0.6);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 4.0f;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ksearch"] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    [button addTarget:self action:@selector(searchButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = button;
}
#pragma mark searchButtonEvent
-(void)searchButtonEvent:(UIButton *)button
{
    NSLog(@"搜索按钮响应的事件");
}
#pragma mark -- setupTableView
-(void)setupTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    //注册cell
    [self.tableview registerNib:[UINib nibWithNibName:@"FTProductCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FTProductCell"];
}
#pragma mark -- uitableviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 10;
    }
    else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 50;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *buleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        buleView.backgroundColor = [UIColor yellowColor];
        [buleView addSubview:self.scrollPageView];
        return buleView;
    }else{
        return nil;
    }
}



#pragma mark - getter

- (ZJScrollPageView *)scrollPageView
{
    if(_scrollPageView == nil)
    {
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        //显示滚动条
        style.showLine = YES;
        // 颜色渐变
        style.gradualChangeTitleColor = YES;
        style.contentViewBounces = NO;
        style.animatedContentViewWhenTitleClicked = NO;
        style.autoAdjustTitlesWidth = YES;
        style.scrollLineColor =MainThemeColor;
        style.selectedTitleColor = MainThemeColor;
        style.normalTitleColor = MainThemeColor;
        ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-64) segmentStyle:style titles:_titleArray parentViewController:self delegate:self];
        _scrollPageView = scrollPageView;
        scrollPageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _scrollPageView;
}
#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return self.titleArray.count;
}
- (UIViewController <ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (!childVc) {
        childVc = self.childViewControllers[index];
    }
    return childVc;
}
- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 按比例计算轮播广告cell的高度
        CGFloat height = IPHONE_WIDTH * (362/745.0);
        return height;
    }
    if (indexPath.section == 1) {
        return 120;
    }
    else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FTBanaerCell *cell = [FTBanaerCell advCellWithTableView:tableView];
        cell.urls = self.imageUrl;
        return cell;
    }
    if (indexPath.section == 1) {
        FTProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTProductCell"];
        return cell;
    }
    else{
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    // 修改组头悬挂位置
    CGFloat height = IPHONE_WIDTH * (362/745.0);
    if (offsetY >= height) {
        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}
@end
