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


- (void)realBackGroundWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
