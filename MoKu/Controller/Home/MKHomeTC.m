//
//  MKHomeTC.m
//  MoKu
//
//  Created by Zhang on 16/5/8.
//  Copyright © 2016年 Samuel. All rights reserved.
//

#import "MKHomeTC.h"

@interface MKHomeTC () <SDCycleScrollViewDelegate>

@end

#define BANNERSCALE_HW          (320 / 750.0)
#define TOOL_CELL_HEIGHT        ((SCREENHEIGHT - TABBARHEIGHT - NAVIGATIONHEIGHT - BANNERSCALE_HW * SCREENWIDTH - 75) / 3.0)
#define LABELFONTSCALE_FW(s)    ((s) / 375.0 * SCREENWIDTH)
#define TOOLBUTTONSCALL(s)      ((s) / 375.0 * SCREENWIDTH)

@implementation MKHomeTC
{
    SDCycleScrollView * _cycleScrollView;
    UILabel           * _hotLabela;
    UILabel           * _hotLabelb;
    
    NSTimer           * _hotTimer;
    NSInteger           _currentHotIndex;
    BOOL                _isHotAnimateOver;
    
    NSArray           * _tooltitleArr;
    NSArray           * _toolDiscArr;
    NSArray           * _toolImageArr;
    NSArray           * _tempTestArr;
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
    //去掉navigationBar下面的横线
    [self findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_tempTestArr.count < 2) {
        return;
    }
    
    if (!_hotTimer) {
        [self initHotTimer];
    }else {
        [self performSelector:@selector(continueTimer) withObject:nil afterDelay:1];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (_hotTimer) {
        [self pauseTimer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNavigation {
    self.title = @"首页";
    UIImageView * titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mo_logo"]];
    self.navigationItem.titleView = titleImageView;
    self.tabBarItem.image = [[UIImage imageNamed:@"icon_home"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
}

- (void)setTableViewConfig {
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = WHITECOLOR;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)initData {
    _tooltitleArr = @[@"添加水印", @"编辑模板", @"创意文案"];
    _toolDiscArr  = @[@"编辑个人专属水印", @"创建自己的宣传美图", @"瞬间提升朋友圈逼格"];
    _toolImageArr = @[@"icon_watermark", @"icon_template", @"icon_copy"];
    _currentHotIndex = 0;
    _isHotAnimateOver = YES;
    _tempTestArr  = @[@"我叫张艺龙", @"我是新疆人", @"你叫阮景辉", @"你是河南人"];
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return BANNERSCALE_HW * SCREENWIDTH;
        }
        return 50;
    }
    return TOOL_CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [self getCycleScrollViewCell];
        }
        return [self getHotCell];
    }
    return [self getToolCell:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView * view = [UIView new];
        view.backgroundColor = COLOR_1;
        return view;
    }
    return nil;
}

- (UITableViewCell *)getCycleScrollViewCell {
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = WHITECOLOR;
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, BANNERSCALE_HW * SCREENWIDTH) imageURLStringsGroup:nil];
    _cycleScrollView.delegate = self;
    _cycleScrollView.pageDotColor = COLOR_1;
    _cycleScrollView.currentPageDotColor = COLOR_2;
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [cell.contentView addSubview:_cycleScrollView];
    
    return cell;
}

- (UITableViewCell *)getHotCell {
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = WHITECOLOR;
    
    UILabel * titleLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).with.offset(20);
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.height.greaterThanOrEqualTo(@20);
        make.width.greaterThanOrEqualTo(@20);
    }];
    [titleLabel layoutIfNeeded];
    titleLabel.font      = BOLDFONT(15);
    titleLabel.textColor = COLOR_2;
    titleLabel.text      = @"MOKU头条";
    
    UIView * seperatorView = [[UIView alloc] init];
    [cell.contentView addSubview:seperatorView];
    [seperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).with.offset(10);
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(1, 20));
    }];
    [seperatorView layoutIfNeeded];
    seperatorView.backgroundColor = COLOR_4;
    
    UIView * hotView = [[UIView alloc] init];
    [cell.contentView addSubview:hotView];
    [hotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(seperatorView.mas_right).with.offset(10);
        make.width.lessThanOrEqualTo(@(SCREENWIDTH - 61 - WIDTH(titleLabel)));
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.height.mas_equalTo(20);
    }];
    hotView.backgroundColor = cell.backgroundColor;
    hotView.clipsToBounds   = YES;
    
    _hotLabela = [[UILabel alloc] init];
    [hotView addSubview:_hotLabela];
    [_hotLabela mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hotView.mas_left);
        make.right.equalTo(hotView.mas_right);
        make.top.equalTo(hotView.mas_top);
        make.bottom.equalTo(hotView.mas_bottom);
    }];
    [_hotLabela layoutIfNeeded];
    _hotLabela.font      = FONT(15);
    _hotLabela.textColor = COLOR_6;
    _hotLabela.backgroundColor = hotView.backgroundColor;
    
    _hotLabelb = [[UILabel alloc] init];
    [hotView addSubview:_hotLabelb];
    [_hotLabelb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hotView.mas_left);
        make.right.equalTo(hotView.mas_right);
        make.top.equalTo(_hotLabela.mas_bottom);
        make.height.equalTo(_hotLabela.mas_height);
    }];
    [_hotLabelb layoutIfNeeded];
    _hotLabelb.font      = _hotLabela.font;
    _hotLabelb.textColor = _hotLabela.textColor;
    _hotLabelb.backgroundColor = hotView.backgroundColor;
    
    [self setHotLabelText];
    
    return cell;
}

