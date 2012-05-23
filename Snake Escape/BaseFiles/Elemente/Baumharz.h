//
//  Baumharz.h
//  Snake Escape
//
//  Created by Lennart Hansen on 18.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "cocos2d.h"
#import "CCSprite.h"
#import "Box2D.h"
@interface Baumharz : CCSprite
{
    b2Body* body;
    BOOL toDestroy;
}
- (id)initWithWorld:(b2World*)worldPtr;
-(void)toDestroy;
@end
