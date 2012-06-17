//
//  Affe.h
//  Snake Escape
//
//  Created by Lennart Hansen on 22.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCSprite.h"
#import "Box2D.h"
#import "cocos2d.h"
#import "AstNormal.h"
#import "VerkohlterAst.h"
#import "PortalExit.h"
#import "StachelAst.h"
#import "SchlangeLayer.h"
#import "AstSchalter.h"
#import "AstHindernis.h"
#import "Rutschiger Ast.h"
#import "MathHelper.h"
#import "AstKatapult.h"
#import "AffeDelegate.h"
#import "PortalEntry.h"

@interface Affe : CCSprite
{
    b2World* world;
    b2Body* anker;
    b2Body* body;
    b2Joint* handJoint;
    NSMutableSet* aeste;
    id<AffeDelegate> _delegate;
    AstNormal* lastAst;
    BOOL affetot;
}
-(id)initWithWorld:(b2World*)worldPtr AndDelegate:(id)delegate;
-(void)setAnkerPosition:(CGPoint)position;
-(void)astGetroffen;
@property (assign)AstNormal* lastAst;
@property b2Body* anker;
@property(assign,nonatomic)id<AffeDelegate>_delegate;
@end
