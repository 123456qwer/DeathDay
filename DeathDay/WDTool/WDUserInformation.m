//
//  WDUserInformation.m
//  DeathDay
//
//  Created by Mac on 2020/11/23.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import "WDUserInformation.h"
static WDUserInformation *userManager = nil;
@implementation WDUserInformation
{
    CGFloat _userSpeed;
}

+ (WDUserInformation *)shareUserInfoManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!userManager) {
            userManager = [[WDUserInformation alloc] init];
        }
    });
    
    return userManager;
}

- (NSString *)userSceneMap
{
    NSString *mapName = [[NSUserDefaults standardUserDefaults]stringForKey:@"userMap"];
    
    if (mapName) {
        return mapName;
    }else{
        [self setUserSceneMap:@"WDStartScene"];
        return @"WDStartScene";
    }
    
}


- (void)setUserSceneMap:(NSString *)mapName
{
    [[NSUserDefaults standardUserDefaults]setValue:mapName forKey:@"userMap"];
}


- (CGFloat)userSpeed
{    
    return _userSpeed;
}

- (void)setUserSpeed:(CGFloat)speed
{
    _userSpeed = speed;
    [[NSUserDefaults standardUserDefaults]setFloat:speed forKey:@"userSpeed"];
}

@end
