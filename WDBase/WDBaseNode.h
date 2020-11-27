//
//  WDBaseNode.h
//  Maker
//
//  Created by Mac on 2020/11/18.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDBaseNode : SKSpriteNode


/// 人物朝向 up down left right
@property (nonatomic,copy)NSString *direction;


/// 人物移动
@property (nonatomic,strong)NSMutableDictionary *moveDic;

@property (nonatomic,strong)SKTexture *faceTexture;

/// 表情
@property (nonatomic,strong)WDBaseNode *balloonNode;
@property (nonatomic,copy)NSArray *balloonArr;

/// 初始化人物：提供人物前缀 比如 user_xxx; 提供user
+ (WDBaseNode *)spriteNodeWithName:(NSString *)name;
- (void)realBackGroundWithColor:(UIColor *)color;
- (void)addShadow1;


/// 设置人物头顶表情
- (void)setBalloonWithLine:(NSInteger)line;
- (void)removeBalloon;

@end

NS_ASSUME_NONNULL_END
