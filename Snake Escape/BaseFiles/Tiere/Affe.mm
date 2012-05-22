//
//  Affe.m
//  Snake Escape
//
//  Created by Lennart Hansen on 22.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Affe.h"
#define PTM_RATIO 32.0
@implementation Affe
@synthesize anker;
-(id)initWithWorld:(b2World*)worldPtr
{
    self = [super init];
    if (self)
    {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"affe.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"affe.png"];
        [self addChild:spriteSheet];
        
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"affe0"]];
        
        
        world = worldPtr;
        b2BodyDef ankerBodyDef;
        ankerBodyDef.type = b2_staticBody;
        ankerBodyDef.position.Set(0.0/PTM_RATIO, 0.0/PTM_RATIO);
        anker = world->CreateBody(&ankerBodyDef);
        
        
        b2BodyDef affeBodyDef;
        
        affeBodyDef.type = b2_dynamicBody;
        affeBodyDef.position.Set(0.0/PTM_RATIO, 0.0/PTM_RATIO);
        body = world->CreateBody(&affeBodyDef);
        b2PolygonShape shape;
        
        int num = 4;
        b2Vec2* verts = new b2Vec2[num];
            
        verts[0].Set(-18.7f / PTM_RATIO, 25.2f / PTM_RATIO);
        verts[1].Set(-20.2f / PTM_RATIO, -40.0f / PTM_RATIO);
        verts[2].Set(22.7f / PTM_RATIO, -41.2f / PTM_RATIO);
        verts[3].Set(19.2f / PTM_RATIO, 23.0f / PTM_RATIO);
        
        shape.Set(verts, num);
        b2FixtureDef shapedef;
        shapedef.shape = &shape;
        shapedef.density = 1.0f;
        shapedef.friction = 1.0f;
        shapedef.restitution = 0.0;
        body->CreateFixture(&shapedef);
        body->SetUserData(self);
        
        b2RevoluteJointDef jointdef;
        
        b2Vec2 affeHandPosition;
        affeHandPosition = b2Vec2(body->GetLocalCenter().x+20/PTM_RATIO,body->GetLocalCenter().y+45/PTM_RATIO);
        
        jointdef.Initialize(anker, body, affeHandPosition);
        world->CreateJoint(&jointdef);
        
        
    }
    return self;
}

-(void)setAnkerPosition:(CGPoint)position
{
    anker->SetTransform(b2Vec2((position.x-20)/PTM_RATIO, (position.y-30)/PTM_RATIO), anker->GetAngle());
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
