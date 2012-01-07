//
//  Level2.m
//  Snake Escape
//
//  Created by Lennart Hansen on 22.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level1_4.h"
#import "Level1_5.h"

@implementation Level1_4
+(CCScene*)scene
{
    return [[Level1_4 alloc]initWithBackGroundImageFile:@"Level1_4.png" AndLevelWidth:480];
    
}
+(NSArray *)getNeededHighScores
{
    NSNumber* oneStar = [NSNumber numberWithInt:5000];
    NSNumber* twoStars = [NSNumber numberWithInt:10000];
    NSNumber* threeStars = [NSNumber numberWithInt:16000];
    return [NSArray arrayWithObjects:oneStar,twoStars,threeStars, nil];
    
}
-(void)LevelSetup
{
    levelPack = 1;
    
    CCSprite* erklaerung = [CCSprite spriteWithFile:@"AstHindernisSchalter-Erklaerung.png"];
    erklaerung.position = ccp(deviceWidth/2, deviceHeight/2-30);
    [backgroundLayer addChild:erklaerung];

    self.levelTimeout = 20;
    
    [schlangeLayer setSchlangePosition:ccp(105, 230)];

    AstNormal* ast1 = [[AstNormal alloc]init];
    ast1.position = ccp(105,150);

    AstHindernis* astHindernis = [[AstHindernis alloc]init];
    astHindernis.position = ccp(400,240);
    
    astHindernis.rotation = -20;  
    
    AstSchalter* ast2 = [[AstSchalter alloc]initWithTarget:astHindernis AndRotation:70 AndPosition:ccp(0,0)];
    ast2.position = ccp(226,120);
    
    PortalExit* portalExit = [[PortalExit alloc]init];
    portalExit.position = ccp(420,150);

    [astLayer addAeste:ast1,ast2,portalExit,astHindernis,nil];
    
}

-(void)nextLevel
{
    [[CCDirector sharedDirector]replaceScene:[Level1_5 scene]];
}

@end

