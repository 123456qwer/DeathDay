//
//  WDStartScene.m
//  DeathDay
//
//  Created by Mac on 2020/11/23.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import "WDStartScene.h"

@implementation WDStartScene
{
    WDBaseNode *_npcNode;
    NSMutableDictionary *_npcMoveDic;
}

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    
    self.personNode.xScale = 1.1;
    self.personNode.yScale = 1.1;
    
    SKSpriteNode *startNode = [self nodeWithNodeName:@"start"];
    self.personNode.position = startNode.position;
    
    [startNode removeFromParent];
    
    [self createWallWithCount:10];
    [self createDoorNodeWithName:@"door1"];
    
    
    [self createNpcNode];
}



- (void)createNpcNode{
    
    _npcNode = [WDBaseNode spriteNodeWithName:@"npc1"];
    _npcNode.xScale = 1.1;
    _npcNode.yScale = 1.1;
    [self.bgNode addChild:_npcNode];
    
    _npcNode.position = CGPointMake(100, 100);
}



#pragma mark - 碰撞检测 -
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    WDBaseNode *bodyA = (WDBaseNode *)contact.bodyA.node;
    WDBaseNode *bodyB = (WDBaseNode *)contact.bodyB.node;
    
    NSString *A = bodyA.name;
    NSString *B = bodyB.name;
    
    
    //玩家碰到出口，切换区域
    if ([A isEqualToString:@"person"]&&[B isEqualToString:@"door1"]) {
        if (self.changeMapWithMapName) {
            self.changeMapWithMapName(@"WDCorridor1Scene");
        }
    }
    
    
    NSLog(@"A:%@ B:%@",bodyA.name,bodyB.name);
}

- (void)didEndContact:(SKPhysicsContact *)contact
{
    
}


@end
