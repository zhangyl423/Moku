//
//  MKFeedsView.m
//  MoKu
//
//  Created by Zhang on 16/5/11.
//  Copyright © 2016年 Samuel. All rights reserved.
//

#import "MKFeedsView.h"

@interface MKFeedsView () <UITableViewDelegate, UITableViewDataSource>

@end

#define IMAGE_SIZE_MORE                  (79 / 375.0 * SCREENWIDTH)
#define IMAGE_SIZE_ONE                   (IMAGE_SIZE_MORE * 2)

@implementation MKFeedsView
{
    UITableView * _feedsTableView;
    
    UIImageView * _avatarImageView;
    UILabel     * _nameLabel;
    UILabel     * _contentLabel;
    UIImageView * _contentImageView;
    UILabel     * _timeLabel;
    UIImageView * _buttonImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self drawView];
    }
    return self;
}

- (void)drawView {
    _feedsTableView = [[UITableView alloc] init];
    [self addSubview:_feedsTableView];
    [_feedsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    _feedsTableView.delegate        = self;
    _feedsTableView.dataSource      = self;
    _feedsTableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95 + [MKPublicManager adapterSizeWithString:@"今天Moku项目终于重构了." WithMaxWidth:(SCREENWIDTH - 85) WithFont:FONT(15)].height + (8 / 3 + 1) * (IMAGE_SIZE_MORE + 5) - 5;
//    return 95 + [MKPublicManager adapterSizeWithString:@"今天Moku项目终于重构了." WithMaxWidth:(SCREENWIDTH - 85) WithFont:FONT(15)].height + 2 * (IMAGE_SIZE_MORE + 5) - 5;
//    return 95 + [MKPublicManager adapterSizeWithString:@"今天Moku项目终于重构了." WithMaxWidth:(SCREENWIDTH - 85) WithFont:FONT(15)].height + IMAGE_SIZE_ONE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self getFeedsCell];
}

- (UITableViewCell *)getFeedsCell {
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _avatarImageView = [[UIImageView alloc] init];
    [cell.contentView addSubview:_avatarImageView];
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView.mas_top).with.offset(15);
        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    _avatarImageView.image = [UIImage imageNamed:@"icon_avatar"];
    
    _nameLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarImageView.mas_right).with.offset(10);
        make.right.equalTo(cell.contentView.mas_right).with.offset(-15);
        make.top.equalTo(_avatarImageView.mas_top);
        make.height.mas_equalTo(23);
    }];
    _nameLabel.font      = FONT(15);
    _nameLabel.textColor = COLOR_3;
    _nameLabel.text      = @"魔库";
    
    _contentLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.right.equalTo(_nameLabel.mas_right);
        make.height.greaterThanOrEqualTo(@10);
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(3);
    }];
    _contentLabel.font      = FONT(15);
    _contentLabel.textColor = COLOR_6;
    _contentLabel.text      = @"今天Moku项目终于重构了.";
    
    [self loadMorePicture:cell.contentView];
//    [self loadFourPicture:cell.contentView];
//    [self loadOnePicture:cell.contentView];
    
    _timeLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentImageView.mas_bottom).with.offset(10);
        make.left.equalTo(_nameLabel.mas_left);
        make.width.greaterThanOrEqualTo(@10);
        make.height.greaterThanOrEqualTo(@10);
    }];
    _timeLabel.font      = FONT(13);
    _timeLabel.textColor = COLOR_4;
    _timeLabel.text      = @"5分钟前";
    
    return cell;
}

- (void)loadMorePicture:(UIView *)superView {
    for (NSInteger i = 0; i < 8; i ++) {
        UIImageView * imageView = [[UIImageView alloc] init];
        [superView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).with.offset(70 + (i % 3) * (IMAGE_SIZE_MORE + 5));
            make.top.equalTo(_contentLabel.mas_bottom).with.offset(10 + (i / 3) * (IMAGE_SIZE_MORE + 5));
            make.size.mas_equalTo(CGSizeMake(IMAGE_SIZE_MORE, IMAGE_SIZE_MORE));
        }];
        [imageView layoutIfNeeded];
        imageView.contentMode   = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image         = [UIImage imageNamed:@"icon_avatar"];
        _contentImageView       = imageView;
    }
}

- (void)loadFourPicture:(UIView *)superView {
    for (NSInteger i = 0; i < 4; i ++) {
        UIImageView * imageView = [[UIImageView alloc] init];
        [superView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).with.offset(70 + (i % 2) * (IMAGE_SIZE_MORE + 5));
            make.top.equalTo(_contentLabel.mas_bottom).with.offset(10 + (i / 2) * (IMAGE_SIZE_MORE + 5));
            make.size.mas_equalTo(CGSizeMake(IMAGE_SIZE_MORE, IMAGE_SIZE_MORE));
        }];
        [imageView layoutIfNeeded];
        imageView.contentMode   = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image         = [UIImage imageNamed:@"icon_avatar"];
        _contentImageView       = imageView;
    }
}

- (void)loadOnePicture:(UIView *)superView {
    UIImageView * imageView = [[UIImageView alloc] init];
    [superView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).with.offset(70);
        make.top.equalTo(_contentLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(IMAGE_SIZE_ONE / 0.75, IMAGE_SIZE_ONE));
    }];
    [imageView layoutIfNeeded];
    imageView.contentMode   = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic28.nipic.com/20130424/11588775_115415688157_2.jpg"]
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                    if (image) {
                                        if (image.size.width > image.size.height) {
                                            [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                                                make.size.mas_equalTo(CGSizeMake(IMAGE_SIZE_ONE / 0.75, IMAGE_SIZE_ONE));
                                            }];
                                        }else {
                                            [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                                                make.size.mas_equalTo(CGSizeMake(image.size.width / (image.size.height * 1.0) * IMAGE_SIZE_ONE, IMAGE_SIZE_ONE));
                                            }];
                                        }
                                    }
    }];
    _contentImageView = imageView;
}

@end
