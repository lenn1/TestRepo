//
//  Wasserfall.h
//  Snake Escape
//
//  Created by Lennart Hansen on 14.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"
#import "Box2D.h"
@interface Wasserfall : CCNode
{
    b2World* world;
    b2Body* _body;
}
- (id)initWithWorld:(b2World*)worldptr;

@end
