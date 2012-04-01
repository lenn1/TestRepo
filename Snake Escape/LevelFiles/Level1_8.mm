//
//  Level1_6.m
//  Snake Escape
//
//  Created by Lennart Hansen on 19.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level1_8.h"
#import "Level1_9.h"


@implementation Level1_8
+(CCScene*)scene
{
    return [[Level1_8 alloc]initWithBackGroundImageFile:@"Level1_8.png" AndLevelWidth:960];
    
}
+(NSArray *)getNeededHighScores
{
    NSNumber* oneStar = [NSNumber numberWithInt:5000];
    NSNumber* twoStars = [NSNumber numberWithInt:10000];
    NSNumber* threeStars = [NSNumber numberWithInt:23000];
    return [NSArray arrayWithObjects:oneStar,twoStars,threeStars, nil];
    
}
-(void)LevelSetup
{
    levelPack = 1;    
    self.levelTimeout = 30;
    
    CCSprite* erklaerung = [CCSprite spriteWithFile:@"VerschiebenErklaerung.png"];
    erklaerung.position = ccp(levelWidth/2, deviceHeight/2);
    [backgroundLayer addChild:erklaerung];

    
    [schlangeLayer setSchlangePosition:ccp(125, 230)];
    
    AstNormal* ast1 = [[AstNormal alloc]init];
    ast1.position = ccp(125,150);
    
    AstNormal* ast2 = [[AstNormal alloc]init];
    ast2.position = ccp(230,125);
    
    VerkohlterAst* ast3 = [[VerkohlterAst alloc]init];
    ast3.position = ccp(445,110);
    
    AstNormal* ast4 = [[AstNormal alloc]init];
    ast4.position = ccp(715,80);
    
    VerkohlterAst* ast5 = [[VerkohlterAst alloc]init];
    ast5.position = ccp(700,225);
    
    StachelAst* ast6 = [[StachelAst alloc]init];
    ast6.position = ccp(445,200);
    
    PortalExit* ast7 = [[PortalExit alloc]init];
    ast7.position = ccp(880,186);
    
    [astLayer addAeste:ast1,ast2,ast3,ast4,ast5,ast6,ast7,nil];
    
}

-(void)nextLevel
{
    [[CCDirector sharedDirector]replaceScene:[Level1_9 scene]];
}

@end
