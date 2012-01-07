//
//  HUDLayer.m
//  Snake Escape
//
//  Created by Lennart Hansen on 05.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"
#define deviceHeight 320
#define deviceWidth  480

@implementation HUDLayer
- (id)init
{
    self = [super init];
    if (self) 
    {
        _remainingTime = 0; // Just in case.. 
        CCSprite* pauseButton = [CCSprite spriteWithFile:@"pause.png"];
        CGSize winSize = [[CCDirector sharedDirector]winSize];
        pauseButton.position = ccp(winSize.width-20, winSize.height-20);
        [self addChild:pauseButton];
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"number.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"number.png"];
        [self addChild:spriteSheet];
        
        Einer = [CCSprite spriteWithSpriteFrameName:@"Number0"];
        Einer.position = ccp(30,deviceHeight-15);
        [self addChild:Einer];
        
        Zehner = [CCSprite spriteWithSpriteFrameName:@"Number0"];
        Zehner.position = ccp(15,deviceHeight-15);
        [self addChild:Zehner];  
        CCParticleSystemQuad* firewall = [CCParticleSystemQuad particleWithFile:@"firewall.plist"];
        firewall.position = ccpAdd(firewall.position, ccp(240,0));
        [self addChild:firewall];
        
    }
    return self;
    
}
-(void)onEnter
{
    [super onEnter];
    [self schedule:@selector(decreaseTime) interval:1];
    [self decreaseTime];
}
-(void)onExit
{
    [self unschedule:@selector(decreaseTime)];
    [super onExit];
}
-(void)decreaseTime
{
    if(_remainingTime-1 >=0)
    {
        _remainingTime--;
        NSInteger ZehnerZiffer = _remainingTime/10;
        [Zehner setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Number%d",ZehnerZiffer]]];

        NSInteger EinerZiffer = _remainingTime-(ZehnerZiffer*10);
        [Einer setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Number%d",EinerZiffer]]];
    }
}

-(void)setRemainingTime:(NSInteger)remainingTime
{
    _remainingTime = remainingTime+1;
}
-(NSInteger)remainingTime
{
    return _remainingTime;
}
@end