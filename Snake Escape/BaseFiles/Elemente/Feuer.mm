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
@synthesize setSchlangeNormalAfterContact;
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

        b2PolygonShape feuerShape;
        feuerShape.SetAsBox(5.0/PTM_RATIO, 20.0/PTM_RATIO);
        b2FixtureDef ballShapeDef;
        ballShapeDef.shape = &feuerShape;
        ballShapeDef.density = 1.0f;
        ballShapeDef.friction = 0.6f;
        ballShapeDef.restitution = 0.1f;
        ballShapeDef.isSensor = true;
        ballShapeDef.userData = self;
        
        
        b2MassData* mass = new b2MassData();
        mass->mass = 1.0;
        mass->center = b2Vec2(0.0,0.0);
        _body->SetMassData(mass);
        _body->CreateFixture(&ballShapeDef);
        
        CCParticleSystemQuad* staub = [CCParticleSystemQuad particleWithFile:@"fire.plist"];
        staub.position = self.position;
        staub.positionType = kCCPositionTypeRelative;
        [self addChild:staub];
        
        setSchlangeNormalAfterContact = NO;
        
    }
    return self;
}
-(void)setPosition:(CGPoint)position
{
    [super setPosition:position];
    _body->SetTransform(b2Vec2(position.x/PTM_RATIO, (position.y+15.0)/PTM_RATIO), _body->GetAngle());
}
@end
