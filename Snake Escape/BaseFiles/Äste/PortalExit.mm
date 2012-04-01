//
//  PortalExit.m
//  Snake Escape
//
//  Created by Lennart Hansen on 22.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PortalExit.h"
#import "SimpleAudioEngine.h"

@implementation PortalExit
@synthesize delegate;
#define portalActive YES
#define portalInactive NO
-(id)init
{
    if(self = [super init])
    {
        visitable = NO;
        self.scale = 1.1;
        name = @"PortalExit";
        fangRadius.radius = 30;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"portale.plist"];

        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"portale.png"];
        [self addChild:spriteSheet];

        CCTexture2D* texture = [spriteSheet texture];
        [self setTexture:texture];
        [self setTextureRect:CGRectMake(0, 0, 30, 42)];
        
        }
    return self;
}



-(BOOL)astAktiv
{
    return YES;
}
-(void)AstWurdeBesucht
{
    if([delegate respondsToSelector:@selector(PortalErreicht)])
    {
        [delegate PortalErreicht];
    }
    
}
-(void)openPortalAnimation
{
    [[SimpleAudioEngine sharedEngine]playEffect:@"portalopen.wav"];
    NSMutableArray *frames = [NSMutableArray array];
    for(int i = 0; i <= 25; ++i) 
    {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"portal%d-hd.png", i]]];
    }
    
    CCAnimation *portalopen = [CCAnimation animationWithFrames:frames delay:0.038f];
    
    portalLightsOn = [CCAnimate actionWithAnimation:portalopen restoreOriginalFrame:NO];
    [self runAction:portalLightsOn];

    
    
    
}

-(void)PortalCheck:(NSSet*)aeste
{
    if(visitable == portalInactive)
    {
        int astCount = 0;
        for(AstNormal* ast in aeste)
        {
            if([ast astAktiv])
            {
                astCount++;
            }
        
        }
        if(astCount == [aeste count])
        {
            visitable = YES;
            [self openPortalAnimation];
        }
    }
}

@end
