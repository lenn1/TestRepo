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
@synthesize delegate;
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
                   [delegate collisionDetectedWithAst:ast];
                   lastAst = ast;
                    [delegate setSchlangeInAir:NO];
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
    [aeste addObject:ast];
    [self addChild:ast];
}


@end
