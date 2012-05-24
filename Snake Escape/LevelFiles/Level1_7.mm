//
//  Level1_7.m
//  Snake Escape
//
//  Created by Lennart Hansen on 20.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level1_7.h"
#import "Level1_8.h"

@implementation Level1_7
+(CCScene*)scene
{
    return [[Level1_7 alloc]initWithBackGroundImageFile:@"Level1_4.png" AndLevelWidth:480];
    
}
+(NSArray *)getNeededHighScores
{
    NSNumber* oneStar = [NSNumber numberWithInt:10000];
    NSNumber* twoStars = [NSNumber numberWithInt:15000];
    NSNumber* threeStars = [NSNumber numberWithInt:18000];
    return [NSArray arrayWithObjects:oneStar,twoStars,threeStars, nil];
    
}
-(void)LevelSetup
{
    levelPack = 1;

    
    
    self.levelTimeout = 20;
    
    [schlangeLayer setSchlangePosition:ccp(105, 230)];

    AstNormal* ast1 = [[AstNormal alloc]init];
    ast1.position = ccp(95,150);
    
    AstKatapult* ast2 = [[AstKatapult alloc]init];
    ast2.position = ccp(240.0, 160.0);

    PortalExit* portalExit = [[PortalExit alloc]init];
    portalExit.position = ccp(420,150);

    [astLayer addAeste:ast1,ast2,portalExit,nil];
    
}

-(void)nextLevel
{
    [[CCDirector sharedDirector]replaceScene:[Level1_8 scene]];
}

@end
