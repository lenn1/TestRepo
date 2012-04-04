//
//  Vogel.m
//  Snake Escape
//
//  Created by Lennart Hansen on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Vogel.h"
@implementation Vogel
@synthesize maxRight,maxLeft,directionRight;
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
    }
    return self;
}
-(void)FrameUpdate:(ccTime)delta
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
@end
