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
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: @"vogel.png"];
        CGRect rect = CGRectZero;
        rect.size = texture.contentSize;
        [self setTexture:texture];
        [self setTextureRect:rect];
        directionRight = YES;
        maxRight= self.position.x+100.0;
        maxLeft = self.position.x-100.0;
        schlangeGefangen = NO;
        abwurfPosition = maxRight-20;
        speed = 100;
        self.scale = 0.1;

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
        [[delegate getSchlangeLayer]setSchlangePosition:ccp(self.position.x,self.position.y-20.0)];
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
                    [[delegate getSchlangeLayer] moveSchlangeTo:ccp([self XPositionInSeconds:0.1],self.position.y-20.0)];
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
