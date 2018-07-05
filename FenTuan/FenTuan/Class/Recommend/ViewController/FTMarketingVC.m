//  FTMarketingVC.m
//  FenTuan
//  Created by bailing on 2018/7/3.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTMarketingVC.h"
#import "FTRecommendCell.h"
#import "FTReSelectTypeCell.h"
@interface FTMarketingVC () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign)BOOL  fingerIsTouch;
@end
@implementation FTMarketingVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}
- (void)setupSubViews
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,IPHONE_WIDTH, IPHONE_HEIGHT - 160) style:UITableViewStylePlain];
    self.tableView .delegate = self;
    self.tableView .dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"FTRecommendCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FTRecommendCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FTReSelectTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FTReSelectTypeCell"];
    [self.view addSubview:self.tableView ];
}
#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 50;
    }else{
        return 260;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        FTReSelectTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTReSelectTypeCell"];
        return cell;
    }else{
        FTRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTRecommendCell"];
        return cell;
    }
}

#pragma mark UIScrollView
//判断屏幕触碰状态
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"接触屏幕");
    self.fingerIsTouch = YES;
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"离开屏幕");
    self.fingerIsTouch = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        //        if (!self.fingerIsTouch) {//这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
        //            return;
        //        }
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
    }
    self.tableView.showsVerticalScrollIndicator = self.vcCanScroll?YES:NO;
}

@end
