//
//  Level1_2.m
//  Snake Escape
//
//  Created by Lennart Hansen on 19.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level1_2.h"
#import "Level1_3.h"

@implementation Level1_2
+(CCScene*)scene
{
    return [[Level1_2 alloc]initWithBackGroundImageFile:@"Level1_2.png" AndLevelWidth:480];
    
}
+(NSArray *)getNeededHighScores
{
    NSNumber* oneStar = [NSNumber numberWithInt:5000];
    NSNumber* twoStars = [NSNumber numberWithInt:10000];
    NSNumber* threeStars = [NSNumber numberWithInt:12000];
    return [NSArray arrayWithObjects:oneStar,twoStars,threeStars, nil];
    
}
-(void)LevelSetup
{
    levelPack = 1;
    
    self.levelTimeout = 15;
    [schlangeLayer setSchlangePosition:ccp(80, 250)];
    
    
    AstNormal* ast1 = [[AstNormal alloc]init];
    ast1.position = ccp(80,100);
    
    AstNormal* ast2 = [[AstNormal alloc]init];
    ast2.position = ccp(200,150);
    
    Stein* stein1 = [[Stein alloc]initWithWorld:world AndStein:1];
    [self addChild:stein1];
    stein1.position = ccp(200,20);
    
    
    AstNormal* ast3 = [[AstNormal alloc]init];
    ast3.position = ccp(325,100);
    
    PortalExit* portalExit = [[PortalExit alloc]init];
    portalExit.position = ccp(450,160);
    
    [astLayer addAeste:ast1,ast2,ast3,portalExit,nil];

    
}
-(void)nextLevel
{
    [[CCDirector sharedDirector]replaceScene:[Level1_3 scene]];
}

@end
