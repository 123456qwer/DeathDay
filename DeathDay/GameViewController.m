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
#import "WDSkillOperationView.h"

@implementation GameViewController
{
    WDMoveOpeartionView *_moveOperationView;
    WDBaseScene         *_selectScene;
    WDSkillOperationView *_skillView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addObserveAction];
    
    NSString *mapName = [[WDUserInformation shareUserInfoManager]userSceneMap];
    [self startGameSceneWithMapName:mapName];
    
    //移动操作按键
    [self createOperationView];
    //技能操作按键
    [self createSkillOperationView];
    
    [self createMiddleLine];
    
}

#pragma mark - 添加通知 -
- (void)addObserveAction{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationForChangeMap:) name:kNotificationForChangeScene object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationForChangeAttackBtn:) name:kNotificationForChangeAttackBtn object:nil];
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

- (void)notificationForChangeMap:(NSNotification *)notification
{
    [self startGameSceneWithMapName:notification.object];
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

#pragma mark - 技能攻击键控制 -
- (void)attackClick{
    [_selectScene attackBtnClick];
}

#pragma mark 技能面板
- (void)createSkillOperationView
{
    //技能攻击按键
    _skillView = [[WDSkillOperationView alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0, 0, kScreenWidth / 2.0, kScreenHeight)];
    //skillView.backgroundColor = [UIColor cyanColor];
    //_skillView.alpha = 0;
    [self.view addSubview:_skillView];
    
    __weak typeof(self)weakSelf = self;
    //人物释放技能
    [_skillView setSkillBlock:^(SkillType type) {
        //[weakSelf skillAction:type];
        NSLog(@"%lu",(unsigned long)type);
    }];
    
    //人物普通攻击
    [_skillView setBigButtonBlock:^{
        
        [weakSelf attackClick];
    }];
    
    //长按开始<准备蓄力阶段>
    [_skillView setLongAttackBeginBlock:^{
        //[weakSelf longAttackBeginAction];
    }];
    
    //长按结束<蓄力结束攻击阶段>
    [_skillView setLongAttackEndBlock:^{
        //[weakSelf longAttackEndAction];
    }];
}

//修改技能面板
- (void)notificationForChangeAttackBtn:(NSNotification *)notification
{
    [_skillView changeAttackBtn:notification];
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
