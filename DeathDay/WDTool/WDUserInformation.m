//
//  WDUserInformation.m
//  DeathDay
//
//  Created by Mac on 2020/11/23.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import "WDUserInformation.h"

@implementation WDUserInformation

+ (NSString *)userSceneMap
{
    NSString *mapName = [[NSUserDefaults standardUserDefaults]stringForKey:@"userMap"];
    
    if (mapName) {
        return mapName;
    }else{
        [WDUserInformation setUserSceneMap:@"WDStartScene"];
        return @"WDStartScene";
    }
    
}


+ (void)setUserSceneMap:(NSString *)mapName
{
    [[NSUserDefaults standardUserDefaults]setValue:mapName forKey:@"userMap"];
}

@end
