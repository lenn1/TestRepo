//
//  Stein.h
//  Snake Escape
//
//  Created by Lennart Hansen on 23.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"
#import "Box2D.h"
@interface Stein : CCSprite
{
    b2World* worldPtr;
    b2Body* body;
}
-(id)initWithWorld:(b2World*)world AndStein:(int)steinnr;
@end
