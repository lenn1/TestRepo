//
//  Credits.m
//  Snake Escape
//
//  Created by Lennart Hansen on 20.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Credits.h"
#import "MainMenu.h"
#import "SimpleAudioEngine.h"
@implementation Credits
+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
	Credits *layer = [Credits node];
    [scene addChild: layer];
    return scene;
}

- (id)init {
    self = [super init];
    if (self) 
    {
        [[CCTouchDispatcher sharedDispatcher]addTargetedDelegate:self priority:0 swallowsTouches:YES];
        size = [[CCDirector sharedDirector] winSize];
        CCSprite* bg = [CCSprite spriteWithFile:@"bg.png"];
        bg.position = ccp(size.width/2,size.height/2);
        [self addChild:bg];
        
        credits = [CCSprite spriteWithFile:@"credits.png"];
        credits.position = ccp(size.width/2,-500);
        [self addChild:credits];
        
        CCSprite* fade = [CCSprite spriteWithFile:@"credits_fade.png"];
        fade.position = ccp(size.width/2,size.height/2);
        [self addChild:fade];
        
        [self repeater];
        NSLog(@"Musab soll mal mithelfen!");
        NSLog(@"Das sagen alle !!! ");

                
    }
    return self;
}
-(void)onExit
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
}
-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    if(![[SimpleAudioEngine sharedEngine]isBackgroundMusicPlaying])
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"soundtrack.mp3" loop:YES];
    
}
-(void)goToMainMenu
{
    [self stopAllActions];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[MainMenu scene]]];

}
-(void) ccTouchMoved:(UITouch*)touch withEvent:(UIEvent*)event
{
    singletap = NO;
    CGPoint touchLocation = [touch locationInView: [touch view]];
    CGPoint prevLocation = [touch previousLocationInView: [touch view]];
    
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    prevLocation = [[CCDirector sharedDirector] convertToGL: prevLocation];
    
    CGPoint diff = ccpSub(touchLocation,prevLocation);
    
    CGPoint currentPos = [credits position];
    if(currentPos.y + diff.y > -500 && currentPos.y + diff.y < 800)
    [credits setPosition: ccpAdd(currentPos, ccp(0,diff.y))];
}

- (void)dealloc {
    [super dealloc];
}
-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(singletap)
        
    {
        [self goToMainMenu];
        return;
    }
    
    CCFiniteTimeAction* moveAction = [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:25*((800-credits.position.y)/1300) position:ccp(size.width/2,800)]rate:1.3];
    CCFiniteTimeAction* moveAction2 = [CCMoveTo actionWithDuration:0 position:ccp(size.width/2,-500)];
    CCCallFunc* repeater = [CCCallFunc actionWithTarget:self selector:@selector(repeater)];
    
    CCSequence* seq = [CCSequence actions:moveAction,moveAction2,repeater, nil];

    [credits runAction:seq];


}
-(void)repeater
{
    CCFiniteTimeAction* moveAction = [CCMoveTo actionWithDuration:25 position:ccp(size.width/2,800)];
    CCFiniteTimeAction* moveAction2 = [CCMoveTo actionWithDuration:0 position:ccp(size.width/2,-500)];
    CCSequence* seq = [CCSequence actions:moveAction,moveAction2, nil];
    CCRepeatForever* moveRepeat = [CCRepeatForever actionWithAction:seq];
    [credits runAction:moveRepeat];
    
}
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    singletap = YES;
    [credits stopAllActions];
    return YES;
}

@end
