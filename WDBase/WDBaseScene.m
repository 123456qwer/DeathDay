//
//  WDBaseScene.m
//  Maker
//
//  Created by Mac on 2020/11/18.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import "WDBaseScene.h"
#import "WDCalculateTool.h"
@implementation WDBaseScene

{
    NSMutableDictionary *_moveDic;
}
- (void)didMoveToView:(SKView *)view
{

    /*
     屏幕宽度 ： 1792 828
     BG     ： 816 624   -> 2.19...   1792  1370   一半 407
     */
    
    CGFloat screenWidth = kScreenWidth * 2.0;
    CGFloat screenHeight = kScreenHeight * 2.0;
    
    self.size = CGSizeMake(screenWidth, screenHeight);
    
    _bgNode = (WDBaseNode *)[self childNodeWithName:@"bgNode"];
    
    CGFloat final = 1;
    
    if (_bgNode.size.width < screenWidth) {
        CGFloat scale  = screenWidth / _bgNode.size.width;
        _bgNode.xScale = scale;
        _bgNode.yScale = scale;
        
        final = scale;
    }

    if (_bgNode.size.height < screenHeight) {
        CGFloat scale = screenHeight / _bgNode.size.height;
        _bgNode.xScale = scale;
        _bgNode.yScale = scale;
        
        final = scale;
    }
    
    
    
    
    NSArray *personTextureArr = [WDCalculateTool arrWithLine:4 arrange:3 imageSize:CGSizeMake(48 * 3.0, 48 * 4.0) subImageCount:12 image:[UIImage imageNamed:@"m.png"]];
    
    _moveDic = [NSMutableDictionary dictionary];
    NSArray *key = @[@"down",@"left",@"right",@"up"];
    int a = 0;
    for (int i = 0; i < key.count; i ++) {
        
        NSArray *sub = [personTextureArr subarrayWithRange:NSMakeRange(a, 3)];
        [_moveDic setObject:sub forKey:key[i]];
         a += 3;
    }
    
    _personNode = [WDBaseNode spriteNodeWithTexture:personTextureArr[0]];
    //_personNode = [WDBaseNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(50, 50)];
    _personNode.position = CGPointMake(0, 0);
    _personNode.anchorPoint = CGPointMake(0, 0);
    _personNode.xScale = 1.5;
    _personNode.yScale = 1.5;
    [_bgNode addChild:_personNode];
    
    CGFloat bgWidth  = _bgNode.size.width;
    CGFloat bgHeight = _bgNode.size.height;
    
    _usableMoveX = bgWidth  - screenWidth;
    _usableMoveY = bgHeight - screenHeight;
    
    NSMutableArray *xArr = [NSMutableArray array];
    NSMutableArray *yArr = [NSMutableArray array];

    //游戏画布宽度
    CGFloat screenWidthHalf  = screenWidth / 2.0 / final;
    CGFloat screenHeightHalf = screenHeight / 2.0 / final;
    
    for (int positionX = 0; positionX < bgWidth; positionX ++) {
        
        if (positionX * final <= screenWidthHalf * final)  {
            [xArr addObject:@(0)];
        }else if(positionX * final > bgWidth - screenWidthHalf * final){
            
            [xArr addObject:@(- _usableMoveX)];
            
        }else{
            [xArr addObject:@(- (positionX * final - screenWidthHalf * final))];
        }
    }
    
    
    for (int positionY = 0; positionY < bgHeight; positionY ++) {
        
        if (positionY <= screenHeightHalf) {
            [yArr addObject:@(0)];
        }else if(positionY * final > bgHeight - screenHeightHalf * final){
            [yArr addObject:@(-_usableMoveY)];
        }else{
            [yArr addObject:@(-(positionY * final - screenHeightHalf * final))];
        }
    }
    
    _map_x = xArr;
    _map_y = yArr;
    
    NSLog(@"%lf",_bgNode.size.width);
    
    _moveLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(moveAction)];
    [_moveLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)moveActionWithDirection:(NSString *)direction position:(CGPoint)point
{
    
    NSLog(@"%@",direction);
    
    if (!direction) {
        direction = @"up";
    }
    
    CGPoint personPoint = _personNode.position;
     
    CGPoint movePoint = CGPointMake(personPoint.x + point.x, personPoint.y + point.y);
    
    _personNode.position = [WDCalculateTool calculateMaxMoveXAndY:movePoint maxX:self.bgNode.size.width maxY:self.bgNode.size.height personSize:self.personNode.size];
    _personNode.position = movePoint;
    
    if (![_personNode.direction isEqualToString:direction]) {
            _personNode.direction = direction;

        [_personNode removeActionForKey:@"move"];

        SKAction *moveA = [SKAction animateWithTextures:_moveDic[direction] timePerFrame:0.1];
        SKAction *rep = [SKAction repeatActionForever:moveA];
        [_personNode runAction:rep withKey:@"move"];
    }
    
   
    
    //下 左 右 上
    
    NSLog(@"personX:%lf personY:%lf",movePoint.x,movePoint.y);
}

- (void)moveAction{
    
    NSInteger indexX = _personNode.position.x;
    NSInteger indexY = _personNode.position.y;
    NSInteger x = _bgNode.position.x;
    NSInteger y = _bgNode.position.y;
    
    if (indexX <= _map_x.count - 1 && indexX >= 0) {
        x = [_map_x[indexX]integerValue];
    }
    
    if (indexY <= _map_y.count - 1 && indexY >= 0) {
       y = [_map_y[indexY]integerValue];
    }
     
    
    _bgNode.position = CGPointMake(x, y);
}

- (void)touchDownAtPoint:(CGPoint)pos {
}

- (void)touchMovedToPoint:(CGPoint)pos {
}

- (void)touchUpAtPoint:(CGPoint)pos {
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchDownAtPoint:[t locationInNode:self]];}
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self]];}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}

-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
