//
//  Affe.m
//  Snake Escape
//
//  Created by Lennart Hansen on 22.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Affe.h"
@implementation Affe
@synthesize anker,_delegate,lastAst;
-(id)initWithWorld:(b2World*)worldPtr AndDelegate:(id)delegate
{
    self = [super init];
    if (self)
    {
        affetot = NO;
        
        // DELEGATE
        self._delegate = delegate;
        aeste = [delegate getAeste];

        // GRAFIK
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"affe.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"affe.png"];
        [self addChild:spriteSheet];
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"affe0"]];
        
        
        //---------- BOX2D ---------
        
        
        world = worldPtr;
        
        // ANKER
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
        shapedef.userData = self;
        body->CreateFixture(&shapedef);
        body->SetUserData(self);
        
        
        
        // JOINT 
        
        b2RevoluteJointDef jointdef;
        
        b2Vec2 affeHandPosition;
        affeHandPosition = b2Vec2(body->GetWorldCenter().x+20.0/PTM_RATIO,body->GetWorldCenter().y+45.0/PTM_RATIO);
        
        jointdef.Initialize(anker, body, affeHandPosition);
        handJoint = world->CreateJoint(&jointdef);
        
        
        //---------- BOX2D --------- 
        
        
        
        [self schedule:@selector(jump) interval:4];
        
        
    }
    return self;
}

b2Vec2 rad2vec(float r) 
{
    return b2Vec2(cos(r), sin(r));
}

-(void)jump
{
    lastAst.visitable = YES;
    NSMutableArray* NormaleAeste = [[NSMutableArray alloc]init];
    for(AstNormal* ast in aeste)
    {
        if([ast.name isEqualToString:@"AstNormal"] && ast!=lastAst)
        {
            [NormaleAeste addObject:ast];
        }
    }
    int r = arc4random() % [NormaleAeste count];
    AstNormal* ast;
    ast = [NormaleAeste objectAtIndex:r];
    CGPoint entfernung = [MathHelper getVektorFromPoint:lastAst.position toPoint:ast.position];
    float alpha = atan((4*entfernung.y)/(2*entfernung.x));
    b2Vec2 velocity = rad2vec(alpha);
    alpha = fabsf(alpha);
    float speed = sqrt(((fabsf(entfernung.x)/PTM_RATIO)*-world->GetGravity().y)/sin(2*alpha));
    speed *= 1.5;
    NSLog(@"angle: %f speed: %f",CC_RADIANS_TO_DEGREES(alpha),speed);

    
    if(entfernung.x >= 0.0 && entfernung.y >= 0.0)
    {
        velocity = b2Vec2(velocity.x*speed,velocity.y*speed);
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"affe2"]];

    }
    else if(entfernung.x <= 0.0 && entfernung.y >= 0.0)
    {
        velocity = b2Vec2(velocity.x*-speed,-velocity.y*speed);
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"affe3"]];

    }
    else if(entfernung.x <= 0.0 && entfernung.y <= 0.0)
    {
        velocity = b2Vec2(-speed,0.0);
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"affe3"]];

    }
    else if(entfernung.x >= 0.0 && entfernung.y <= 0.0)
    {
        velocity = b2Vec2(speed,0.0);
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"affe2"]];

    }
        
    NSLog(@"vel: %f,%f",velocity.x,velocity.y);
        
    [self setRotation:0.0];
    world->DestroyJoint(handJoint);
    handJoint = NULL;
    body->SetLinearVelocity(velocity);

    body->SetAngularVelocity(0.0);
    body->SetTransform(body->GetPosition(), 0.0);
    
    
    
}
-(void)astGetroffen
{
    NSLog(@"hit");
}
-(void)FrameUpdate:(ccTime)delta
{
    if(!affetot)
    for (AstNormal*ast in aeste)
    {
        if([MathHelper IsCGPoint:ccp(body->GetPosition().x*PTM_RATIO,body->GetPosition().y*PTM_RATIO+40) InRadius:45.0 OfPoint:ast.position])
        {
            if(![ast isKindOfClass:[PortalEntry class]] &&
               ![ast isKindOfClass:[PortalExit class]] &&
               ![ast isKindOfClass:[StachelAst class]] &&
               ![ast isKindOfClass:[Rutschiger_Ast class]] &&
               ![ast isKindOfClass:[VerkohlterAst class]] &&
               ![ast isKindOfClass:[AstKatapult class]] &&
               ast != lastAst)
            {
                [self setAnkerPosition:ast.position];
                [self setPosition:ccp(ast.position.x-20.0,ast.position.y-45.0)];
                [self setRotation:0.0];
                b2RevoluteJointDef jointdef;
                
                b2Vec2 affeHandPosition;
                affeHandPosition = b2Vec2(body->GetWorldCenter().x+20.0/PTM_RATIO,body->GetWorldCenter().y+45.0/PTM_RATIO);
                
                jointdef.Initialize(anker, body, affeHandPosition);
                handJoint = world->CreateJoint(&jointdef);
                
                lastAst = ast;
                [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"affe0"]];
                lastAst.visitable = NO;
                
            }
        }
    }

    
    if(self.position.y < -200.0)
    {
        if(handJoint)
        world->DestroyJoint(handJoint);
        if(anker)
        world->DestroyBody(anker);
        if(body)
        world->DestroyBody(body);
        handJoint = NULL;
        body = NULL;
        anker = NULL;
        affetot = YES;
        [self unscheduleAllSelectors];
    }
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
