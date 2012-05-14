//
//  Wasserfall.m
//  Snake Escape
//
//  Created by Lennart Hansen on 14.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Wasserfall.h"
#define PTM_RATIO 32.0
@implementation Wasserfall
- (id)initWithWorld:(b2World*)worldptr 
{
    self = [super init];
    if (self) 
    {
        //BOX2D
        world = worldptr;
        
        b2BodyDef wasserfallBodyDef;
        wasserfallBodyDef.type = b2_staticBody;
        wasserfallBodyDef.position.Set(self.position.x/PTM_RATIO, self.position.y/PTM_RATIO);
        _body = world->CreateBody(&wasserfallBodyDef);
        _body->SetUserData(self);
        
        b2PolygonShape wasserShape;
        wasserShape.SetAsBox(5.0/PTM_RATIO, 160.0/PTM_RATIO);
        b2FixtureDef wasserShapeDef;
        wasserShapeDef.shape = &wasserShape;
        wasserShapeDef.density = 1.0f;
        wasserShapeDef.friction = 0.6f;
        wasserShapeDef.restitution = 0.1f;
        wasserShapeDef.isSensor = true;
        wasserShapeDef.userData = self;
        
        
        b2MassData* mass = new b2MassData();
        mass->mass = 1.0;
        mass->center = b2Vec2(0.0,0.0);
        _body->SetMassData(mass);
        _body->CreateFixture(&wasserShapeDef);
        
        //Particle
        CCParticleSystemQuad* wasserfall = [CCParticleSystemQuad particleWithFile:@"Wasserfall.plist"];
        wasserfall.position = self.position;
        wasserfall.positionType = kCCPositionTypeRelative;
        [self addChild:wasserfall];
        
        
    }
    return self;
}
-(void)setPosition:(CGPoint)position
{
    [super setPosition:position];
    _body->SetTransform(b2Vec2(position.x/PTM_RATIO, (position.y-160.0)/PTM_RATIO), _body->GetAngle());
}

@end
