//
//  Vogel.m
//  Snake Escape
//
//  Created by Lennart Hansen on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Vogel.h"
@implementation Vogel
@synthesize maxRight,maxLeft,directionRight,delegate,abwurfPosition;
#define moveSchlangeToActionTag 998877
-(id)init
{
    if(self = [super init])
    {
        [[CCTextureCache sharedTextureCache] addImage: @"AstNormalAktiv.png"];
        self.scale = 1.0;
        fangRadius.radius = 30.0f;
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: @"AstNormalInaktiv.png"];
        CGRect rect = CGRectZero;
        rect.size = texture.contentSize;
        [self setTexture:texture];
        [self setTextureRect:rect];
        directionRight = YES;
        maxRight= self.position.x+100.0;
        maxLeft = self.position.x-100.0;
        schlangeGefangen = NO;
        abwurfPosition = maxRight-20;
    }
    return self;
}
-(void)FrameUpdate:(ccTime)delta
{
    {
        if(directionRight)
        {
            if(self.position.x+100*delta <= maxRight)
                self.position = ccp(self.position.x+100*delta,self.position.y);
            else
                directionRight = NO;
        }
        else
        {
            if(self.position.x+100*delta >= maxLeft)
                self.position = ccp(self.position.x-100*delta,self.position.y);
            else 
                directionRight = YES;
        }
    }
    
    if(schlangeGefangen)
    {
        [[delegate getSchlangeLayer]setSchlangePosition:self.position];
        if([delegate getSchlangeLayer].schlange.position.x < abwurfPosition+5 && [delegate getSchlangeLayer].schlange.position.x > abwurfPosition-5)
        {
            [delegate getSchlangeLayer]._body->SetActive(true);
            schlangeGefangen = NO;
            schlangeVerlaesst = YES;
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
                    [[delegate getSchlangeLayer] moveSchlangeTo:self.position];
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
