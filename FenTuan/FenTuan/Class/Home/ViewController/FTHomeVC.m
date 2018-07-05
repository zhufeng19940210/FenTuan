//  FTHomeVC.m
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTHomeVC.h"
#import "FTBanaerCell.h"
#import "FTProductCell.h"
@interface FTHomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *imageUrl;
@end
@implementation FTHomeVC
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
        _imageUrl = [NSMutableArray arrayWithObjects:@"http://14.29.68.166:8862/advertising/2018/05/3c299c20658f42feabedd3e44e0836e8.png",@"http://14.29.68.166:8862/advertising/2018/05/5ac356e1e0be45bebec509b390c80e44.jpg",@"http://14.29.68.166:8862/advertising/2018/05/aee8867013a845cc826538dfd5f69b62.jpg", nil];
    }
    return _imageUrl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    [self setupNav];
    [self setupTableView];
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
        return buleView;
    }else{
        return nil;
    }
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
    NSLog(@"offsetY:%f",offsetY);
    // 修改组头悬挂位置
    CGFloat height = IPHONE_WIDTH * (362/745.0);
    if (offsetY >= height) {
        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}
@end
