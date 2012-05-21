//
//  Vogel.m
//  Snake Escape
//
//  Created by Lennart Hansen on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Vogel.h"
@implementation Vogel
@synthesize maxRight,maxLeft,directionRight,delegate,abwurfPosition,speed;
#define moveSchlangeToActionTag 998877
-(id)init
{
    if(self = [super init])
    {
        self.scale = 1.0;
        fangRadius.radius = 30.0f;

        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"vogel.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"vogel.png"];
        [self addChild:spriteSheet];
        
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"vogel0"]];
        
        NSMutableArray *frames = [NSMutableArray array];
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"vogel0"]];
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"vogel1"]];
        
        
        CCAnimation *fluegelschlag = [CCAnimation animationWithFrames:frames delay:0.7];
        CCActionInterval* fluegelSchlagAnimation = [CCAnimate actionWithAnimation:fluegelschlag restoreOriginalFrame:YES];
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:fluegelSchlagAnimation];
        [self runAction:repeat];
        
        directionRight = YES;
        maxRight= self.position.x+100.0;
        maxLeft = self.position.x-100.0;
        schlangeGefangen = NO;
        abwurfPosition = maxRight-20;
        speed = 100;
    }
    return self;
}

-(CGFloat)XPositionInSeconds:(CGFloat)seconds
{
    CGFloat distance = speed*seconds;
    
    if(directionRight)
        return (maxRight-sqrtf(powf(maxRight-(self.position.x+distance), 2)));
    else
        return (maxLeft+sqrtf(powf(maxLeft-(self.position.x-distance), 2)));

}


-(void)FrameUpdate:(ccTime)delta
{
    {
        if(directionRight)
        {
            if(self.position.x+100*delta <= maxRight)
                self.position = ccp(self.position.x+speed*delta,self.position.y);
            else
                directionRight = NO;
            self.flipX = YES;

        }
        else
        {
            if(self.position.x+100*delta >= maxLeft)
                self.position = ccp(self.position.x-speed*delta,self.position.y);
            else 
                directionRight = YES;
            self.flipX = NO;

        }
    }
    
    if(schlangeGefangen)
    {
        [[delegate getSchlangeLayer]setSchlangePosition:ccp(self.position.x,self.position.y-42.0)];
        if([delegate getSchlangeLayer].schlange.position.x < abwurfPosition+5 && [delegate getSchlangeLayer].schlange.position.x > abwurfPosition-5)
        {
            [delegate getSchlangeLayer]._body->SetActive(true);
            schlangeGefangen = NO;
            schlangeVerlaesst = YES;
            
            if(directionRight)
            {
                [delegate getSchlangeLayer]._body->SetLinearVelocity(b2Vec2(speed/PTM_RATIO,0.0));
            }
            else
            {
                [delegate getSchlangeLayer]._body->SetLinearVelocity(b2Vec2(-speed/PTM_RATIO,0.0));
            }

            NSMutableArray *frames = [NSMutableArray array];
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"vogel0"]];
            [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"vogel1"]];
            
            
            CCAnimation *fluegelschlag = [CCAnimation animationWithFrames:frames delay:0.7];
            CCActionInterval* fluegelSchlagAnimation = [CCAnimate actionWithAnimation:fluegelschlag restoreOriginalFrame:YES];
            CCRepeatForever* repeat = [CCRepeatForever actionWithAction:fluegelSchlagAnimation];
            [self runAction:repeat];

        }
    }
    else 
    {
        if([delegate getSchlangeLayer].schlangeInAir)
        {

            if([MathHelper IsCGPoint:[delegate getSchlangeLayer].schlange.position  InRadius:fangRadius.radius OfPoint:self.position])
            {
                if(!schlangeVerlaesst)
                {
                    schlangeGefangen = YES;
                    [delegate getSchlangeLayer]._body->SetActive(false);
                    [[delegate getSchlangeLayer] moveSchlangeTo:ccp([self XPositionInSeconds:0.1],self.position.y-30.0)];
                    [self stopAllActions];
                    NSMutableArray *frames = [NSMutableArray array];
                    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"vogel2"]];
                    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"vogel3"]];
                    
                    
                    CCAnimation *fluegelschlag = [CCAnimation animationWithFrames:frames delay:0.7];
                    CCActionInterval* fluegelSchlagAnimation = [CCAnimate actionWithAnimation:fluegelschlag restoreOriginalFrame:YES];
                    CCRepeatForever* repeat = [CCRepeatForever actionWithAction:fluegelSchlagAnimation];
                    [self runAction:repeat];
                    
                }
            }
            else 
            {
                schlangeVerlaesst = NO;
            }
        }
    }
}   
@end
