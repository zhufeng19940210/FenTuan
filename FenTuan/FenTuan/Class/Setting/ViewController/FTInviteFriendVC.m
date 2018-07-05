//  FTInviteFriendVC.m
//  FenTuan
//  Created by bailing on 2018/7/2.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTInviteFriendVC.h"
#import "FTInveteHeaderCell.h"
#import "FTInveteContentCell.h"
@interface FTInviteFriendVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation FTInviteFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请好友";
    self.view.backgroundColor = RGB(240, 240, 240);
    [self setupTableView];
}
#pragma mark --setupTableView
-(void)setupTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"FTInveteHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FTInveteHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FTInveteContentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FTInveteContentCell"];
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
    }else{
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return  20;
    }else{
        return  CGFLOAT_MIN;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        FTInveteHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTInveteHeaderCell"];
        return cell;
    }else{
        FTInveteContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTInveteContentCell"];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
