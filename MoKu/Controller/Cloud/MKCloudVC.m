//
//  MKCloudVC.m
//  MoKu
//
//  Created by Zhang on 16/5/9.
//  Copyright © 2016年 Samuel. All rights reserved.
//

#import "MKCloudVC.h"

@interface MKCloudVC () <MKTabViewDelegate, UIScrollViewDelegate>

@end

@implementation MKCloudVC
{
    MKTabView    * _tabView;
    
    UIScrollView * _feedsScrollView;
    MKFeedsView  * _feedsView;
    
    NSInteger      _currentTabIndex;
    CGFloat        _feedsDragOverOffsetX;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initNavigation];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WHITECOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initData];
    [self initTab];
    [self initFeeds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNavigation {
    self.title = @"云库";
    self.navigationItem.title = @"云库";
    self.tabBarItem.image = [[UIImage imageNamed:@"icon_cloud"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
}

- (void)initData {
    _feedsDragOverOffsetX = 0.0;
    _currentTabIndex      = -1;
}

- (void)initTab {
    _tabView = [[MKTabView alloc] initWithFrame:CGRectMake(0, NAVIGATIONHEIGHT, SCREENWIDTH, 42)];
    _tabView.delegate = self;
    [self.view addSubview:_tabView];
}

- (void)initFeeds {
    _feedsScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_feedsScrollView];
    [_feedsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tabView.mas_bottom).with.offset(0.5);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(- TABBARHEIGHT);
    }];
    [_feedsScrollView layoutIfNeeded];
    _feedsScrollView.pagingEnabled = YES;
    _feedsScrollView.showsHorizontalScrollIndicator = NO;
    _feedsScrollView.delegate = self;
    
    for (NSInteger i = 0; i < 5; i ++) {
        MKFeedsView * feedsView = [[MKFeedsView alloc] initWithFrame:CGRectMake(i * SCREENWIDTH, 0, SCREENWIDTH, HEIGHT(_feedsScrollView))];
        [_feedsScrollView addSubview:feedsView];
    }
    
    _feedsScrollView.contentSize = CGSizeMake(SCREENWIDTH * 5, HEIGHT(_feedsScrollView));
}

#pragma mark MKTabViewDelegate
- (void)changeTab:(UILabel *)tabLabel sepeatorView:(UIView *)sepeatorView type:(ChangeTabType)changeTabType {
    [UIView animateWithDuration:0.3 animations:^{
        sepeatorView.frame = CGRectMake(X(tabLabel), Y(sepeatorView), WIDTH(tabLabel), HEIGHT(sepeatorView));
    }];
    
    if (changeTabType == ChangeTabTypeTap) {
        NSInteger index = tabLabel.tag - 100;
        [UIView animateWithDuration:0.3 animations:^{
            _feedsScrollView.contentOffset = CGPointMake(index * SCREENWIDTH, 0);
        }];
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_currentTabIndex != -1) {
        return;
    }
    if (scrollView.contentOffset.x != _feedsDragOverOffsetX) {
        if (scrollView.decelerating) {
            if (scrollView.contentOffset.x > _feedsDragOverOffsetX) {
                _currentTabIndex = scrollView.contentOffset.x / SCREENWIDTH + 1;
                [_tabView changeTab:_currentTabIndex];
            }
            if (scrollView.contentOffset.x < _feedsDragOverOffsetX) {
                _currentTabIndex = scrollView.contentOffset.x / SCREENWIDTH;
                [_tabView changeTab:_currentTabIndex];
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _currentTabIndex = -1;
    scrollView.scrollEnabled = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _feedsDragOverOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    scrollView.scrollEnabled = NO;
}

@end
