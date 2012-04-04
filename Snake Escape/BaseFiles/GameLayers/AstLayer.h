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
}
@property(readwrite,assign)id<AstLayerDelegate>delegate;
-(void)FrameUpdate:(ccTime)delta;
-(void)addAeste:(AstNormal*)ast1 , ...;

@end
