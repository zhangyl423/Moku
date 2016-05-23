//
//  MKTabView.h
//  MoKu
//
//  Created by Zhang on 16/5/11.
//  Copyright © 2016年 Samuel. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ChangeTabTypeScroll,
    ChangeTabTypeTap,
} ChangeTabType;

@protocol MKTabViewDelegate <NSObject>

@optional
- (void)changeTab:(UILabel *)tabLabel sepeatorView:(UIView *)sepeatorView type:(ChangeTabType)changeTabType;

@end

@interface MKTabView : UIView

@property (assign, nonatomic) id<MKTabViewDelegate> delegate;

/** 切换tab */
- (void)changeTab:(NSInteger)index;

@end
