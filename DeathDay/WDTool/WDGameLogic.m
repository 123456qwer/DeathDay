//
//  WDGameLogic.m
//  DeathDay
//
//  Created by Mac on 2020/11/27.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import "WDGameLogic.h"
#import "WDBaseNode.h"

@implementation WDGameLogic

#pragma mark - 通用游戏逻辑 -
+ (void)changeSceneWithName:(NSString *)mapName
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForChangeScene object:mapName];
}

+ (void)changeAttackButtonWithImage:(UIImage *)image{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForChangeAttackBtn object:image];
}


#pragma mark - 场景一游戏逻辑~
+ (void)startSceneBeginContact:(SKPhysicsContact *)contact
{
    WDBaseNode *bodyA = (WDBaseNode *)contact.bodyA.node;
    WDBaseNode *bodyB = (WDBaseNode *)contact.bodyB.node;
    
    NSString *A = bodyA.name;
    NSString *B = bodyB.name;
    
    
    //玩家碰到出口，切换区域
    if ([A isEqualToString:@"person"]&&[B isEqualToString:@"door1"]) {
        [WDGameLogic changeSceneWithName:@"WDCorridor1Scene"];
    }
    
    if ([A isEqualToString:@"person"]&&[B isEqualToString:@"npc1"]) {
        [WDGameLogic changeAttackButtonWithImage:[UIImage imageNamed:@"talkImage"]];
    }
    
    NSLog(@"A:%@ B:%@ 发生碰撞了~",bodyA.name,bodyB.name);
}

+ (void)startSceneEndContact:(SKPhysicsContact *)contact
{
    WDBaseNode *bodyA = (WDBaseNode *)contact.bodyA.node;
    WDBaseNode *bodyB = (WDBaseNode *)contact.bodyB.node;
    
    NSString *A = bodyA.name;
    NSString *B = bodyB.name;
    
    if ([A isEqualToString:@"person"]&&[B isEqualToString:@"npc1"]) {
        [WDGameLogic changeAttackButtonWithImage:[UIImage imageNamed:@"attackOpeation"]];
    }
    
    NSLog(@"A:%@ B:%@ 碰撞完毕了~",bodyA.name,bodyB.name);

}


#pragma mark - 场景2


@end
