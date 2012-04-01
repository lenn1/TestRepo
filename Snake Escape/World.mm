//
//  World.m
//  Snake Escape
//
//  Created by Lennart Hansen on 01.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "World.h"

@implementation World
+(b2World*)sharedWorld
{
    if(world == nil)
    {
        [[self alloc]init];
    }
}
@end
