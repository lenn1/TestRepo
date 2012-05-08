//
//  Feuer.h
//  Snake Escape
//
//  Created by Lennart Hansen on 08.05.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
@interface Feuer : CCSprite 
{
    b2World* world;
    b2Body* _body;
}
- (id)initWithWorld:(b2World*)worldptr;
@end
