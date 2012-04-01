//
//  World.h
//  Snake Escape
//
//  Created by Lennart Hansen on 01.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box2D.h"
@interface World : NSObject
{
    b2World* world;
}
@end
