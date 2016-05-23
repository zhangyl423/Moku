//
//  TuSDKTSImage+Extend.h
//  TuSDK
//
//  Created by Clear Hu on 14/10/28.
//  Copyright (c) 2014年 tusdk.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - ImageExtend
/**
 *  图片帮助类
 */
@interface UIImage(ImageExtend)
/**
 *  使用颜色获取Image对象
 *
 *  @param color 颜色对象
 *
 *  @return Image对象
 */
+ (UIImage *) imageFromColor:(UIColor *)color;

/**
 *  创建圆形图像
 *
 *  @param radius    半径
 *  @param fillColor 填充色
 *
 *  @return 图像
 */
+ (UIImage *) createOvalImage:(NSUInteger)radius fillColor:(UIColor *)fillColor;

/**
 *  创建矩形图像
 *
 *  @param size      尺寸
 *  @param fillColor 填充色
 *
 *  @return 图像
 */
+ (UIImage *) createRectImage:(CGSize)size fillColor:(UIColor *)fillColor;
/**
 *  缩放图片
 *
 *  @param newSize 新的长宽
 *
 *  @return 缩放过的图片
 */
- (UIImage *) scaleImage:(CGSize)newSize;

/**
 *  等比旋转缩放 (不得小于 newSize)
 *
 *  @param newSize 新的长宽
 *
 *  @return 等比旋转缩放
 */
- (UIImage *) scaleGeometricAndRotate:(CGSize)newSize;

/**
 *  获取限制最大边长图片
 *
 *  @param limit 最大边长
 *
 *  @return 修改限制后的图片
 */
- (UIImage *) imageLimit:(CGFloat)limit;

/**
 *  缩放图片
 *
 *  @param scale 缩放比例
 *
 *  @return 缩放后的图片
 */
- (UIImage *) imageScale:(CGFloat)scale;

/**
 *  旋转图像到UP角度
 *
 *  @return 旋转图像到UP角度
 */
- (UIImage *) imageRotatedToUp;

/**
 *  按比例裁剪图片
 *
 *  @param ratio 裁剪比例
 *
 *  @return 裁剪后的图片
 */
- (UIImage *) imageCorpWithRatio:(CGFloat)ratio;

/**
 *  获取全屏大小图片
 *
 *  @return 全屏大小图片
 */
- (UIImage *) fullScreenImage;

/**
 *  获取全屏大小图片 (保持图片原始方向)
 *
 *  @return 全屏大小图片
 */
- (UIImage *) fullScreenImageKeepOrientation;

/**
 *  改变图片方向属性
 *
 *  @return 图片对象
 */
- (UIImage *) changeOrientation: (UIImageOrientation)orientation;

/**
 *  将输入图片拼合到自身上层
 *
 *  @param inputImage 输入图片
 *
 *  @return 拼合的图片
 */
- (UIImage *) mergeAboveImage:(UIImage *)inputImage;
/**
 *  转换为JPEG数据
 *
 *  @param compress 压缩率 0-1
 *  @param meta     图片信息
 *
 *  @return JPEG数据
 */
- (NSData *) jpegDataWithCompress:(CGFloat)compress meta:(NSDictionary *)meta;

/**
 *  是否需要长宽换位
 *
 *  @return 是否换位
 */
- (BOOL) sizeTransposed;

/**
 *  重新解析图片
 *
 *  @param image 图片对象
 *
 *  @return 图片对象
 */
+ (UIImage *)decodedImageWithImage:(UIImage *)image;

/**
 *  根据图片文件名按屏幕DPI进行缩放
 *
 *  @param key 图片文件名
 *
 *  @return 按屏幕DPI进行缩放后的图片
 */
- (UIImage *)scaledImageForKey:(NSString *)key;
@end

#pragma mark - ResizeAndRotate
/**
 *  旋转并缩放图片
 */
@interface UIImage(ResizeAndRotate)

/**
 *  等比缩放并旋转图片
 *
 *  @param resize      目标长宽
 *  @param baseLongSide    是否按最大边比例作为缩放标准
 *
 *  @return 处理后的图片
 */
- (UIImage *)imageResize:(CGSize)resize baseLongSide:(BOOL)baseLongSide;

/**
 *  等比缩放并旋转图片
 *
 *  @param resize      目标长宽
 *  @param orientation 图片方向
 *  @param baseLongSide    是否按最大边比例作为缩放标准
 *
 *  @return 处理后的图片
 */
- (UIImage *)imageResize:(CGSize)resize
             orientation:(UIImageOrientation)orientation
            baseLongSide:(BOOL)baseLongSide;

/**
 *  等比缩放并旋转图片
 *
 *  @param resize      目标长宽
 *  @param baseLongSide    是否按最大边比例作为缩放标准
 *  @param quality     缩放质量
 *
 *  @return 处理后的图片
 */
- (UIImage *)imageResize:(CGSize)resize
            baseLongSide:(BOOL)baseLongSide
    interpolationQuality:(CGInterpolationQuality)quality;
