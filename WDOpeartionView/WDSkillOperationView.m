//
//  WDSkillOperationView.m
//  HotSchool
//
//  Created by Mac on 2018/7/3.
//  Copyright © 2018年 吴冬. All rights reserved.
//

#import "WDSkillOperationView.h"
#import "WDSkillView.h"

@implementation WDSkillOperationView
{
    WDSkillView *_skillView_1;
    WDSkillView *_skillView_2;
    WDSkillView *_skillView_3;
    WDSkillView *_skillView_4;

    WDSkillView *_reloadView;
    
    WDSkillView *_attackView;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
         
        [self createSkillView];
    }
    
    return self;
}

- (void)changeAttackBtn:(NSNotification *)notification
{
    UIImage *image = notification.object;
    _attackView.imageV.image = image;
}


- (void)createSkillView{
    
//    CGFloat attackWH = 100 / 1334.0 * (kScreenWidth * 2);
//    CGFloat skillWH  = attackWH / 2.0 + 10;
//    CGFloat page = 20 / 1334.0 * (kScreenWidth * 2);
   
    CGFloat attackWH = 80 ;
    CGFloat skillWH  = attackWH / 2.0 + 20;
    CGFloat page = 85;
    CGFloat page2 = 20;
   
    //攻击按钮
    _attackView = [[WDSkillView alloc] initWithFrame:CGRectMake(self.width - attackWH - page, self.height - attackWH - 30, attackWH, attackWH)];
    [self addSubview:_attackView];

    _attackView.imageV.image = [UIImage imageNamed:@"attackOpeation"];
    _attackView.isAttackBtn = YES;
    _attackView.canUse = YES;
    [_attackView setGesture];
    
    //大按钮与小按钮之间的距离
    CGFloat skillAndAttackPage = 65.f;
    
    CGFloat attack_center_X = _attackView.center.x;
    CGFloat attack_center_Y = _attackView.center.y;
    
    
    //攻击动画
    __weak typeof(self)weakSelf = self;
    [_attackView setBeginBlock:^{
        //NSLog(@"attack!!!!!");
        if (weakSelf.bigButtonBlock) {
            weakSelf.bigButtonBlock();
        }
    }];
    
    //长按开始
    [_attackView setLongAttackBeginBlock:^{
        if (weakSelf.longAttackBeginBlock) {
            weakSelf.longAttackBeginBlock();
        }
    }];
    
    //长按结束
    [_attackView setLongAttackEndBlock:^{
        if (weakSelf.longAttackEndBlock) {
            weakSelf.longAttackEndBlock();
        }
    }];
    
    
    
    
    //顶部技能按钮
    _skillView_1 = [[WDSkillView alloc] initWithFrame:CGRectMake(attack_center_X - skillWH / 2.0, _attackView.top - skillAndAttackPage - skillWH + page2, skillWH, skillWH)];
    [self addSubview:_skillView_1];

    
    [_skillView_1 setBeginBlock:^{
        [weakSelf skillActionWithSkillType:topSkillBtn];
    }];
    
    
    //斜技能按钮
    _skillView_2 = [[WDSkillView alloc] initWithFrame:CGRectMake(0, 0, skillWH, skillWH)];
 
    CGFloat xieLine = _attackView.width / 2.0 + skillAndAttackPage;
    CGFloat changKuan = sqrt(xieLine * xieLine / 2.0);
    CGPoint center  = CGPointMake(attack_center_X - changKuan, attack_center_Y - changKuan);
    _skillView_2.center = center;
    [self addSubview:_skillView_2];
    

    [_skillView_2 setBeginBlock:^{
        [weakSelf skillActionWithSkillType:middleSkillBtn];
    }];
    
    
    //底部1技能按钮
    _skillView_3 = [[WDSkillView alloc] initWithFrame:CGRectMake(_attackView.left - skillAndAttackPage - skillWH + page2, attack_center_Y - skillWH / 2.0,skillWH, skillWH)];
    [self addSubview:_skillView_3];
    
    
    [_skillView_3 setBeginBlock:^{
        [weakSelf skillActionWithSkillType:bottomSkillBtn];
    }];
    
    
    //底部按钮2
//    _skillView_4 = [[WDSkillView alloc] initWithFrame:CGRectMake(0 , 0,skillWH, skillWH)];
//    _skillView_4.center = CGPointMake(_skillView_3.left - page - skillWH / 2.0, _attackView.center.y  + page);
//    
//    [self addSubview:_skillView_4];
    

    
    [_skillView_4 setBeginBlock:^{
        [weakSelf skillActionWithSkillType:bottom2SkillBtn];
    }];
    
    //顶部技能按钮
    _reloadView = [[WDSkillView alloc] initWithFrame:CGRectMake(0,0, skillWH, skillWH)];
    
    [self addSubview:_reloadView];
    _reloadView.imageV.image = [UIImage imageNamed:@"return"];
    _reloadView.canUse = YES;
    _reloadView.isReturnBtn = YES;
    [_reloadView setBeginBlock:^{
        [weakSelf skillActionWithSkillType:changeScene];
    }];
    
    _skillView_1.alpha = 0.7;
    _skillView_2.alpha = 0.7;
    _skillView_3.alpha = 0.7;
    _skillView_4.alpha = 0.7;
    _reloadView.alpha  = 0;
    
    _skillView_1.imageV.image = [UIImage imageNamed:@"skillOpeation"];
    _skillView_2.imageV.image = [UIImage imageNamed:@"skillOpeation"];
    _skillView_3.imageV.image = [UIImage imageNamed:@"skillOpeation"];
    _skillView_4.imageV.image = [UIImage imageNamed:@"skillOpeation"];

    
    [self clearAction];
}


