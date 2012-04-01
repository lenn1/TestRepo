//
//  Level1_10.m
//  Snake Escape
//
//  Created by Lennart Hansen on 22.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level1_11.h"
#import "Level1_12.h"

@implementation Level1_11
+(CCScene*)scene
{
    return [[Level1_11 alloc]initWithBackGroundImageFile:@"Level1_11.png" AndLevelWidth:480];
}
+(NSArray *)getNeededHighScores
{
    NSNumber* oneStar = [NSNumber numberWithInt:5000];
    NSNumber* twoStars = [NSNumber numberWithInt:10000];
    NSNumber* threeStars = [NSNumber numberWithInt:18000];
    return [NSArray arrayWithObjects:oneStar,twoStars,threeStars, nil];
    
}
-(void)LevelSetup
{
    levelPack = 1;

    self.levelTimeout = 25;
    
    [schlangeLayer setSchlangePosition:ccp(80, 230)];

    AstNormal* ast1 = [[AstNormal alloc]init];
    ast1.position = ccp(80,150);

    AstHindernis* ast2 = [[AstHindernis alloc]initWithWorld:world];
    ast2.rotation = 0;
    ast2.position = ccp(260, -100);

    VerkohlterAst *ast3 = [[VerkohlterAst alloc]init];
    ast3.position = ccp(300,200);
    
    AstSchalter* ast4 = [[AstSchalter alloc]initWithTarget:ast2 AndRotation:-110 AndPosition:ccp(0,250)];
    ast4.position = ccp(400,240);
    ast4.astAktiv = NO;
    
    AstHindernis* ast5 = [[AstHindernis alloc]initWithWorld:world];
    ast5.position = ccp(490, 200);
                        
    PortalExit* portalExit = [[PortalExit alloc]init];
    portalExit.position = ccp(430,90);

    
    AstSchalter* ast6 = [[AstSchalter alloc]initWithTarget:ast5 AndRotation:-20 AndPosition:ccp(0,60)];
    ast6.position = ccp(180,100);
    ast6.astAktiv = NO;
    
    [astLayer addAeste:ast1,ast2,ast3,ast4,ast5,ast6,portalExit,nil];

}

-(void)nextLevel
{
    [[CCDirector sharedDirector]replaceScene:[Level1_12 scene]];
}

@end
