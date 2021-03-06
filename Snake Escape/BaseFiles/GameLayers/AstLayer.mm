//
//  AstLayer.m
//  Snake Escape
//
//  Created by Lennart Hansen on 19.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AstLayer.h"
#import "MathHelper.h"
@interface AstLayer()
-(void)astCollisionDetection:(CGPoint)position;
-(void)addAst:(AstNormal*)ast;

@end
@implementation AstLayer
@synthesize delegate,aeste,lastAst,world;
-(id)init
{
    if(self = [super init])
    {
        aeste = [[NSMutableSet alloc]init];
    }
    return self;
}

-(void)moveSchlangeTo:(CGPoint)position;
{
    if([delegate respondsToSelector:@selector(moveSchlangeTo:)])
    {
        [delegate moveSchlangeTo:position];
    }
}
-(void)astCollisionDetection:(CGPoint)position
{
    for (AstNormal* ast in aeste)
    {        
        if(![MathHelper IsCGPoint:lastAst.fangRadius.position InRadius:ast.fangRadius.radius OfPoint:position])
        {
            lastAst = nil;

        }
        
        if([MathHelper IsCGPoint:ast.fangRadius.position InRadius:ast.fangRadius.radius OfPoint:position])
        {
            if([delegate respondsToSelector:@selector(collisionDetectedWithAst:)])
            {
                if(ast != lastAst && ast.visitable)
                {
                    [delegate setSchlangeInAir:NO];
                   [delegate collisionDetectedWithAst:ast];
                   lastAst = ast;
                }
            }
        }
    }
}

-(void)PortalErreicht
{
    if([delegate respondsToSelector:@selector(PortalErreicht)])
    {
        [delegate PortalErreicht];
    }
}
-(void)addAeste:(AstNormal*)ast1 , ...
{
    {
        va_list args;
        va_start(args, ast1);
        AstNormal* ast;
        for (ast = ast1; ast != nil;ast = va_arg(args, AstNormal*))
        {
            [self addAst:ast];
            if([ast isKindOfClass:[PortalExit class]])
                portal = (PortalExit*)ast;
        }
        va_end(args);
    }
}
-(void)VerkohlterAstTimelimitIsUp:(VerkohlterAst *)ast
{
    if ([delegate respondsToSelector:@selector(VerkohlterAstTimeIsUp:)]) 
    {
        [delegate VerkohlterAstTimeIsUp:ast];
    }
    
}
-(void)FrameUpdate:(ccTime)delta
{
    [self astCollisionDetection:[delegate getSchlangePosition]];
    [portal PortalCheck:aeste];
}

-(void)addAst:(AstNormal*)ast
{
    [ast setDelegate:self];
    [ast setWorld:world];
    
    b2BodyDef ballBodyDef;
    ballBodyDef.type = b2_staticBody;
    ballBodyDef.position.Set(ast.position.x/PTM_RATIO, ast.position.y/PTM_RATIO);
    b2Body* body = world->CreateBody(&ballBodyDef);
    b2CircleShape circle;
    circle.m_radius = 10.0/PTM_RATIO;
    
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &circle;
    ballShapeDef.density = 1.0f;
    ballShapeDef.friction = 0.6f;
    ballShapeDef.restitution = 0.1f;
    ballShapeDef.userData = ast;
    ballShapeDef.isSensor = true;
    body->CreateFixture(&ballShapeDef);
    
    
    
    [aeste addObject:ast];
    [self addChild:ast];
}


@end
