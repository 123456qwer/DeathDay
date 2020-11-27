//
//  WDTextureManager.m
//  DeathDay
//
//  Created by Mac on 2020/11/27.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import "WDTextureManager.h"

static WDTextureManager *textureManager = nil;

@implementation WDTextureManager
{
    NSDictionary *_balloonDic;
}

+ (WDTextureManager *)shareTextureManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!textureManager) {
            textureManager = [[WDTextureManager alloc] init];
        }
    });
    
    return textureManager;
}


- (NSArray *)balloonTexturesWithLine:(NSInteger)line
{
    if (!_balloonDic) {
        UIImage *image = [UIImage imageNamed:@"Balloon"];
        NSArray *arr = [WDCalculateTool arrWithLine:10 arrange:8 imageSize:CGSizeMake(image.size.width, 48 * 10) subImageCount:80 image:image curImageFrame:CGRectMake(0, 0, image.size.width, 48 * 10)];
        

        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:80];
        for (int i = 0; i < 10; i ++) {
            
            NSArray *subArr = [arr subarrayWithRange:NSMakeRange(i * 8, 8)];
            NSString *key = [NSString stringWithFormat:@"%d",i+1];
            [dic setValue:subArr forKey:key];
        }
        
        _balloonDic = dic;
    }
    
    
    NSString *key = [NSString stringWithFormat:@"%ld",line];
    return _balloonDic[key];
}

@end
