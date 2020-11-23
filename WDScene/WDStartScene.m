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
    NSTimer *_observeUserTimer;
    
}

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    
    self.personNode.xScale = 1.1;
    self.personNode.yScale = 1.1;
    
    SKSpriteNode *startNode = [self nodeWithNodeName:@"start"];
    startNode.alpha = 0;
    self.personNode.position = startNode.position;
    
    
    [self createWallWithCount:10];
    [self createDoorNodeWithName:@"door1"];
    
    
    [self createNpcNode];
}



- (void)createNpcNode{
    
    _npcNode = [WDBaseNode spriteNodeWithName:@"npc1"];
    _npcNode.xScale = 1.1;
    _npcNode.yScale = 1.1;
    _npcNode.name = @"npc1";
    [self.bgNode addChild:_npcNode];
    [_npcNode addShadow1];
    
    SKSpriteNode *door = (SKSpriteNode *)[self.bgNode childNodeWithName:@"door1"];
    _npcNode.position = door.position;

    
    SKSpriteNode *startNode = [self nodeWithNodeName:@"start"];

    
    SKAction *moveAction = [SKAction moveTo:CGPointMake(_npcNode.position.x, startNode.position.y) duration:1.4];
    SKAction *upAction = [SKAction animateWithTextures:_npcNode.moveDic[@"up"] timePerFrame:0.25];
    SKAction *rep = [SKAction repeatAction:upAction count:2];
    SKAction *gr = [SKAction group:@[rep,moveAction]];
    
    __weak WDBaseNode *node = _npcNode;
    
    [_npcNode runAction:gr completion:^{
       
        SKAction *moveAction = [SKAction moveTo:CGPointMake(startNode.position.x + node.size.width, startNode.position.y) duration:1.4];
        SKAction *upAction = [SKAction animateWithTextures:node.moveDic[@"left"] timePerFrame:0.25];
        SKAction *rep = [SKAction repeatAction:upAction count:2];
        SKAction *gr = [SKAction group:@[rep,moveAction]];
        
        [node runAction:gr completion:^{
            node.zPosition = kScreenHeight * 2.0 - node.position.y;
            node.direction = @"left";
            SKAction *tex = [SKAction animateWithTextures:node.moveDic[@"left"] timePerFrame:0.25];
            SKAction *rep = [SKAction repeatActionForever:tex];
            [node runAction:rep withKey:@"move"];
            [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(observeAction:) userInfo:nil repeats:YES];
        }];
    }];
    
}

- (void)observeAction:(NSTimer *)timer
{
    if (!_observeUserTimer) {
        _observeUserTimer = timer;
    }
    
    NSDictionary *dic = [WDCalculateTool calculateDirection:self.personNode.position point:_npcNode.position speed:5];
    NSString *direction = dic[@"direction"];
    
    if ([direction isEqualToString:@"up"]) {
        direction = @"down";
    }else if ([direction isEqualToString:@"down"]) {
        direction = @"up";
    }
    
    if (![_npcNode.direction isEqualToString:direction]) {
        [_npcNode removeActionForKey:@"move"];
        
        SKAction *tex = [SKAction animateWithTextures:_npcNode.moveDic[direction] timePerFrame:0.25];
        SKAction *rep = [SKAction repeatActionForever:tex];
        [_npcNode runAction:rep withKey:@"move"];
        _npcNode.direction = direction;
    }
}

- (void)releaseAction
{
    [super releaseAction];
    
    if (_observeUserTimer) {
        [_observeUserTimer invalidate];
    }
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
