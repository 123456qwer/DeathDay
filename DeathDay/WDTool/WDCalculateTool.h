//
//  WDCalculateTool.h
//  HotSchool
//
//  Created by 吴冬 on 2018/5/8.
//  Copyright © 2018年 吴冬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WDCalculateTool : NSObject


/** 计算人物移动和方向 */
+ (NSDictionary *)calculateDirection:(CGPoint)point1
                               point:(CGPoint)point2
                               speed:(CGFloat)speed;




/** 计算人物的最大位移空间 */
+ (CGPoint)calculateMaxMoveXAndY:(CGPoint)movePoint
                            maxX:(CGFloat)maxX
                            maxY:(CGFloat)maxY
                      personSize:(CGSize)size;



/// 切割图片
/// @param line 行
/// @param arrange 列
/// @param imageSize 图片尺寸
/// @param count 切割数量
/// @param image 图片
+ (NSArray *)arrWithLine:(NSInteger)line
                 arrange:(NSInteger)arrange
               imageSize:(CGSize)imageSize
           subImageCount:(NSInteger)count
                   image:(UIImage *)image;



/// frame:按区域切分,其他同上
+ (NSArray *)arrWithLine:(NSInteger)line
                 arrange:(NSInteger)arrange
               imageSize:(CGSize)imageSize
           subImageCount:(NSInteger)count
                   image:(UIImage *)image
           curImageFrame:(CGRect)frame;

@end