- (void)skillActionWithSkillType:(SkillType)type
{
    if (self.skillBlock) {
        self.skillBlock(type);
    }
}



- (void)setTimeLabelWithType:(SkillType )type
{
    NSString *name = @"";
    //PersonManager *manager = [PersonManager sharePersonManager];
    if ([name isEqualToString:@"person"]) {
        if (type == topSkillBtn) {
            [_skillView_1 setTimeLabel:10];
        }else if(type == middleSkillBtn){
            [_skillView_2 setTimeLabel:10];
        }else if(type == bottomSkillBtn){
            [_skillView_3 setTimeLabel:5];
        }else if(type == bottom2SkillBtn){
            [_skillView_4 setTimeLabel:5];
        }
    }else if([name isEqualToString:@"shana"]){
        
        if (type == topSkillBtn) {
            [_skillView_1 setTimeLabel:5];
        }else if(type == middleSkillBtn){
            [_skillView_2 setTimeLabel:10];
        }else if(type == bottomSkillBtn){
            [_skillView_3 setTimeLabel:5];
        }else if(type == bottom2SkillBtn){
            [_skillView_4 setTimeLabel:2];
        }
         
    }else if([name isEqualToString:@"kana"]){
        
        if (type == topSkillBtn) {
            [_skillView_1 setTimeLabel:5];
        }else if(type == middleSkillBtn){
            [_skillView_2 setTimeLabel:10];
        }else if(type == bottomSkillBtn){
            [_skillView_3 setTimeLabel:5];
        }else if(type == bottom2SkillBtn){
            [_skillView_4 setTimeLabel:2];
        }
    }
    
  
}

- (void)clearAction
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger index = [defaults integerForKey:@"3"];
    index = 10;
    if (index >= 4) {
        _skillView_1.canUse = YES;
        _skillView_2.canUse = YES;
        _skillView_3.canUse = YES;
        _skillView_4.canUse = YES;
    }else if(index == 3){
        _skillView_1.canUse = YES;
        _skillView_2.canUse = YES;
        _skillView_3.canUse = YES;
    }else if(index == 2){
        _skillView_1.canUse = YES;
        _skillView_2.canUse = YES;
    }else if(index == 1){
        _skillView_1.canUse = YES;
    }else{
        _skillView_1.canUse = NO;
        _skillView_2.canUse = NO;
        _skillView_3.canUse = NO;
        _skillView_4.canUse = NO;
    }
    
    [_skillView_1 clearAction];
    [_skillView_2 clearAction];
    [_skillView_3 clearAction];
    [_skillView_4 clearAction];
}

- (void)reloadViewHidden:(BOOL)isHidden
{
    //返回按钮加时间，容许游戏界面的一些没有释放的元素释放
    if (isHidden) {
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            [weakSelf alphaAction:0];
        } completion:^(BOOL finished) {
            [weakSelf reloadCanUse:NO];
        }];
    }else{
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:2 animations:^{
            [weakSelf alphaAction:1];
        } completion:^(BOOL finished) {
            [weakSelf reloadCanUse:YES];
        }];
    }
}

- (void)reloadCanUse:(BOOL)canUse{
    _reloadView.canUse = canUse;
}

- (void)alphaAction:(CGFloat)alpha
{
    _reloadView.alpha = alpha;
}

- (void)unlockSkillWithIndex:(NSInteger)index
{
    if (index == 1) {
        [_skillView_1 unlockAnimation];
    }else if(index == 2){
        [_skillView_2 unlockAnimation];
    }else if(index == 3){
        [_skillView_3 unlockAnimation];
    }else {
        [_skillView_4 unlockAnimation];
    }
}

@end
