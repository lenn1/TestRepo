//
//  VerkohlterAst.m
//  Snake Escape
//
//  Created by Lennart Hansen on 15.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VerkohlterAst.h"

#import "SimpleAudioEngine.h"

@implementation VerkohlterAst
@synthesize delegate;
-(id)init
{
    if(self = [super init])
    {
        self.scale = 1.0;
        name = @"VerkohlterAst";
        fangRadius.radius = 30;
        astBroken = NO;
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: @"VerkohlterAst.png"];
        CGRect rect = CGRectZero;
        rect.size = texture.contentSize;
        [self setTexture:texture];
        [self setTextureRect:rect];
        TimerAlreadyStarted = NO;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sanduhr.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"sanduhr.png"];
        [self addChild:spriteSheet];
        
    }
    return self;
}
-(BOOL)astAktiv
{
    return YES;
}

-(void)AstWurdeBesucht
{   if(!TimerAlreadyStarted)
    {
        [[SimpleAudioEngine sharedEngine]playEffect:@"VerkohlterAst.wav"];
        
        [self schedule:@selector(TimelimitIsUp) interval:2];
        TimerAlreadyStarted = YES;
        
        CCSprite* sanduhr = [CCSprite spriteWithSpriteFrameName:@"sanduhr_1"];
        sanduhr.position = ccp(self.position.x+30,self.position.y+30);
        
        if([delegate respondsToSelector:@selector(addChild:)])
            [(CCNode*)delegate addChild:sanduhr];

            NSMutableArray *frames = [NSMutableArray array];
            for(int i = 1; i <= 30; ++i) 
            {
                [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"sanduhr_%d", i]]];
            }
            
            CCAnimation *sanduhrAblaufenAnimation = [CCAnimation animationWithFrames:frames delay:0.066666f];
            CCAction* sanduhrAblaufen = [CCAnimate actionWithAnimation:sanduhrAblaufenAnimation restoreOriginalFrame:NO];
            CCAction* sandUhrAblaufenUndFadeOut = [CCSequence actionOne:(CCFiniteTimeAction*)sanduhrAblaufen two:[CCFadeOut actionWithDuration:0.2]];
            [sanduhr runAction:sandUhrAblaufenUndFadeOut];
        
    }
}
-(void)TimelimitIsUp
{
    CCParticleSystemQuad* staub = [CCParticleSystemQuad particleWithFile:@"VerkohlterAstZuStaub.plist"];
    staub.position = self.position;
    staub.positionType = kCCPositionTypeRelative;
    [self.parent addChild:staub];
    
    [self unschedule:@selector(TimelimitIsUp)];
    if([delegate respondsToSelector:@selector(VerkohlterAstTimelimitIsUp:)])
        [delegate VerkohlterAstTimelimitIsUp:self]; 
    astBroken = YES;
    [self runAction:[CCFadeTo actionWithDuration:0.2]];
    visitable = NO;


}
-(BOOL)astBroken
{
    return astBroken;
}
@end
