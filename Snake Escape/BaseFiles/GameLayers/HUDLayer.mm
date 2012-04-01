//
//  HUDLayer.m
//  Snake Escape
//
//  Created by Lennart Hansen on 05.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"
#import "UsefulStuff.h"
#define deviceHeight 320
#define deviceWidth  480

@implementation HUDLayer
- (id)init
{
    self = [super init];
    if (self) 
    {
        _remainingTime = 0; // Just in case.. 
        CGSize winSize = [[CCDirector sharedDirector]winSize];
        
        CCLabelTTF* pauseLabel = [CCLabelTTF labelWithString:@"II" fontName:@"eartmbe.ttf" fontSize:40];
        pauseLabel.position = ccp(winSize.width-15,winSize.height-15);
        CCRenderTexture* pauseStroke = [UsefulStuff createStrokeTTF:pauseLabel size:3 color:ccBLACK];
        [self addChild:pauseStroke];
        [self addChild:pauseLabel];


        zeit = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",_remainingTime] fontName:@"eartmbe.ttf" fontSize:40];
        zeit.position = ccp(30, deviceHeight-15);
        stroke = [UsefulStuff createStrokeTTF:zeit size:3 color:ccBLACK];
        [self addChild:stroke];
        [self addChild:zeit];
        
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
        [self removeChild:stroke cleanup:YES];
        [zeit setString:[NSString stringWithFormat:@"%d",_remainingTime]];
        stroke = [UsefulStuff createStrokeTTF:zeit size:3 color:ccBLACK];
        [self addChild:stroke z:zeit.zOrder-1];
        
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