/**
 *  等比缩放并旋转图片
 *
 *  @param resize      目标长宽
 *  @param baseLongSide    是否按最大边比例作为缩放标准
 *  @param ratio    输出图片的长宽比例 (默认为：0或小于0时按原图比例，当原图为正方形时不计算比例)
 *
 *  @return 处理后的图片
 */
- (UIImage *)imageResize:(CGSize)resize baseLongSide:(BOOL)baseLongSide ratio:(CGFloat)ratio;

/**
 *  等比缩放并旋转图片
 *
 *  @param resize      目标长宽
 *  @param orientation 图片方向
 *  @param baseLongSide    是否按最大边比例作为缩放标准
 *  @param ratio    输出图片的长宽比例 (默认为：0或小于0时按原图比例，当原图为正方形时不计算比例)
 *
 *  @return 处理后的图片
 */
- (UIImage *)imageResize:(CGSize)resize
             orientation:(UIImageOrientation)orientation
            baseLongSide:(BOOL)baseLongSide
                   ratio:(CGFloat)ratio;

/**
 *  等比缩放并旋转图片
 *
 *  @param resize      目标长宽
 *  @param orientation 图片方向
 *  @param baseLongSide    是否按最大边比例作为缩放标准
 *  @param quality     缩放质量
 *  @param ratio    输出图片的长宽比例 (默认为：0或小于0时按原图比例)
 *
 *  @return 处理后的图片
 */
- (UIImage *)imageResize:(CGSize)resize
             orientation:(UIImageOrientation)orientation
            baseLongSide:(BOOL)baseLongSide
    interpolationQuality:(CGInterpolationQuality)quality
                   ratio:(CGFloat)ratio;
@end

#pragma mark - OrientationChange
/**
 *  修改图片对象方向属性 （不修改图像）
 */
@interface UIImage(OrientationChange)
/**
 *  设置图片属性向左旋转图片90度
 *
 *  @return 重设属性后的图片对象
 */
- (UIImage *)changeTurnLeft;

/**
 *  设置图片属性向右旋转图片90度
 *
 *  @return 重设属性后的图片对象
 */
- (UIImage *)changeTurnRight;

/**
 *  设置图片属性水平镜像
 *
 *  @return 重设属性后的图片对象
 */
- (UIImage *)changeMirrorHorizontal;

/**
 *  设置图片属性垂直镜像
 *
 *  @return 重设属性后的图片对象
 */
- (UIImage *)changeMirrorVertical;

/**
 *  计算正确的的图片方向
 *
 *  @param orientation 图片方向
 *  @param isMirror    是否镜像
 *
 *  @return 正确的的图片方向
 */
+ (UIImageOrientation)orientation:(UIImageOrientation)orientation isMirror:(BOOL)isMirror;

/**
 *  获取图片EXIF的方向
 *
 *  @param exifOrientation EXIF方向
 *
 *  @return 图片的方向
 */
+ (UIImageOrientation)orientationWithExif:(NSUInteger)exifOrientation;
@end

#pragma mark - ImageCorp
/**
 *  图片裁剪扩展
 */
@interface UIImage(ImageCorp)
/**
 *  输出指定长宽图片，多余将进行裁剪
 *
 *  @param size 输出图片长宽
 *
 *  @return 指定长宽图片
 */
- (UIImage *) imageCorpResizeWithSize:(CGSize)size;

/**
 *  裁剪图片 (需要先旋转到正确的方向)
 *
 *  @param rect 百分比裁剪区域
 *
 *  @return 裁剪后的图片
 */
- (UIImage *)imageCorpWithPrecentRect:(CGRect)rect;

/**
 *  裁剪图片 (需要先旋转到正确的方向)
 *
 *  @param rect 百分比裁剪区域
 *  @param outputSize 输出图片长宽
 *
 *  @return 裁剪后的图片
 */
- (UIImage *)imageCorpWithPrecentRect:(CGRect)rect outputSize:(CGSize)outputSize;

/**
 *  裁剪图片
 *
 *  @param size        源图片长宽
 *  @param rect        百分比裁剪区域
 *  @param outputSize  输出图片长宽
 *  @param orientation 图片宽度
 *  @param quality     图片质量
 *
 *  @return 裁剪后的图片
 */
- (UIImage *)imageCorpWithSize:(CGSize)size
                          rect:(CGRect)rect
                    outputSize:(CGSize)outputSize
                   orientation:(UIImageOrientation)orientation
          interpolationQuality:(CGInterpolationQuality)quality;
@end

#pragma mark - ImageTintColor
/**
 *  改变图片颜色
 */
@interface UIImage(ImageTintColor)
/**
 *  改变图片颜色
 *
 *  @param tintColor 颜色
 *
 *  @return 改变颜色的图片
 */
- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
/**
 *  改变图片颜色 (使用灰度信息)
 *
 *  @param tintColor 颜色
 *
 *  @return 改变颜色的图片
 */
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

/**
 *  改变图片颜色
 *
 *  @param tintColor 颜色
 *  @param blendMode 混合模式
 *
 *  @return 改变颜色的图片
 */
- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;
@end

#pragma mark - ImageDump
@interface UIImage(ImageDump)
/**
 *  打印图片信息
 */
- (void)dump;
@end