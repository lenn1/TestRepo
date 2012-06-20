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
        [backGroundSprite setBlendFunc:(ccBlendFunc) {GL_ONE,GL_ZERO}];
        [self addChild:backGroundSprite];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"baum.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"baum.png"];
        [self addChild:spriteSheet];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"baumkrone.plist"];
        CCSpriteBatchNode *spriteSheet2 = [CCSpriteBatchNode batchNodeWithFile:@"baumkrone.png"];
        [self addChild:spriteSheet2];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"baumkrone2.plist"];
        CCSpriteBatchNode *spriteSheet3 = [CCSpriteBatchNode batchNodeWithFile:@"baumkrone2.png"];
        [self addChild:spriteSheet3];
        
    }
    return self;
}


@end
