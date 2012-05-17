//
//  AstNormal.m
//  Snake Escape
//
//  Created by Lennart Hansen on 14.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AstNormal.h"

@implementation AstNormal
@synthesize fangRadius,astAktiv,name,visitable;

-(id)init
{
    if(self = [super init])
    {
        [[CCTextureCache sharedTextureCache] addImage: @"AstNormalAktiv.png"];
        visitable = YES;
        self.scale = 1.0;
        name = @"AstNormal";
        fangRadius.radius = 30;
        astAktiv = NO;
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: @"AstNormalInaktiv.png"];
        CGRect rect = CGRectZero;
        rect.size = texture.contentSize;
        [self setTexture:texture];
        [self setTextureRect:rect];
        
    }
    return self;
}
-(void)setDelegate:(id)delegate
{
    // NOTHING
}
-(void)setPosition:(CGPoint)position
{    
    [super setPosition:position];
    position_ = position;
    fangRadius.position = self.position;
}
-(void)AstWurdeBesucht
{
        [self schedule:@selector(changeImageToActive) interval:0.1];
        astAktiv = YES;
}
-(void)changeImageToActive
{
    [self unschedule:@selector(changeImageToActive)];
    CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: @"AstNormalAktiv.png"];
    CGRect rect = CGRectZero;
    rect.size = texture.contentSize;
    [self setTexture:texture];
    [self setTextureRect:rect];
}
@end
