//
//  MKMineTC.m
//  MoKu
//
//  Created by Zhang on 16/5/9.
//  Copyright © 2016年 Samuel. All rights reserved.
//

#import "MKMineTC.h"

@interface MKMineTC ()

@end

@implementation MKMineTC
{
    NSArray     * _mineArray;
    
    UIImageView * _avatarImageView;
    UILabel     * _nameLabel;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initNavigation];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self setTableViewConfig];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNavigation {
    self.title = @"我的";
    self.navigationItem.title = @"我的";
    self.tabBarItem.image = [[UIImage imageNamed:@"icon_mine"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
}

- (void)initData {
    _mineArray = @[@[@{}],
                   @[@{@"title":@"输入团队邀请码", @"image":@"icon_cdkey"}],
                   @[@{@"title":@"我的模板", @"image":@"icon_mytemplate"}],
                   @[@{@"title":@"关于魔库", @"image":@"icon_about"},
                     @{@"title":@"分享应用", @"image":@"icon_share"}]];
}

- (void)setTableViewConfig {
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = COLOR_1;
    self.tableView.showsVerticalScrollIndicator = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _mineArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * rowArray = _mineArray[section];
    return rowArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self getPersonalInfoCell];
    }
    return [self getDefaultCell:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = CLEARCOLOR;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)getPersonalInfoCell {
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    
    cell.backgroundColor = WHITECOLOR;
    cell.accessoryType   = UITableViewCellAccessoryDisclosureIndicator;
    
    _avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar"]];
    [cell.contentView addSubview:_avatarImageView];
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView.mas_top).with.offset(12);
        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(76, 76));
    }];
    [_avatarImageView layoutIfNeeded];
    _avatarImageView.layer.cornerRadius  = WIDTH(_avatarImageView) / 2.0;
    _avatarImageView.layer.masksToBounds = YES;
    
    _nameLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarImageView.mas_right).with.offset(13);
        make.centerY.equalTo(_avatarImageView.mas_centerY);
        make.height.mas_equalTo(20);
        make.right.equalTo(cell.contentView.mas_right);
    }];
    [_nameLabel layoutIfNeeded];
    _nameLabel.font      = FONT(16);
    _nameLabel.textColor = COLOR_6;
    _nameLabel.text      = @"登录 / 注册";
    
    return cell;
}

- (UITableViewCell *)getDefaultCell:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineID"];
    
    cell.backgroundColor = WHITECOLOR;
    cell.accessoryType   = UITableViewCellAccessoryDisclosureIndicator;
    cell.separatorInset  = UIEdgeInsetsMake(0, 54, 0, 0);
    
    NSDictionary * dictionary = _mineArray[indexPath.section][indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:dictionary[@"image"]];
    cell.textLabel.text  = dictionary[@"title"];
    cell.textLabel.font  = FONT(16);
    
    if (indexPath.section == 1) {
        cell.textLabel.textColor = COLOR_3;
    }else {
        cell.textLabel.textColor = COLOR_6;
    }
    
    return cell;
}

@end
