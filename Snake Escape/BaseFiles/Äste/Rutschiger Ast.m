//
//  Rutschiger Ast.m
//  Snake Escape
//
//  Created by Lennart Hansen on 17.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Rutschiger Ast.h"

@implementation Rutschiger_Ast
-(id)init
{
    if(self = [super init])
    {
        [[CCTextureCache sharedTextureCache] addImage: @"rutschigerAstAktiv.png"];
        visitable = YES;
        self.scale = 1.0;
        name = @"RutschigerAst";
        fangRadius.radius = 30;
        astAktiv = NO;
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: @"rutschigerAst.png"];
        CGRect rect = CGRectZero;
        rect.size = texture.contentSize;
        [self setTexture:texture];
        [self setTextureRect:rect];
        
    }
    return self;
}
-(void)changeImageToActive
{
    [self unschedule:@selector(changeImageToActive)];
    CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: @"rutschigerAstAktiv.png"];
    CGRect rect = CGRectZero;
    rect.size = texture.contentSize;
    [self setTexture:texture];
    [self setTextureRect:rect];
}


@end
