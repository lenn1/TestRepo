//
//  AstHindernis.m
//  Snake Escape
//
//  Created by Lennart Hansen on 03.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AstHindernis.h"

@implementation AstHindernis
- (id)init {
    self = [super init];
    if (self) 
    {
        visitable = NO;
        self.scale = 1.0;
        name = @"AstHindernis";
        fangRadius.radius = 30;
        astAktiv = YES;
        
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: @"astHindernis.png"];
        CGRect rect = CGRectZero;
        rect.size = texture.contentSize;
        [self setTexture:texture];
        [self setTextureRect:rect];
        
        space = [CPSpace sharedSpace];
        body  = [CPBody bodyWithMass:INFINITY andMoment:INFINITY];
        
        shape = [CPShape shapeSegmentWithBody:body Endpoints:ccp(108-111,100-103) :ccp(107-111,100-123) andRadius:0];
        [space  addShape:shape];
        shape.friction = 0.8;
        
        shape2 = [CPShape shapeSegmentWithBody:body Endpoints:ccp(0-111,100-200) :ccp(107-111,100-123) andRadius:0];
        [space addShape:shape2];
        shape2.friction = 0.8;
        
        shape3 = [CPShape shapeSegmentWithBody:body Endpoints:ccp(91-111,100-139) :ccp(65-111,100-192) andRadius:0];
        [space addShape:shape3];
        shape3.friction = 0.8;
        
        shape4 = [CPShape shapeSegmentWithBody:body Endpoints:ccp(69-111,100-148) :ccp(41-111,100-154) andRadius:0];
        [space addShape:shape4];
        shape4.friction = 0.8;

    }
    return self;
}
-(void)onEnter
{
   
    [super onEnter];
}

-(void)onExit
{
    [space removeShape:shape];
    [space removeShape:shape2];
    [space removeShape:shape3];
    [space removeShape:shape4];
    [super onExit];
}
- (void)setPosition:(CGPoint)position
{
    [super setPosition:position];
    shape.body.position = self.position;

}

- (void)setRotation:(float)rotation
{
    [super setRotation:rotation];
    shape.body.degAngle = -self.rotation;
}

@end