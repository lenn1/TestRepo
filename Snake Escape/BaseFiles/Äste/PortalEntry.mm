//
//  PortalEntry.m
//  Snake Escape
//
//  Created by Lennart Hansen on 23.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PortalEntry.h"
#import "SimpleAudioEngine.h"

@implementation PortalEntry
-(id)init
{
    if(self = [super init])
    {
        self.scale = 1.1;
        name = @"PortalEntry";
        fangRadius.radius = 30;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"portale.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"portale.png"];
        [self addChild:spriteSheet];
        
        CCTexture2D* texture = [spriteSheet texture];
        [self setTexture:texture];
        [self setTextureRect:CGRectMake(64, 86, 30, 41)];
        [self closePortalAnimation];
    }
    return self;
}
-(void)closePortalAnimation
{
    NSMutableArray *frames = [NSMutableArray array];
    for(int i = 25; i >= 0 ; i--) 
    {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"portal%d-hd.png", i]]];
    }
    CCAnimation *portalclose = [CCAnimation animationWithFrames:frames delay:0.038f];
    CCAction* portalLightsOff = [CCAnimate actionWithAnimation:portalclose restoreOriginalFrame:NO];
    [self runAction:portalLightsOff];
    [[SimpleAudioEngine sharedEngine]playEffect:@"portalopenclose.wav"];

    
}
-(BOOL)astAktiv
{
    return YES;
}
-(BOOL)visitable
{
    return NO;
}
@end
