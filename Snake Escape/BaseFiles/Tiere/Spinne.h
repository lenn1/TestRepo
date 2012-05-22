//
//  Spinne.h
//  Snake Escape
//
//  Created by Lennart Hansen on 21.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"
#import "Box2D.h"

@interface Spinne : CCSprite
{
    b2World* worldPtr;
    b2Body* body;
    b2Body* anker;
    b2PrismaticJoint* joint;
    CCSprite* faden;
    BOOL destroyFlag;
}
-(id)initWithWorld:(b2World*)world;
-(void)setAnkerPosition:(CGPoint)position;
-(void)FrameUpdate:(ccTime)delta;
-(void)fadenGetroffen;
@property b2PrismaticJoint* joint;

@end
