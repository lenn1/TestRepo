//
//  AstKatapult.m
//  Snake Escape
//
//  Created by Lennart Hansen on 21.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AstKatapult.h"
#import "SimpleAudioEngine.h"
@implementation AstKatapult
@synthesize abgefeuert,baseLevelPtr;
-(id)init
{
    if(self = [super init])
    {
        visitable = YES;
        self.scale = 0.7;
        name = @"AstKatapult";
        fangRadius.radius = 30;
        astAktiv = YES;
        abgefeuert = NO;
        animateState = 1;
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"AstKatapult.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"AstKatapult.png"];
        [self addChild:spriteSheet];
        
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"astkatapult1"]];

        
    }
    return self;
}
-(void)setPosition:(CGPoint)position
{    
    [super setPosition:position];
    position_ = position;
    fangRadius.position = ccp(self.position.x-22,self.position.y-45);
}
-(void)katapultAbschiessenAnimation
{
    [self unschedule:@selector(katapultAbschiessenAnimation)];
    if(!abgefeuert)
    {
      //  [[SimpleAudioEngine sharedEngine] playEffect:@"AstSchalter.wav"];
      //  [[SimpleAudioEngine sharedEngine] playEffect:@"AstHindernis.mp3"];
        
        [self schedule:@selector(updateSchlange) interval:0.05];
    }
}

-(void)updateSchlange
{
if(!abgefeuert)
    switch (animateState) 
    {
        case 1:
            [[baseLevelPtr getSchlangeLayer] setSchlangePosition:ccp(self.position.x-22,self.position.y-45)];
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"astkatapult1"]];
            animateState++;
            break;
            
        case 2:
            [[baseLevelPtr getSchlangeLayer] setSchlangePosition:ccp(self.position.x-65,self.position.y-30)];
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"astkatapult2"]];
            animateState++;
            break; 
            
        case 3:
            [[baseLevelPtr getSchlangeLayer] setSchlangePosition:ccp(self.position.x-70,self.position.y+20)];
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"astkatapult3"]];
            animateState++;
            break;
            
        case 4:
            [[baseLevelPtr getSchlangeLayer] setSchlangePosition:ccp(self.position.x-60,self.position.y+55)];
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"astkatapult4"]];
            animateState++;
            fangRadius.position = ccp(self.position.x-60,self.position.y+55);
            break;
            
        default:
            [self unschedule:@selector(updateSchlange)];
            [baseLevelPtr setSchlangeInAir:YES];
            [baseLevelPtr getSchlangeLayer]._body->SetLinearVelocity(b2Vec2(350/PTM_RATIO, 290/PTM_RATIO));
            [baseLevelPtr getSchlangeLayer]._body->SetAngularVelocity(-100/PTM_RATIO);
            [baseLevelPtr setSchlangeActive];
            abgefeuert = YES;
            break;
    }
}


-(void)AstWurdeBesucht
{
    [self schedule:@selector(katapultAbschiessenAnimation) interval:0.3];
}

@end
