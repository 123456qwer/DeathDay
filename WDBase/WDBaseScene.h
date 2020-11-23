//
//  WDBaseScene.h
//  Maker
//
//  Created by Mac on 2020/11/18.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "WDBaseNode.h"
NS_ASSUME_NONNULL_BEGIN

@interface WDBaseScene : SKScene


/// 背景图片
@property (nonatomic,strong)WDBaseNode *bgNode;
/// 玩家
@property (nonatomic,strong)WDBaseNode *personNode;

/// 人物横向可以移动的范围
@property (nonatomic,assign)NSInteger usableMoveX;
/// 人物纵向可以移动的范围
@property (nonatomic,assign)NSInteger usableMoveY;


/// 人物与地图对应的位置关系
@property (nonatomic,strong)NSArray *map_x;
@property (nonatomic,strong)NSArray *map_y;
@property (nonatomic,strong)CADisplayLink *moveLink;


/// 人物行走
- (void)moveActionWithDirection:(NSString *)direction
                       position:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
