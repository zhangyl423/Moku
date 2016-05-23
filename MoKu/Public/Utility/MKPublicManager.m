//
//  MKPublicManager.m
//  MoKu
//
//  Created by Zhang on 16/5/11.
//  Copyright © 2016年 Samuel. All rights reserved.
//

#import "MKPublicManager.h"

@implementation MKPublicManager

//根据文本. 字体计算Label高度
+ (CGSize)adapterSizeWithString:(NSString *)textStr WithMaxWidth:(CGFloat)width WithFont:(UIFont *)font {
    CGRect rect = [textStr boundingRectWithSize:CGSizeMake(width, 99999)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
    return rect.size;
}

@end
