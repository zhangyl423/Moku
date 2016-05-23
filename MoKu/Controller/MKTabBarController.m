//
//  MKTabBarController.m
//  MoKu
//
//  Created by Zhang on 16/5/9.
//  Copyright © 2016年 Samuel. All rights reserved.
//

#import "MKTabBarController.h"

@interface MKTabBarController ()

@end

@implementation MKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarViewControllers];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithHexString:@"828282"]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:COLOR_3} forState:UIControlStateSelected];
    
    self.selectedIndex = 0;
    self.tabBar.opaque = YES;
    self.tabBar.tintColor = COLOR_3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //淡化tabBar下面的横线
    [self changeColorWithTabBarLine];
}

- (void)setTabBarViewControllers {
    MKNavigationController * homeNav  = [[MKNavigationController alloc] initWithRootViewController:[[MKHomeTC alloc] init]];
    MKNavigationController * cloudNav = [[MKNavigationController alloc] initWithRootViewController:[[MKCloudVC alloc] init]];
    MKNavigationController * mineNav  = [[MKNavigationController alloc] initWithRootViewController:[[MKMineTC alloc] init]];
    
    self.viewControllers = @[homeNav, cloudNav, mineNav];
}

- (void)changeColorWithTabBarLine {
    for (UIView * view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1) {
            UIImageView * imageView = (UIImageView *)view;
            imageView.backgroundColor = COLOR_7;
        }
    }
}


@end
