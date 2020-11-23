//
//  WDBaseNode.m
//  Maker
//
//  Created by Mac on 2020/11/18.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import "WDBaseNode.h"

@implementation WDBaseNode

- (void)realBackGroundWithColor:(UIColor *)color
{
    SKSpriteNode *node = [[SKSpriteNode alloc] initWithColor:color size:self.size];
    node.zPosition = -10;
    node.name = @"real";
    [self addChild:node];
}

@end
