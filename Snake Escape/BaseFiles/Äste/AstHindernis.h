//
//  AstHindernis.h
//  Snake Escape
//
//  Created by Lennart Hansen on 03.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AstNormal.h"
#import "Box2D.h"
#define PTM_RATIO 32
@interface AstHindernis : AstNormal 
{
    b2World* world;
    b2Body* astBody;
}
- (id)initWithWorld:(b2World*)worldPtr;
@end
