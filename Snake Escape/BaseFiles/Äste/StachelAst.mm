//
//  StachelAst.m
//  Snake Escape
//
//  Created by Lennart Hansen on 23.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StachelAst.h"


@implementation StachelAst
@synthesize stachelAusgefahren;
-(id)init
{
    if(self = [super init])
    {
        stachelAusgefahren = YES;
        visitable = YES;
        visibleOnScreen = YES;

        self.scale = 1.0;
        name = @"StachelAst";
        fangRadius.radius = 30;
        astAktiv = NO;
        
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: @"StachelAst.png"];
        CGRect rect = CGRectZero;
        rect.size = texture.contentSize;
        [self setTexture:texture];
        [self setTextureRect:rect];
        [self schedule:@selector(changeMode) interval:2];
    }
    return self;
}
-(void)AstWurdeBesucht
{
    if(stachelAusgefahren)
    {
        astAktiv = NO;
    }
    else
    {
        [self schedule:@selector(changeImageToActive) interval:0.1];
        astAktiv = YES;
    }

}

-(void)onExit
{
    visibleOnScreen = NO;
    [super onExit];
}
-(void)changeMode
{
    [self unschedule:@selector(changeMode)];
    if(astAktiv == NO && visibleOnScreen)
    {
        [self schedule:@selector(changeMode) interval:2];
    }
    if(astAktiv == NO)
        if(stachelAusgefahren)
        {
            CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: @"AstNormalInaktiv.png"];
            CGRect rect = CGRectZero;
            rect.size = texture.contentSize;
            [self setTexture:texture];
            [self setTextureRect:rect];
            stachelAusgefahren = NO;

        
        }
        else
        {
            CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: @"StachelAst.png"];
            CGRect rect = CGRectZero;
            rect.size = texture.contentSize;
            [self setTexture:texture];
            [self setTextureRect:rect];
            stachelAusgefahren = YES;
        }

}
@end

