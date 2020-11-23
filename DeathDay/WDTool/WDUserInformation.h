//
//  WDUserInformation.h
//  DeathDay
//
//  Created by Mac on 2020/11/23.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDUserInformation : NSObject

/// 玩家当前地图
+ (NSString *)userSceneMap;

/// 存储玩家当前地图
/// @param mapName 地图名称
+ (void)setUserSceneMap:(NSString *)mapName;


@end

NS_ASSUME_NONNULL_END
