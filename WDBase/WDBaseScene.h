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

@interface WDBaseScene : SKScene<SKPhysicsContactDelegate>


/// 背景图片
@property (nonatomic,strong)WDBaseNode *bgNode;
/// 玩家
@property (nonatomic,strong)WDBaseNode *personNode;

/// 人物横向可以移动的范围
@property (nonatomic,assign)NSInteger usableMoveX;
/// 人物纵向可以移动的范围
@property (nonatomic,assign)NSInteger usableMoveY;

/// 延迟1秒才可以移动
@property (nonatomic,assign)BOOL canGo;

/// 人物与地图对应的位置关系
@property (nonatomic,strong)NSArray *map_x;
@property (nonatomic,strong)NSArray *map_y;
@property (nonatomic,strong)CADisplayLink *moveLink;


@property (nonatomic,copy)void (^changeMapWithMapName)(NSString *sceneName);



/// 创建墙体
- (void)createWallWithCount:(NSInteger)wallCount;

/// 人物行走
- (void)moveActionWithDirection:(NSString *)direction
                       position:(CGPoint)point;



/// 返回bgNode上的子Node
/// @param name node名称
- (SKSpriteNode *)nodeWithNodeName:(NSString *)name;


/// 创建门Node
- (void)createDoorNodeWithName:(NSString *)name;

/// 设置物理属性，墙体类,无碰撞检测回调
- (void)setWallPhysicyBody:(SKSpriteNode *)node;

/// 设置物理属性，怪物等有碰撞检测回调
- (void)setMonsterPhysicyBody:(SKSpriteNode *)node;



/// 释放内存，消除node
- (void)releaseAction;

@end

NS_ASSUME_NONNULL_END
