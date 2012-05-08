//
//  Feuer.m
//  Snake Escape
//
//  Created by Lennart Hansen on 08.05.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Feuer.h"
#define PTM_RATIO 32.0
@implementation Feuer
- (id)initWithWorld:(b2World*)worldptr 
{
    self = [super init];
    if (self) 
    {
        //BOX2D
        world = worldptr;
        
        b2BodyDef ballBodyDef;
        ballBodyDef.type = b2_staticBody;
        ballBodyDef.position.Set(self.position.x/PTM_RATIO, self.position.y/PTM_RATIO);
        _body = world->CreateBody(&ballBodyDef);
        _body->SetUserData(self);
        b2CircleShape circle;
        circle.m_radius = 24.5/PTM_RATIO;

        b2FixtureDef ballShapeDef;
        ballShapeDef.shape = &circle;
        ballShapeDef.density = 1.0f;
        ballShapeDef.friction = 0.6f;
        ballShapeDef.restitution = 0.1f;
        ballShapeDef.isSensor = true;
        
        b2MassData* mass = new b2MassData();
        mass->mass = 1.0;
        mass->center = b2Vec2(0.0,0.0);
        _body->SetMassData(mass);
        _body->CreateFixture(&ballShapeDef);
        
        _body->SetUserData(self);
    }
    return self;
}
-(void)setPosition:(CGPoint)position
{
    self.position = position;
    _body->SetTransform(b2Vec2(position.x/PTM_RATIO, position.y/PTM_RATIO), _body->GetAngle());
}
@end
