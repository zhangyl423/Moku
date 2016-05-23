//
//  MKTabView.m
//  MoKu
//
//  Created by Zhang on 16/5/11.
//  Copyright © 2016年 Samuel. All rights reserved.
//

#import "MKTabView.h"

@interface MKTabView ()

@end

@implementation MKTabView
{
    UIScrollView * _tabScrollView;
    UIView       * _sepeatorView;
    
    NSArray      * _tempTitleArr;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initData];
        [self drawView];
    }
    return self;
}

- (void)initData {
    _tempTitleArr = @[@"魔库", @"澜庭集", @"玫瑰派", @"CBB", @"LATOJA"];
}

- (void)drawView {
    if (_tabScrollView) {
        [_tabScrollView removeFromSuperview];
        _tabScrollView = nil;
    }
    
    _tabScrollView = [[UIScrollView alloc] init];
    [self addSubview:_tabScrollView];
    [_tabScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(SCREENWIDTH);
        make.height.mas_equalTo(42);
    }];
    _tabScrollView.showsHorizontalScrollIndicator = NO;
    
    [_tabScrollView layoutIfNeeded];
    
    UILabel * previousLabel = nil;
    CGFloat contentWidth    = 30 + 10 * (_tempTitleArr.count - 1);
    for (NSInteger i = 0; i < _tempTitleArr.count; i ++) {
        CGFloat labelWidth = [MKPublicManager adapterSizeWithString:_tempTitleArr[i]
                                                       WithMaxWidth:1000
                                                           WithFont:FONT(14)].width;
        
        UILabel * titleLabel = [[UILabel alloc] init];
        [_tabScrollView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (previousLabel) {
                make.left.equalTo(previousLabel.mas_right).with.offset(10);
            }else {
                make.left.equalTo(_tabScrollView.mas_left).with.offset(15);
            }
            make.top.equalTo(_tabScrollView.mas_top);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(labelWidth + 15);
        }];
        [titleLabel layoutIfNeeded];
        titleLabel.font      = FONT(15);
        titleLabel.textColor = COLOR_6;
        titleLabel.text      = _tempTitleArr[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.tag       = 100 + i;
        
        previousLabel = titleLabel;
        contentWidth += WIDTH(titleLabel);
        
        if (i == 0) {
            _sepeatorView = [[UIView alloc] initWithFrame:CGRectMake(X(titleLabel), BOTTOM(titleLabel), WIDTH(titleLabel), 2)];
            _sepeatorView.backgroundColor = COLOR_2;
            [_tabScrollView addSubview:_sepeatorView];
        }
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeTabAction:)];
        titleLabel.userInteractionEnabled = YES;
        [titleLabel addGestureRecognizer:tap];
    }
    
    _tabScrollView.contentSize = CGSizeMake(contentWidth, HEIGHT(_tabScrollView));
    
    UIView * bottomLineView = [[UIView alloc] init];
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    [bottomLineView layoutIfNeeded];
    bottomLineView.backgroundColor = COLOR_7;
}

- (void)changeTabAction:(UITapGestureRecognizer *)tap {
    UILabel * tapLabel = (UILabel *)tap.view;
    [self.delegate changeTab:tapLabel sepeatorView:_sepeatorView type:ChangeTabTypeTap];
}

- (void)changeTab:(NSInteger)index {
    for (UILabel * label in _tabScrollView.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            if (label.tag - 100 == index) {
                [self.delegate changeTab:label sepeatorView:_sepeatorView type:ChangeTabTypeScroll];
                break;
            }
        }
    }
}

@end
