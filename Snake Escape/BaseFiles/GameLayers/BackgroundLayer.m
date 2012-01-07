//
//  BackgroundLayer.m
//  Snake Escape
//
//  Created by Lennart Hansen on 18.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BackgroundLayer.h"

@implementation BackgroundLayer
-(id)initWithLevelWidth:(CGFloat)Width AndHeight:(CGFloat)Height AndImageFile:(NSString*)imageFile
{
    if(self = [super init])
    {
        levelWidth = Width;
        CCSprite* backGroundSprite = [CCSprite spriteWithFile:imageFile];
        backGroundSprite.position = ccp(levelWidth/2, Height/2);
        [self addChild:backGroundSprite];
    }
    return self;
}


@end
