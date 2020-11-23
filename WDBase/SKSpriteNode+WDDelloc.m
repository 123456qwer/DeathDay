//
//  SKSpriteNode+WDDelloc.m
//  DeathDay
//
//  Created by Mac on 2020/11/23.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import "SKSpriteNode+WDDelloc.h"

//#import <AppKit/AppKit.h>


@implementation SKSpriteNode (WDDelloc)

- (void)dealloc
{
    NSLog(@"<%@> 被销毁了",self.name);
}

@end
