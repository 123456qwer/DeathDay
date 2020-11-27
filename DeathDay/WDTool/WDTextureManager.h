//
//  WDTextureManager.h
//  DeathDay
//
//  Created by Mac on 2020/11/27.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface WDTextureManager : NSObject

/// 纹理管理者
+ (WDTextureManager *)shareTextureManager;


/// 人物头顶上的状态
/// @param line 哪一行，参考Balloon图片
- (NSArray *)balloonTexturesWithLine:(NSInteger)line;

@end

NS_ASSUME_NONNULL_END
