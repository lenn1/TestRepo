//
//  Baumharz.m
//  Snake Escape
//
//  Created by Lennart Hansen on 18.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Baumharz.h"
#define PTM_RATIO 32.0
@implementation Baumharz
- (id)initWithWorld:(b2World*)worldPtr
{
    self = [super init];
    if (self) 
    {
        toDestroy = NO;
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: @"harz.png"];
        CGRect rect = CGRectZero;
        rect.size = texture.contentSize;
        [self setTexture:texture];
        [self setTextureRect:rect];

        b2BodyDef harzBodyDef;
        harzBodyDef.type = b2_staticBody;
        harzBodyDef.position.Set(self.position.x/PTM_RATIO, self.position.y/PTM_RATIO);
        body = worldPtr->CreateBody(&harzBodyDef);

        b2CircleShape harzShape;
        harzShape.m_radius = 10.5/PTM_RATIO;

        b2FixtureDef harzFixtureDef;
        harzFixtureDef.shape = &harzShape;
        harzFixtureDef.isSensor = true;
        harzFixtureDef.userData = self;
        body->CreateFixture(&harzFixtureDef);
    }
    return self;
}
-(void)toDestroy
{
    toDestroy = YES;
}
-(void)FrameUpdate:(ccTime)delta
{
    if(toDestroy && body)
    {
        body->GetWorld()->DestroyBody(body);
        [self.parent removeChild:self cleanup:YES];
        body = NULL;
    }
}
-(void)setPosition:(CGPoint)position
{
    [super setPosition:position];
    body->SetTransform(b2Vec2(position.x/PTM_RATIO, position.y/PTM_RATIO), body->GetAngle());
}
@end
