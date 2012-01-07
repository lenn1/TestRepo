//
//  AstSchalter.m
//  Snake Escape
//
//  Created by Lennart Hansen on 05.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AstSchalter.h"
#import "SimpleAudioEngine.h"

@implementation AstSchalter
@synthesize schalterUnten;
- (id)initWithTarget:(AstNormal*)ast AndRotation:(CGFloat)rotation AndPosition:(CGPoint)position
{
    self = [super init];
    if (self) 
    {
        visitable = YES;
        self.scale = 1.0;
        name = @"AstSchalter";
        fangRadius.radius = 30;
        astAktiv = YES;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"AstSchalter.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"AstSchalter.png"];
        [self addChild:spriteSheet];
        
        CCTexture2D* texture = [[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"astSchalter0"]texture];
        [self setTexture:texture];
        [self setTextureRect:CGRectMake(1, 1, 50, 95)];
        toPosition = position;
        toRotation = rotation;
        target = ast;
        schalterUnten = NO;
    }
    return self;
}
-(void)setPosition:(CGPoint)position
{
    [super setPosition:position];
    position_ = position;
    fangRadius.position = ccp(self.position.x, self.position.y+30);
}

-(void)SchalterUmschaltenAnimation
{
    if(!schalterUnten)
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"AstSchalter.wav"];
        [[SimpleAudioEngine sharedEngine] playEffect:@"AstHindernis.mp3"];


        NSMutableArray *frames = [NSMutableArray array];
        for(int i = 0; i < 5; ++i) 
        {
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"astSchalter%d", i]]];
        }
    
        CCAnimation *SchalterUmschalten = [CCAnimation animationWithFrames:frames delay:0.1];

        CCAction* SchalterUmschaltenAction = [CCAnimate actionWithAnimation:SchalterUmschalten restoreOriginalFrame:NO];
        [self runAction:SchalterUmschaltenAction];
    }
}

-(void)AstWurdeBesucht
{
        if(!schalterUnten)
        {
            astAktiv = YES;
            CCRotateBy* rotateTo = [CCRotateBy actionWithDuration:2.7 angle:toRotation];
            CCMoveBy* moveTo = [CCMoveBy actionWithDuration:2.7 position:toPosition];
            CCEaseInOut* easeRotate = [CCEaseInOut actionWithAction:rotateTo rate:3];
            CCEaseInOut* easeMove = [CCEaseInOut actionWithAction:moveTo rate:3];

            CCSpawn* moveRotate = [CCSpawn actions:easeMove,easeRotate, nil];
    
            [target runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.5],moveRotate, nil]];
            [self SchalterUmschaltenAnimation];
            schalterUnten = YES;
            fangRadius.position = ccp(self.position.x, self.position.y-30);
        }
    
}


///////////////////////////////////////////////// Just in Case... 
@end
