//
//  WDGameLogic.h
//  DeathDay
//
//  Created by Mac on 2020/11/27.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDGameLogic : NSObject



/// 改变地图
+ (void)changeSceneWithName:(NSString *)mapName;

/// 改变攻击键按钮图片
+ (void)changeAttackButtonWithImage:(UIImage *)image;



@end

NS_ASSUME_NONNULL_END
