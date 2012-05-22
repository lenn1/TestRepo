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
@interface Affe : CCSprite
{
    b2World* world;
    b2Body* anker;
    b2Body* body;
}
-(id)initWithWorld:(b2World*)worldPtr;
-(void)setAnkerPosition:(CGPoint)position;

@property b2Body* anker;

@end
