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

- (void)addShadow1{
    
    WDBaseNode *shadow = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"Shadow1"]]];
    shadow.position = CGPointMake(0, -8);
    [self addChild:shadow];
    
}

+ (WDBaseNode *)spriteNodeWithName:(NSString *)name
{
    NSString *moveName = [NSString stringWithFormat:@"%@_move",name];
    NSArray *personTextureArr = [WDCalculateTool arrWithLine:4 arrange:3 imageSize:CGSizeMake(48 * 3.0, 48 * 4.0) subImageCount:12 image:[UIImage imageNamed:moveName]];
    
    //初始化移动
    NSMutableDictionary *moveDic = [NSMutableDictionary dictionary];
    NSArray *key = @[@"down",@"left",@"right",@"up"];
    int a = 0;
    for (int i = 0; i < key.count; i ++) {
        
        NSArray *sub = [personTextureArr subarrayWithRange:NSMakeRange(a, 3)];
        [moveDic setObject:sub forKey:key[i]];
         a += 3;
    }
    
    
    //初始化其他
    
    WDBaseNode *node = [WDBaseNode spriteNodeWithTexture:moveDic[@"left"][0]];
    node.moveDic = moveDic;
    
    
    return node;
}

@end
