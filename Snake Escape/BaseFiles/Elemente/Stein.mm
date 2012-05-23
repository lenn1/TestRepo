//
//  Stein.m
//  Snake Escape
//
//  Created by Lennart Hansen on 23.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Stein.h"
#define PTM_RATIO 32.0
@implementation Stein

-(id)initWithWorld:(b2World*)world AndStein:(int)steinnr
{
    self = [super init];
    if (self) 
    {
        CCTexture2D *texture;

        worldPtr = world; 
        b2Vec2* verts;
        int num;
        
        switch (steinnr) 
        {
            case 1:
                // STEIN1
                texture = [[CCTextureCache sharedTextureCache] addImage: @"stein1.png"];

                
                num = 8;
                verts = new b2Vec2[num];
                verts[0].Set(-54.0f / PTM_RATIO, 44.0f / PTM_RATIO);
                verts[1].Set(-62.0f / PTM_RATIO, 15.0f / PTM_RATIO);
                verts[2].Set(-65.0f / PTM_RATIO, -19.0f / PTM_RATIO);
                verts[3].Set(-51.0f / PTM_RATIO, -37.0f / PTM_RATIO);
                verts[4].Set(1.0f / PTM_RATIO, -48.0f / PTM_RATIO);
                verts[5].Set(54.0f / PTM_RATIO, -31.0f / PTM_RATIO);
                verts[6].Set(64.0f / PTM_RATIO, 21.0f / PTM_RATIO);
                verts[7].Set(-20.0f / PTM_RATIO, 49.0f / PTM_RATIO);
                break;
                
            case 2:
                // STEIN2
                texture = [[CCTextureCache sharedTextureCache] addImage: @"stein2.png"];

                num = 8;
                verts = new b2Vec2[num];
                verts[0].Set(-20.0f / PTM_RATIO, 57.5f / PTM_RATIO);
                verts[1].Set(-46.0f / PTM_RATIO, 16.5f / PTM_RATIO);
                verts[2].Set(-46.0f / PTM_RATIO, -31.5f / PTM_RATIO);
                verts[3].Set(-17.0f / PTM_RATIO, -55.5f / PTM_RATIO);
                verts[4].Set(10.0f / PTM_RATIO, -56.5f / PTM_RATIO);
                verts[5].Set(41.0f / PTM_RATIO, -41.5f / PTM_RATIO);
                verts[6].Set(46.0f / PTM_RATIO, 12.5f / PTM_RATIO);
                verts[7].Set(29.0f / PTM_RATIO, 46.5f / PTM_RATIO);   
                break;
                
            default:
                
                // STEIN1
                texture = [[CCTextureCache sharedTextureCache] addImage: @"stein1.png"];
                
                
                num = 8;
                verts = new b2Vec2[num];
                verts[0].Set(-54.0f / PTM_RATIO, 44.0f / PTM_RATIO);
                verts[1].Set(-62.0f / PTM_RATIO, 15.0f / PTM_RATIO);
                verts[2].Set(-65.0f / PTM_RATIO, -19.0f / PTM_RATIO);
                verts[3].Set(-51.0f / PTM_RATIO, -37.0f / PTM_RATIO);
                verts[4].Set(1.0f / PTM_RATIO, -48.0f / PTM_RATIO);
                verts[5].Set(54.0f / PTM_RATIO, -31.0f / PTM_RATIO);
                verts[6].Set(64.0f / PTM_RATIO, 21.0f / PTM_RATIO);
                verts[7].Set(-20.0f / PTM_RATIO, 49.0f / PTM_RATIO);
                break;

                
                break;
        }
        b2BodyDef steinBodyDef;
        
        steinBodyDef.type = b2_staticBody;
        steinBodyDef.position.Set(0.0/PTM_RATIO, 0.0/PTM_RATIO);
        body = worldPtr->CreateBody(&steinBodyDef);
        b2PolygonShape shape;
        
        shape.Set(verts, num);
        b2FixtureDef shapedef;
        shapedef.shape = &shape;
        shapedef.density = 1.0f;
        shapedef.friction = 1.0f;
        shapedef.restitution = 0.0;
        body->CreateFixture(&shapedef);
        body->SetUserData(self);

        CGRect rect = CGRectZero;
        rect.size = texture.contentSize;
        [self setTexture:texture];
        [self setTextureRect:rect];
        
        
        
    }
    return self;
}

- (void)setPosition:(CGPoint)position
{
    [super setPosition:position];
    
    body->SetTransform(b2Vec2(position.x/PTM_RATIO,position.y/PTM_RATIO), body->GetAngle());
    
}

- (void)setRotation:(float)rotation
{
    [super setRotation:rotation];
    body->SetTransform(body->GetPosition(), CC_DEGREES_TO_RADIANS(-rotation));
}


@end
