//
//  AstLayer.h
//  Snake Escape
//
//  Created by Lennart Hansen on 19.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AstNormal.h"
#import "VerkohlterAst.h"
#import "PortalExit.h"
#import "StachelAst.h"
#import "SchlangeLayer.h"
#import "AstSchalter.h"
#import "AstHindernis.h"
#import "Rutschiger Ast.h"
#import "Box2D.h"
@protocol AstLayerDelegate <NSObject>
@required
-(CGPoint)getSchlangePosition;
-(void)setSchlangeInAir:(BOOL)schlangeInAir;
@optional
-(void)PortalErreicht;
-(void)VerkohlterAstTimeIsUp:(VerkohlterAst*)ast;
-(void)collisionDetectedWithAst:(AstNormal*)ast;
-(void)StachelModeDidChange:(StachelAst *)ast;
-(void)moveSchlangeTo:(CGPoint)position;
@end


@interface AstLayer : CCLayer <VerkohlterAstDelegate,PortalExitDelegate>
{
    NSMutableSet* aeste;
    id<AstLayerDelegate> delegate;
    AstNormal* lastAst;
    PortalExit* portal;
    b2World* world;
}
@property(readwrite,assign)id<AstLayerDelegate>delegate;
@property(assign,readonly)NSMutableSet* aeste;
@property(readwrite)b2World* world;
@property (readonly)AstNormal*lastAst;
-(void)FrameUpdate:(ccTime)delta;
-(void)addAeste:(AstNormal*)ast1 , ...;

@end
