//  FTSettingVC.m
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTSettingVC.h"
#import "FTMineAvatarCell.h"
#import "FTPartnerCell.h"
#import "FTSubFunCell.h"
#import "FTDetailSubCell.h"
#import "FTTypeModel.h"
#import "FTMySettingVC.h"
#import "FTUpdatePwdVC.h"
#import "FTInviteFriendVC.h"
@interface FTSettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *iconImageArray;
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)NSMutableArray *subTitleArray;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end
@implementation FTSettingVC
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)iconImageArray
{
    if (!_iconImageArray) {
        _iconImageArray = [NSMutableArray arrayWithObjects:@"share_sina",@"share_sina",@"share_sina",@"share_sina",@"share_sina",@"share_sina", nil];
    }
    return _iconImageArray;
}
-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"我的邀请码",@"邀请好友",@"修改密码",@"帮助中心",@"联系客服",@"设置", nil];
    }
    return _titleArray;
}

-(NSMutableArray *)subTitleArray
{
    if (!_subTitleArray) {
        _subTitleArray = [NSMutableArray arrayWithObjects:@"123456",@"",@"",@"",@"",@"", nil];
    }
    return _subTitleArray;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh];
}
-(void)refresh{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    [self setupData];
    [self setupTableView];
}
-(void)setupData
{
    [self.dataArray removeAllObjects];
    for (int i = 0 ; i< 6; i++) {
        FTTypeModel *model = [[FTTypeModel alloc]init];
        model.iconimagview = self.iconImageArray[i];
        model.titleStr     = self.titleArray[i];
        model.subTitleStr  = self.subTitleArray[i];
        [self.dataArray addObject:model];
    }
}
-(void)setupTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    //注册cell
    [self.tableview registerNib:[UINib nibWithNibName:@"FTMineAvatarCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FTMineAvatarCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"FTPartnerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FTPartnerCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"FTSubFunCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FTSubFunCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"FTDetailSubCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FTDetailSubCell"];
}
#pragma mark -- uitableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 160;
    }
    if (indexPath.section == 1) {
        return 110;
    }
    else{
        return IPHONE_WIDTH / 3 * 2 + 35;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return  CGFLOAT_MIN;
    }else{
        if (section == 1) {
            return 0;
            
        }else{
            return 10;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   return CGFLOAT_MIN;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        FTMineAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTMineAvatarCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 1) {
        FTDetailSubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTDetailSubCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 2) {
        FTSubFunCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTSubFunCell"];
        cell.dataArray = self.dataArray;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.itemBlock = ^(int index) {
            NSLog(@"index:%@",indexPath);
            switch (index) {
                case 0:
                    break;
                case 1:
                {
                    FTInviteFriendVC *inviteFrinedvc = [[FTInviteFriendVC alloc]init];
                    inviteFrinedvc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:inviteFrinedvc animated:YES];
                }
                    break;
                case 2:
                {
                    FTUpdatePwdVC *updatepwdvc = [[FTUpdatePwdVC alloc]init];
                    updatepwdvc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:updatepwdvc animated:YES];
                }
                    break;
                case 3:
                {
                    
                }
                    break;
                case 4:
                {
                    
                }
                    break;
                case 5:
                {
                    FTMySettingVC *mySettingvc = [[FTMySettingVC alloc]init];
                    mySettingvc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:mySettingvc animated:YES];
                }
                    break;
                default:
                    break;
            }
        };
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
