//
//  WDCalculateTool.m
//  HotSchool
//
//  Created by 吴冬 on 2018/5/8.
//  Copyright © 2018年 吴冬. All rights reserved.
//

#import "WDCalculateTool.h"
#import <objc/runtime.h>
#import <SpriteKit/SpriteKit.h>
#define RadianToDegrees(radian) (radian*180.0)/(M_PI)
#define DegreesToRadian(x) (M_PI * (x) / 180.0)
@implementation WDCalculateTool

+ (NSDictionary *)calculateDirection:(CGPoint)point1
                               point:(CGPoint)point2
                               speed:(CGFloat)speed{
    
    CGFloat x = point1.x - point2.x;
    CGFloat y = point1.y - point2.y;
    
    NSString *direction = @"";
    CGFloat movePosition_x = 0;
    CGFloat movePosition_y = 0;
    
    CGFloat calculateY = 0;
    CGFloat calculateX = 0;
    
    CGFloat tan = atan2(y, x);
    
    //NSLog(@"%lf",tan);
    
    CGFloat degrees = RadianToDegrees(tan);
    CGFloat fabsDegrees = fabs(degrees);
    
    //做角度的控制，避免上下移动太过灵敏
    //这里以后可以改完可控的，让玩家自己调节
    CGFloat controllerPage = 0;
    
    if (fabsDegrees > 100) {
     
        if (180 - fabsDegrees < controllerPage) {
            calculateX = -speed;
            direction = @"left";
            NSDictionary *dic = @{@"direction":direction,@"x":@(calculateX),@"y":@(calculateY)};
            return dic;
        }
    }else{
        if (fabsDegrees < controllerPage) {
            calculateX = speed;
            direction = @"right";
            NSDictionary *dic = @{@"direction":direction,@"x":@(calculateX),@"y":@(calculateY)};
            return dic;
        }
    }
    
    //NSLog(@"%lf",RadianToDegrees(tan));

    if (tan > 0) {
        
        if (tan <= M_PI / 4.0) {
            
            movePosition_x = speed;
            CGFloat percent = tan / (M_PI / 4.0) * speed;
            movePosition_y = percent;

            CGFloat sq = sqrt(movePosition_x * movePosition_x + movePosition_y * movePosition_y);
            calculateY = (movePosition_x * movePosition_y) / sq * -1;
            calculateX = (movePosition_x * movePosition_x) / sq;
            
            direction = @"right";

        }else if(tan > M_PI / 4.0 && tan <= M_PI / 2.0){
            
            movePosition_y = speed;
            movePosition_x = (1 - (tan - (M_PI / 4.0)) / (M_PI / 4.0)) * speed ;
            CGFloat sq = sqrt(movePosition_x * movePosition_x + movePosition_y * movePosition_y);
            calculateX = (movePosition_x * movePosition_y) / sq;
            calculateY = (movePosition_y * movePosition_y) / sq * -1;
            
            direction = @"down";
            
        }else if(tan > M_PI / 2.0 && tan <= M_PI / 4.0 * 3.0){
          
            movePosition_y = speed ;
            movePosition_x = ((tan - (M_PI / 2.0)) / (M_PI / 4.0)) * speed;
           
            CGFloat sq = sqrt(movePosition_x * movePosition_x + movePosition_y * movePosition_y);
            calculateX = (movePosition_x * movePosition_y) / sq * -1;
            calculateY = (movePosition_y * movePosition_y) / sq * -1;
            
            direction = @"down";
        
        }else{
          
            movePosition_x = speed ;
            movePosition_y = (1 - (tan - (M_PI / 4.0 * 3.0)) / (M_PI / 4.0))  * speed;
           
            CGFloat sq = sqrt(movePosition_x * movePosition_x + movePosition_y * movePosition_y);
            calculateY = (movePosition_x * movePosition_y) / sq * -1;
            calculateX = (movePosition_x * movePosition_x) / sq * -1;
            
            direction = @"left";
        }
        
    }else{
        
        tan = fabs(tan);
        
        if (tan <= M_PI / 4.0) {
            
            movePosition_x = speed;
            CGFloat percent = tan / (M_PI / 4.0) * speed;
            movePosition_y = percent;
            
            CGFloat sq = sqrt(movePosition_x * movePosition_x + movePosition_y * movePosition_y);
            calculateY = (movePosition_x * movePosition_y) / sq;
            calculateX = (movePosition_x * movePosition_x) / sq;

            direction = @"right";
            
        }else if(tan > M_PI / 4.0 && tan <= M_PI / 2.0){
            
            movePosition_y = speed;
            movePosition_x = (1 - (tan - (M_PI / 4.0)) / (M_PI / 4.0)) * speed ;
            CGFloat sq = sqrt(movePosition_x * movePosition_x + movePosition_y * movePosition_y);
            calculateX = (movePosition_x * movePosition_y) / sq;
            calculateY = (movePosition_y * movePosition_y) / sq;
            
            direction = @"up";
            
        }else if(tan > M_PI / 2.0 && tan <= M_PI / 4.0 * 3.0){
            
            movePosition_y = speed;
            movePosition_x = (tan - (M_PI / 2.0)) / (M_PI / 4.0) * speed;
            CGFloat sq = sqrt(movePosition_x * movePosition_x + movePosition_y * movePosition_y);
            calculateX = (movePosition_x * movePosition_y) / sq * -1;
            calculateY = (movePosition_y * movePosition_y) / sq;
            
            direction = @"up";
            
        }else{
            
            movePosition_x = speed;
            movePosition_y = (1 - (tan - (M_PI / 4.0 * 3.0)) / (M_PI / 4.0)) * speed ;

            CGFloat sq = sqrt(movePosition_x * movePosition_x + movePosition_y * movePosition_y);
            calculateY = (movePosition_x * movePosition_y) / sq;
            calculateX = (movePosition_x * movePosition_x) / sq * -1;
            
            direction = @"left";
        }
    }
  
//    if (calculateX >= 0) {
//        direction = @"right";
//    }else{
//        direction = @"left";
//    }
    
//    NSLog(@"%@",direction);
    
    
    //WDLog(@"x:%lf  y:%lf",movePosition_x,movePosition_y);
    
    NSDictionary *dic = @{@"direction":direction,@"x":@(calculateX),@"y":@(calculateY)};

    return dic;
}

