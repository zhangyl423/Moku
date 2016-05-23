//
//  MKNavigationController.m
//  MoKu
//
//  Created by Zhang on 16/5/9.
//  Copyright © 2016年 Samuel. All rights reserved.
//

#import "MKNavigationController.h"

@interface MKNavigationController ()

@end

@implementation MKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = COLOR_2;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:COLOR_5}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
