//
//  Level1_3.m
//  Snake Escape
//
//  Created by Lennart Hansen on 19.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level1_3.h"
#import "Level1_4.h"

@implementation Level1_3
+(CCScene*)scene
{
    return [[Level1_3 alloc]initWithBackGroundImageFile:@"Level1_3.png" AndLevelWidth:480];
    
}
+(NSArray *)getNeededHighScores
{
    NSNumber* oneStar = [NSNumber numberWithInt:5000];
    NSNumber* twoStars = [NSNumber numberWithInt:10000];
    NSNumber* threeStars = [NSNumber numberWithInt:13000];
    return [NSArray arrayWithObjects:oneStar,twoStars,threeStars, nil];
    
}
-(void)LevelSetup
{
    levelPack = 1;
        
    
    CCSprite* erklaerung = [CCSprite spriteWithFile:@"VerkohlterAstErklaerung.png"];
    erklaerung.position = ccp(deviceWidth/2, deviceHeight/2-30);
    [backgroundLayer addChild:erklaerung];
    
    self.levelTimeout = 15;
    
    [schlangeLayer setSchlangePosition:ccp(90, 230)];
    
    AstNormal* ast1 = [[AstNormal alloc]init];
    ast1.position = ccp(90,120);
    
    VerkohlterAst* ast2 = [[VerkohlterAst alloc]init];
    ast2.position = ccp(230,180);
    
    PortalExit* portalExit = [[PortalExit alloc]init];
    portalExit.position = ccp(415,135);
    
    [astLayer addAeste:ast1,ast2,portalExit,nil];
    
    
    
    
    Affe* affe1 = [[Affe alloc]initWithWorld:world];
    [self addChild:affe1];
    [affe1 setAnkerPosition:ast2.position];
    
}
-(void)nextLevel
{
    [[CCDirector sharedDirector]replaceScene:[Level1_4 scene]];
}

@end