- (UITableViewCell *)getToolCell:(NSInteger)index {
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = WHITECOLOR;
    
    UIImageView * toolImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_toolImageArr[index]]];
    [cell.contentView addSubview:toolImageView];
    [toolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
        make.top.equalTo(cell.contentView.mas_top).with.offset(15);
        make.bottom.equalTo(cell.contentView.mas_bottom);
        make.width.mas_equalTo((TOOL_CELL_HEIGHT - 15) * 1.2);
    }];
    toolImageView.layer.cornerRadius  = 5;
    toolImageView.layer.masksToBounds = YES;
    
    UILabel * titleLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(toolImageView.mas_centerY);
        make.left.equalTo(toolImageView.mas_right).with.offset(15);
        make.width.greaterThanOrEqualTo(@20);
        make.height.mas_equalTo(20);
    }];
    titleLabel.font      = FONT(LABELFONTSCALE_FW(16));
    titleLabel.textColor = COLOR_6;
    titleLabel.text      = _tooltitleArr[index];
    
    UILabel * discLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:discLabel];
    [discLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_left);
        make.top.equalTo(toolImageView.mas_centerY);
        make.width.greaterThanOrEqualTo(@20);
        make.height.mas_equalTo(20);
    }];
    discLabel.font      = FONT(LABELFONTSCALE_FW(14));
    discLabel.textColor = titleLabel.textColor;
    discLabel.text      = _toolDiscArr[index];
    
    UILabel * btnLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:btnLabel];
    [btnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cell.contentView.mas_right).with.offset(-15);
        make.centerY.equalTo(toolImageView.mas_centerY);
        make.width.mas_equalTo(TOOLBUTTONSCALL(80));
        make.height.mas_equalTo(TOOLBUTTONSCALL(30));
    }];
    btnLabel.backgroundColor     = COLOR_2;
    btnLabel.layer.cornerRadius  = 5;
    btnLabel.layer.masksToBounds = YES;
    btnLabel.textColor           = WHITECOLOR;
    btnLabel.font                = FONT(LABELFONTSCALE_FW(15));
    btnLabel.text                = @"马上使用";
    btnLabel.textAlignment       = NSTextAlignmentCenter;
    
    return cell;
}

- (void)setHotLabelText {
    _hotLabela.text = _tempTestArr[_currentHotIndex];
    if (_tempTestArr.count > 1) {
        _hotLabelb.text = _tempTestArr[_currentHotIndex + 1];
    }
}

- (void)initHotTimer {
    _hotTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollHotAction) userInfo:nil repeats:YES];
}

- (void)pauseTimer {
    [_hotTimer setFireDate:[NSDate distantFuture]];
}

- (void)continueTimer {
    [_hotTimer setFireDate:[NSDate distantPast]];
}

- (void)scrollHotAction {
    if (!_isHotAnimateOver) {
        return;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        _isHotAnimateOver = NO;
        _hotLabela.frame = CGRectMake(X(_hotLabela), Y(_hotLabela) - HEIGHT(_hotLabela), WIDTH(_hotLabela), HEIGHT(_hotLabela));
        _hotLabelb.frame = CGRectMake(X(_hotLabelb), Y(_hotLabelb) - HEIGHT(_hotLabelb), WIDTH(_hotLabelb), HEIGHT(_hotLabelb));
    } completion:^(BOOL finished) {
        _isHotAnimateOver = YES;
        
        if (Y(_hotLabela) < 0) {
            _currentHotIndex = _currentHotIndex + 2;
            
            _hotLabela.frame = CGRectMake(X(_hotLabela), Y(_hotLabela) + HEIGHT(_hotLabela) * 2, WIDTH(_hotLabela), HEIGHT(_hotLabela));
            
            if (_currentHotIndex < 0 || _currentHotIndex >= _tempTestArr.count) {
                _currentHotIndex = 0;
            }
            _hotLabela.text = _tempTestArr[_currentHotIndex];
        }
        if (Y(_hotLabelb) < 0) {
            _currentHotIndex ++;
            
            _hotLabelb.frame = CGRectMake(X(_hotLabelb), Y(_hotLabelb) + HEIGHT(_hotLabelb) * 2, WIDTH(_hotLabelb), HEIGHT(_hotLabelb));
            
            if (_currentHotIndex < 0 || _currentHotIndex >= _tempTestArr.count) {
                _currentHotIndex = 0;
            }
            _hotLabelb.text = _tempTestArr[_currentHotIndex];
        }
    }];
}

@end
