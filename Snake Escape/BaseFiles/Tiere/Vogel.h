//
//  Vogel.h
//  Snake Escape
//
//  Created by Lennart Hansen on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"
#import "Box2D.h"

typedef struct 
{
    CGFloat radius;
    CGPoint position;
    
} FangRadius;

@interface Vogel : CCSprite
{
    NSString *name;
    FangRadius fangRadius;
    b2World* world;
    CGFloat maxLeft;
    CGFloat maxRight;
    BOOL directionRight;
}
@property CGFloat maxRight;
@property CGFloat maxLeft;
@property BOOL directionRight;

-(void)FrameUpdate:(ccTime)delta;
@end
