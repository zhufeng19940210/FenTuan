//  FTMySettingVC.m
//  FenTuan
//  Created by bailing on 2018/7/2.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import "FTMySettingVC.h"
#import "FTMyHeaderCell.h"
#import "FTMyDetailCell.h"
#import "FTMyVersionCell.h"
#import "FTMyLogoutCell.h"
@interface FTMySettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
@implementation FTMySettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(240, 240, 240);
    self.title = @"设置";
    [self setupTableView];
}
-(void)setupTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    //注册cell
    [self.tableview registerNib:[UINib nibWithNibName:@"FTMyHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FTMyHeaderCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"FTMyDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FTMyDetailCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"FTMyVersionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FTMyVersionCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"FTMyLogoutCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FTMyLogoutCell"];
}
#pragma mark -- uitableviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 3;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return  150;
    }
    if (indexPath.section == 1) {
        return  50;
    }
    else{
        return  120;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return  CGFLOAT_MIN;
    }else{
        if (section == 1) {
            return 10;
            
        }else{
            return 0;
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        FTMyHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTMyHeaderCell"];
        return cell;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0 ) {
            FTMyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTMyDetailCell"];
            cell.title_lab.text = @"昵称";
            cell.content_lab.text = @"购物达人";
            return cell;
        }else if (indexPath.row == 1){
            FTMyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTMyDetailCell"];
            cell.title_lab.text = @"清除缓存";
            cell.content_lab.text = @"53M";
            return cell;
        }
        else{
            FTMyVersionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTMyVersionCell"];
            return cell;
        }
    }
    if (indexPath.section == 2) {
        
        FTMyLogoutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTMyLogoutCell"];
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