+ (CGPoint)calculateMaxMoveXAndY:(CGPoint)movePoint
                            maxX:(CGFloat)maxX
                            maxY:(CGFloat)maxY
                      personSize:(CGSize)size
{
   
    CGPoint point = movePoint;
    
    if (point.x > maxX - size.width / 2.0) {
        point.x = maxX - size.width / 2.0;
    }
    
    if (point.x < size.width / 2.0) {
        point.x = size.width / 2.0;
    }
    
    if (point.y > maxY - size.height / 2.0) {
        point.y = maxY - size.height / 2.0;
    }
    if (point.y < size.height / 2.0) {
        point.y = size.height / 2.0;
    }
    
    return point;
}

+ (NSArray *)arrWithLine:(NSInteger)line
                 arrange:(NSInteger)arrange
               imageSize:(CGSize)imageSize
           subImageCount:(NSInteger)count
                   image:(UIImage *)image
           curImageFrame:(CGRect)frame{
    
    UIImage *passImage = [UIImage imageNamed:@"chest1"];
    CGImageRef imageRef1 = [passImage CGImage];

    
    CGImageRef subImage = CGImageCreateWithImageInRect(imageRef1, frame);
    UIImage *curImage = [UIImage imageWithCGImage:subImage];
    
    CGImageRef imageRef = [curImage CGImage];
    
    CGFloat width = imageSize.height / (CGFloat)line;
    CGFloat height = imageSize.width / (CGFloat)arrange;
    
    NSMutableArray *imagesArr = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = 0; i < count; i ++) {
           
        CGFloat x = i % arrange * width;
        CGFloat y = i / arrange * height;
       
        CGRect frame = CGRectMake(x, y, width, height);
        CGImageRef subImage = CGImageCreateWithImageInRect(imageRef, frame);
        UIImage *newImage = [UIImage imageWithCGImage:subImage];
        SKTexture *texture = [SKTexture textureWithImage:newImage];
        [imagesArr addObject:texture];
           
        dispatch_async(dispatch_get_main_queue(), ^{
            //CGImageRelease(subImage);
        });

    }
    
    
    return imagesArr;
    
}

+ (NSArray *)arrWithLine:(NSInteger)line
                      arrange:(NSInteger)arrange
                    imageSize:(CGSize)imageSize
                subImageCount:(NSInteger)count
                        image:(UIImage *)image
{
    
    
    CGImageRef imageRef = [image CGImage];
    
    CGFloat width = imageSize.height / (CGFloat)line;
    CGFloat height = imageSize.width / (CGFloat)arrange;
    
    NSMutableArray *imagesArr = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = 0; i < count; i ++) {
        
        CGFloat x = i % arrange * width;
        CGFloat y = i / arrange * height;
        
        CGRect frame = CGRectMake(x, y, width, height);
        CGImageRef subImage = CGImageCreateWithImageInRect(imageRef, frame);
        UIImage *newImage = [UIImage imageWithCGImage:subImage];
        SKTexture *texture = [SKTexture textureWithImage:newImage];
        [imagesArr addObject:texture];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //CGImageRelease(subImage);
        });

    }
    
   // dispatch_async(dispatch_get_main_queue(), ^{
        CGImageRelease(imageRef);
   // });
    return imagesArr;
}

@end
