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


- (void)didMoveToView:(SKView *)view
{

    self.name = NSStringFromClass([self class]);
    self.physicsWorld.contactDelegate = self;

    
    [self setMap];
    
    [self setPerson];

    
    [self performSelector:@selector(canMoveA) withObject:nil afterDelay:0.8];
}


/// 设置玩家相关信息
- (void)setPerson{
    
    _personNode = [WDBaseNode spriteNodeWithName:@"user"];
    _personNode.position = CGPointMake(0, 0);
    _personNode.name = @"person";
    [_bgNode addChild:_personNode];
    
    [_personNode addShadow1];
    
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(_personNode.size.width, _personNode.size.height) center:CGPointMake(0, 0)];
    body.allowsRotation = NO;
    body.affectedByGravity = NO;
    body.categoryBitMask = PLAYER_CATEGORY;
    body.collisionBitMask = PLAYER_COLLISION;
    body.contactTestBitMask = PLAYER_CONTACT;
       
    _personNode.physicsBody = body;
}

/// 设置地图相关信息
- (void)setMap{
    
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
    
    
    _moveLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(moveAction)];
    [_moveLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)canMoveA{
    self.canGo = YES;
}

- (void)moveActionWithDirection:(NSString *)direction position:(CGPoint)point
{

    if (!self.canGo) {
        return;
    }
    //NSLog(@"%@",direction);
    
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

        SKAction *moveA = [SKAction animateWithTextures:_personNode.moveDic[direction] timePerFrame:0.15];
        SKAction *rep = [SKAction repeatActionForever:moveA];
        [_personNode runAction:rep withKey:@"move"];
    }
    
   
    
    //下 左 右 上
    //NSLog(@"personX:%lf personY:%lf",movePoint.x,movePoint.y);
}

- (void)moveAction{
    
    NSInteger indexX = _personNode.position.x;
    NSInteger indexY = _personNode.position.y;
    NSInteger x = _bgNode.position.x;
    NSInteger y = _bgNode.position.y;
    
    if (indexX <= _map_x.count - 1 && indexX >= 0 && _map_x.count != 0) {
        x = [_map_x[indexX]integerValue];
    }
    
    if (indexY <= _map_y.count - 1 && indexY >= 0 && _map_y.count != 0) {
       y = [_map_y[indexY]integerValue];
    }
     
    _bgNode.position = CGPointMake(x, y);
}


- (void)createWallWithCount:(NSInteger)wallCount
{
    for (int i = 0; i < wallCount; i ++) {
        NSString *wallName = [NSString stringWithFormat:@"wall%d",i + 1];
        SKSpriteNode *wall = (SKSpriteNode *)[self.bgNode childNodeWithName:wallName];
        wall.alpha = 0;
        
        [self setWallPhysicyBody:wall];
    }
}

- (void)createDoorNodeWithName:(NSString *)name
{
    SKSpriteNode *door = (SKSpriteNode *)[self.bgNode childNodeWithName:name];
    door.alpha = 0;
    [self setMonsterPhysicyBody:door];
}

- (void)setWallPhysicyBody:(SKSpriteNode *)node
{
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:node.size];
    body.allowsRotation = NO;
    body.affectedByGravity = NO;
    body.categoryBitMask = WALL_CATEGORY;
    body.collisionBitMask = WALL_COLLISION;
    body.contactTestBitMask = WALL_CONTACT;
    node.physicsBody = body;
}

- (void)setMonsterPhysicyBody:(SKSpriteNode *)node
{
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:node.size];
    body.allowsRotation = NO;
    body.affectedByGravity = NO;
    body.categoryBitMask = MONSTER_CATEGORY;
    body.collisionBitMask = MONSTER_COLLISION;
    body.contactTestBitMask = MONSTER_CONTACT;
    node.physicsBody = body;
}


- (SKSpriteNode *)nodeWithNodeName:(NSString *)name
{
    SKSpriteNode *childNode = (SKSpriteNode *)[self.bgNode childNodeWithName:name];
    return childNode;
}

- (void)releaseAction
{
    if (_moveLink) {
        [_moveLink invalidate];
        _moveLink = nil;
    }
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
