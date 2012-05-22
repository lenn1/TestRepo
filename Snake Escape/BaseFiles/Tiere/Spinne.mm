//
//  Spinne.m
//  Snake Escape
//
//  Created by Lennart Hansen on 21.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Spinne.h"
#define PTM_RATIO 32.0
@implementation Spinne
@synthesize joint;
-(id)initWithWorld:(b2World*)world
{
    self = [super init];
    if (self) 
    {
        worldPtr = world;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"spinne.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"spinne.png"];
        [self addChild:spriteSheet];
        
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"spinne0"]];
        
        b2BodyDef ankerBodyDef;
        ankerBodyDef.type = b2_staticBody;
        ankerBodyDef.position.Set(0.0/PTM_RATIO, 150.0/PTM_RATIO);
        anker = world->CreateBody(&ankerBodyDef);

        b2Body* gelenkBody;
        b2BodyDef gelenkBodyDef;
        gelenkBodyDef.type = b2_dynamicBody;
        gelenkBodyDef.position.Set(anker->GetPosition().x,anker->GetPosition().y);
        gelenkBody = world->CreateBody(&gelenkBodyDef);
        
        b2BodyDef spinneBodyDef;
        
        spinneBodyDef.type = b2_dynamicBody;
        spinneBodyDef.position.Set(0.0/PTM_RATIO, 0.0/PTM_RATIO);
        body = world->CreateBody(&spinneBodyDef);
        b2PolygonShape shape;
        
        int num = 7;
        b2Vec2* verts = new b2Vec2[num];
        
        verts[0].Set(-1.6f / PTM_RATIO, 18.5f / PTM_RATIO);
        verts[1].Set(-12.2f / PTM_RATIO, 11.9f / PTM_RATIO);
        verts[2].Set(-13.6f / PTM_RATIO, 2.0f / PTM_RATIO);
        verts[3].Set(-5.1f / PTM_RATIO, -23.1f / PTM_RATIO);
        verts[4].Set(4.6f / PTM_RATIO, -22.2f / PTM_RATIO);
        verts[5].Set(13.3f / PTM_RATIO, 1.1f / PTM_RATIO);
        verts[6].Set(6.0f / PTM_RATIO, 18.3f / PTM_RATIO);        

        
        shape.Set(verts, num);
        b2FixtureDef shapedef;
        shapedef.shape = &shape;
        shapedef.density = 1.0f;
        shapedef.friction = 1.0f;
        shapedef.restitution = 0.0;
        body->CreateFixture(&shapedef);
        body->SetUserData(self);

        
        b2RevoluteJointDef gelenkJointDef;
        gelenkJointDef.Initialize(anker, gelenkBody, anker->GetLocalCenter());
        worldPtr->CreateJoint(&gelenkJointDef);
        
        
        b2PrismaticJointDef jointDef;
        b2Vec2 worldAxis(0.0, 1.0f);
        jointDef.Initialize(gelenkBody, body, gelenkBody->GetWorldCenter(), worldAxis);
        
        jointDef.lowerTranslation = -150.0f/PTM_RATIO;
        
        jointDef.upperTranslation = -50.0/PTM_RATIO;
        
        jointDef.enableLimit = true;
        
        jointDef.maxMotorForce = 500.0/PTM_RATIO;
        
        jointDef.motorSpeed = 22.0/PTM_RATIO;
        
        jointDef.enableMotor = true;

        joint = (b2PrismaticJoint*)worldPtr->CreateJoint(&jointDef);
        [self schedule:@selector(toggleMotor) interval:2+(arc4random() % 3)];
        
        NSMutableArray *frames = [NSMutableArray array];
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"spinne0"]];
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"spinne2"]];
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"spinne1"]];
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"spinne3"]];
        
        CCAnimation *krabbeln = [CCAnimation animationWithFrames:frames delay:0.3];
        CCActionInterval* krabbelnAnimation = [CCAnimate actionWithAnimation:krabbeln restoreOriginalFrame:YES];
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:krabbelnAnimation];
        [self runAction:repeat];
        
        faden = [CCSprite spriteWithFile:@"spinnenfaden.png"];
        [self addChild:faden];
        faden.position = ccp(15.0,274.5);
        
        
        b2Vec2* fadenverts = new b2Vec2[4];
        
        fadenverts[0].Set(-1.0f / PTM_RATIO, 0.0f / PTM_RATIO);
        fadenverts[1].Set(1.0f / PTM_RATIO, 0.0f / PTM_RATIO);
        fadenverts[2].Set(1.0f / PTM_RATIO, 320.0f / PTM_RATIO);
        fadenverts[3].Set(-1.0f / PTM_RATIO, 320.0f / PTM_RATIO);
        
        b2PolygonShape fadenShape;
        fadenShape.Set(fadenverts,4);
        b2FixtureDef fadenShapeDef;
        fadenShapeDef.shape = &fadenShape;
        fadenShapeDef.isSensor = true;
        fadenShapeDef.userData = self;
        body->CreateFixture(&fadenShapeDef);
        destroyFlag = NO;
        
}
    return self;
}
-(void)fadenGetroffen
{
    destroyFlag = YES;
}
-(void)toggleMotor
{   
    [self unschedule:@selector(toggleMotor)];
    if(joint->GetMaxMotorForce()>330.0/PTM_RATIO)
    {
        [self stopAllActions];
        joint->SetMaxMotorForce(330.0/PTM_RATIO);
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"spinne1"]];

    }
    else 
    {
        joint->SetMaxMotorForce(500.0/PTM_RATIO);

        NSMutableArray *frames = [NSMutableArray array];
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"spinne0"]];
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"spinne2"]];
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"spinne1"]];
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"spinne3"]];
        
        CCAnimation *krabbeln = [CCAnimation animationWithFrames:frames delay:0.3];
        CCActionInterval* krabbelnAnimation = [CCAnimate actionWithAnimation:krabbeln restoreOriginalFrame:YES];
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:krabbelnAnimation];
        [self runAction:repeat];
    }
    
    }
-(void)FrameUpdate:(ccTime)delta
{
    if(body)
    {
        if(sqrt(pow(body->GetLinearVelocity().y,2)) < 1.0/PTM_RATIO)
            [self toggleMotor];


        if(destroyFlag && joint)
        {
            worldPtr->DestroyJoint(joint);
            joint = NULL;
            [self removeChild:faden cleanup:YES];
            destroyFlag = NO;
        }
        if(body->GetPosition().y < -500/PTM_RATIO)
        {
            worldPtr->DestroyBody(body);
            body = NULL;
            NSLog(@"spinne destroyed");
        
        }
    }
}

-(void)setAnkerPosition:(CGPoint)position
{
    anker->SetTransform(b2Vec2(position.x/PTM_RATIO, 480.0/PTM_RATIO), anker->GetAngle());
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
