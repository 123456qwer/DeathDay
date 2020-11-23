//
//  GameViewController.m
//  DeathDay
//
//  Created by Mac on 2020/11/23.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import "GameViewController.h"
#import "WDBaseScene.h"
#import "WDMoveOpeartionView.h"

@implementation GameViewController
{
    WDMoveOpeartionView *_moveOperationView;
    WDBaseScene         *_selectScene;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSString *mapName = [WDUserInformation userSceneMap];
    [self startGameSceneWithMapName:mapName];
    
    [self createOperationView];
    
    [self createMiddleLine];
    
}

#pragma mark - 中线 -
- (void)createMiddleLine
{
//    UIView *middleLine = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0 - 0.5, 0, 1, kScreenHeight)];
//    middleLine.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:middleLine];
//       
//    UIView *middleLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight / 2.0 - 0.5, kScreenWidth, 1)];
//    middleLine2.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:middleLine2];
}


#pragma mark - 选择游戏地图 -
- (void)startGameSceneWithMapName:(NSString *)mapName{
    
    //释放内存
    [_selectScene releaseAction];
   
    Class class = NSClassFromString(mapName);
    WDBaseScene *scene = [class nodeWithFileNamed:mapName];
    scene.scaleMode  = SKSceneScaleModeAspectFit;
    _selectScene = scene;
    
    SKView *skView = (SKView *)self.view;
    
    SKTransition *tr = [SKTransition fadeWithDuration:1];

    // Present the scene

    [skView presentScene:_selectScene transition:tr];
    
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsPhysics = YES;
    
    
    __weak typeof(self)weakSelf = self;
    [scene setChangeMapWithMapName:^(NSString * _Nonnull sceneName) {
        [weakSelf startGameSceneWithMapName:sceneName];
    }];
    
}


#pragma mark - 方向控制键 -
- (void)createOperationView
{
    _moveOperationView = [[WDMoveOpeartionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 2.0, kScreenHeight)];
//    _moveOperationView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_moveOperationView];
    
    __weak typeof(self)weakSelf = self;
    [_moveOperationView setMoveBlock:^(NSString *direction, CGPoint point) {
        [weakSelf moveAction:direction position:point];
    }];
}

//猪脚移动
- (void)moveAction:(NSString *)direction position:(CGPoint )position
{
    [_selectScene moveActionWithDirection:direction position:position];
}



























- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
