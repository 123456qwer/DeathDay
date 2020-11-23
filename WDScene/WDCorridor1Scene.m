//
//  WDCorridor1Scene.m
//  DeathDay
//
//  Created by Mac on 2020/11/23.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import "WDCorridor1Scene.h"

@implementation WDCorridor1Scene

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    
    self.personNode.position = CGPointMake(100, 100);
    
    [self createDoorNodeWithName:@"door1"];
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
