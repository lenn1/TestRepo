//
//  Level1_9.m
//  Snake Escape
//
//  Created by Lennart Hansen on 21.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level1_10.h"
#import "Level1_11.h"

@implementation Level1_10
+(CCScene*)scene
{
    return [[Level1_10 alloc]initWithBackGroundImageFile:@"Level1_10.png" AndLevelWidth:960];
    
}
+(NSArray *)getNeededHighScores
{
    NSNumber* oneStar = [NSNumber numberWithInt:5000];
    NSNumber* twoStars = [NSNumber numberWithInt:10000];
    NSNumber* threeStars = [NSNumber numberWithInt:21000];
    return [NSArray arrayWithObjects:oneStar,twoStars,threeStars, nil];
    
}
-(void)LevelSetup
{
    levelPack = 1;
    [self schedule:@selector(ast5AktivCheck)];
    
    self.levelTimeout = 30;
    
    [schlangeLayer setSchlangePosition:ccp(80, 230)];

    VerkohlterAst* ast1 = [[VerkohlterAst alloc]init];
    ast1.position = ccp(80,150);

    AstNormal* ast2 = [[AstNormal alloc]init];
    ast2.position = ccp(230,180);
    
    VerkohlterAst* ast3 = [[VerkohlterAst alloc]init];
    ast3.position = ccp(350,130);
    
    AstHindernis* ast4 = [[AstHindernis alloc]init];
    ast4.position = ccp(400,320);
    ast4.rotation = -10;
    
    
    ast5 = [[StachelAst alloc]init];
    ast5.position = ccp(480,230);
    
    AstNormal* ast6 = [[AstNormal alloc]init];
    ast6.position = ccp(680,220);
    
    AstNormal* ast7 = [[AstNormal alloc]init];
    ast7.position = ccp(880,220);
    
    AstHindernis* ast8 = [[AstHindernis alloc]init];
    ast8.position = ccp(920,182);
    ast8.rotation = 5;
    
    AstSchalter* ast9 = [[AstSchalter alloc]initWithTarget:ast8 AndRotation:-20 AndPosition:ccp(0,150)];
    ast9.position = ccp(700,120);
    


    
    PortalExit* portalExit = [[PortalExit alloc]init];
    portalExit.position = ccp(880,80);

    [astLayer addAeste:ast1,ast2,ast3,ast4,ast5,ast6,ast7,ast8,ast9,portalExit,nil];
    
}
-(void)ast5AktivCheck
{
    if(ast5.astAktiv)
    {
        [self unschedule:@selector(ast5AktivCheck)];     
        [self runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(-330,0)]];
    }
}

-(void)nextLevel
{
    [[CCDirector sharedDirector]replaceScene:[Level1_11 scene]];
}

@end
