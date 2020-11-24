//
//  WDCorridor1Scene.m
//  DeathDay
//
//  Created by Mac on 2020/11/23.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import "WDCorridor1Scene.h"

@implementation WDCorridor1Scene
{
}
- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    
    self.personNode.xScale = 1.6;
    self.personNode.yScale = 1.6;
    
   

    self.light = [[SKLightNode alloc] init];
    self.light.categoryBitMask = 0;
    self.light.falloff = 1;
    self.light.ambientColor = [UIColor whiteColor];
    self.light.lightColor  = [UIColor whiteColor];
    self.light.shadowColor = [UIColor blackColor];
    self.light.zPosition = 200;

    [self.bgNode addChild:self.light];
    
    self.bgNode.lightingBitMask = 1;
    self.personNode.shadowCastBitMask = 1;
//    SKSpriteNode *node = [[SKSpriteNode alloc] initWithColor:[UIColor blackColor] size:self.bgNode.size];
//    node.position = CGPointMake(0, 0);
//    node.zPosition = 1000000;
//    node.alpha = 0.8;
//    node.anchorPoint = CGPointMake(0, 0);
//    [self.bgNode addChild:node];
}

- (void)setBgChildNodePhybody
{
    SKSpriteNode *start = [self nodeWithNodeName:@"start"];
    start.alpha = 0;
    self.personNode.position = start.position;
    
    [self createDoorNodeWithName:@"door1"];
    [self createDoorNodeWithName:@"door2"];
    [self createDoorNodeWithName:@"door3"];
    [self createWallWithCount:7];
}

















- (void)didBeginContact:(SKPhysicsContact *)contact
{
    WDBaseNode *bodyA = (WDBaseNode *)contact.bodyA.node;
    WDBaseNode *bodyB = (WDBaseNode *)contact.bodyB.node;
    
    NSString *A = bodyA.name;
    NSString *B = bodyB.name;
    
    
    //玩家碰到出口，切换区域
    if ([A isEqualToString:@"person"]&&[B isEqualToString:@"door1"]) {
        if (self.changeMapWithMapName) {
            self.changeMapWithMapName(@"WDStartScene");
        }
    }
    
    
    NSLog(@"A:%@ B:%@",bodyA.name,bodyB.name);
}

@end
