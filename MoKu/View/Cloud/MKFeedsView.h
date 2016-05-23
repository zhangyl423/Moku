//
//  MKFeedsView.h
//  MoKu
//
//  Created by Zhang on 16/5/11.
//  Copyright © 2016年 Samuel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MKFeedsViewDelegate <NSObject>



@end

@interface MKFeedsView : UIView

@property (assign, nonatomic) id<MKFeedsViewDelegate> delegate;

@end
