//
//  MKPublicManager.h
//  MoKu
//
//  Created by Zhang on 16/5/11.
//  Copyright © 2016年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKPublicManager : NSObject

//根据文本. 字体计算Label高度
+ (CGSize)adapterSizeWithString:(NSString *)textStr WithMaxWidth:(CGFloat)width WithFont:(UIFont *)font;

@end
