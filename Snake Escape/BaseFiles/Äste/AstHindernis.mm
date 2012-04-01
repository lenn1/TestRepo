//
//  AstHindernis.m
//  Snake Escape
//
//  Created by Lennart Hansen on 03.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AstHindernis.h"

@implementation AstHindernis
- (id)initWithWorld:(b2World*)worldPtr 
{
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
        
        
        world = worldPtr;
        
        
        b2BodyDef astBodyDef;
        
        astBodyDef.type = b2_staticBody;
        astBodyDef.position.Set(0.0f/PTM_RATIO, 0.0f/PTM_RATIO);
        astBody = world->CreateBody(&astBodyDef);
        b2PolygonShape astShape;
        
        int num = 5;
        b2Vec2* verts = new b2Vec2[num];
        verts[0].Set(-5.7f / PTM_RATIO, 0.0f / PTM_RATIO);
        verts[1].Set(-6.4f / PTM_RATIO, -22.6f / PTM_RATIO);
        verts[2].Set(-3.9f / PTM_RATIO, -26.5f / PTM_RATIO);
        verts[3].Set(-0.7f / PTM_RATIO, -24.0f / PTM_RATIO);
        verts[4].Set(-0.7f / PTM_RATIO, -4.2f / PTM_RATIO);
        astShape.Set(verts, num);
        b2FixtureDef astShapeDef;
        astShapeDef.shape = &astShape;
        astShapeDef.density = 1.0f;
        astShapeDef.friction = 0.8f;
        astShapeDef.restitution = 0.0;
        astBody->CreateFixture(&astShapeDef);
        
        num = 4;
        verts[0].Set(-7.8f / PTM_RATIO, -24.0f / PTM_RATIO);
        verts[1].Set(-70.4f / PTM_RATIO, -66.1f / PTM_RATIO);
        verts[2].Set(-65.1f / PTM_RATIO, -71.1f / PTM_RATIO);
        verts[3].Set(-6.4f / PTM_RATIO, -28.3f / PTM_RATIO);
        astShape.Set(verts, num);
        astBody->CreateFixture(&astShapeDef);
        
        num = 5;
        verts[0].Set(-43.8f / PTM_RATIO, -45.3f / PTM_RATIO);
        verts[1].Set(-54.1f / PTM_RATIO, -46.0f / PTM_RATIO);
        verts[2].Set(-68.9f / PTM_RATIO, -52.3f / PTM_RATIO);
        verts[3].Set(-67.9f / PTM_RATIO, -54.1f / PTM_RATIO);
        verts[4].Set(-44.5f / PTM_RATIO, -48.4f / PTM_RATIO);
        astShape.Set(verts, num);
        astBody->CreateFixture(&astShapeDef);
        
        num = 4;
        verts[0].Set(-25.5f / PTM_RATIO, -38.9f / PTM_RATIO);
        verts[1].Set(-47.7f / PTM_RATIO, -90.5f / PTM_RATIO);
        verts[2].Set(-45.3f / PTM_RATIO, -92.6f / PTM_RATIO);
        verts[3].Set(-19.8f / PTM_RATIO, -40.7f / PTM_RATIO);
        astShape.Set(verts, num);
        astBody->CreateFixture(&astShapeDef);
        
        num = 5;
        verts[0].Set(-81.3f / PTM_RATIO, -76.7f / PTM_RATIO);
        verts[1].Set(-96.9f / PTM_RATIO, -78.1f / PTM_RATIO);
        verts[2].Set(-96.5f / PTM_RATIO, -81.0f / PTM_RATIO);
        verts[3].Set(-73.5f / PTM_RATIO, -79.9f / PTM_RATIO);
        verts[4].Set(-73.5f / PTM_RATIO, -76.0f / PTM_RATIO);
        astShape.Set(verts, num);
        astBody->CreateFixture(&astShapeDef);
        num = 3;
        verts[0].Set(-87.0f / PTM_RATIO, -82.7f / PTM_RATIO);
        verts[1].Set(-110.0f / PTM_RATIO, -96.5f / PTM_RATIO);
        verts[2].Set(-84.1f / PTM_RATIO, -85.6f / PTM_RATIO);
        astShape.Set(verts, num);
        astBody->CreateFixture(&astShapeDef);
    }
    return self;
}
-(void)onEnter
{
   
    [super onEnter];
}

-(void)onExit
{
    [super onExit];
}
- (void)setPosition:(CGPoint)position
{
    [super setPosition:position];

    astBody->SetTransform(b2Vec2(position.x/PTM_RATIO,position.y/PTM_RATIO), astBody->GetAngle());
}

- (void)setRotation:(float)rotation
{
    [super setRotation:rotation];
    astBody->SetTransform(astBody->GetPosition(), CC_DEGREES_TO_RADIANS(-rotation));
}

@end