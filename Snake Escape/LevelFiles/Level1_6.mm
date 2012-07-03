//
//  Level1_66.m
//  Snake Escape
//
//  Created by Lennart Hansen on 20.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level1_6.h"
#import "Level1_7.h"

@implementation Level1_6
+(CCScene*)scene
{
    return [[Level1_6 alloc]initWithBackGroundImageFile:@"Level1_6.png" AndLevelWidth:480];
    
}
+(NSArray *)getNeededHighScores
{
    NSNumber* oneStar = [NSNumber numberWithInt:3000];
    NSNumber* twoStars = [NSNumber numberWithInt:8000];
    NSNumber* threeStars = [NSNumber numberWithInt:14000];
    return [NSArray arrayWithObjects:oneStar,twoStars,threeStars, nil];
    
}
-(void)LevelSetup
{
    levelPack = 1;
    
    self.levelTimeout = 20;
    
    [schlangeLayer setSchlangePosition:ccp(300, 230)];

    AstNormal* ast1 = [[AstNormal alloc]init];
    ast1.position = ccp(300,100);

    AstNormal* ast2 = [[AstNormal alloc]init];
    ast2.position = ccp(220,150);
    
   // StachelAst* ast3 = [[StachelAst alloc]init];
    //ast3.position = ccp(130,230);
    
    Rutschiger_Ast* ast3 = [[Rutschiger_Ast alloc]init];
    ast3.position = ccp(130,230);
    
    Baumharz* harz1 = [[Baumharz alloc]initWithWorld:world];
    [self addChild:harz1];
    harz1.position = ccp(220.0,300.0);
    [self addToFrameUpdate:harz1,nil];
    
    AstHindernis* ast4 = [[AstHindernis alloc]initWithWorld:world];
    ast4.position = ccp(140,40);
    ast4.rotation = 120;
    
    PortalExit* portalExit = [[PortalExit alloc]init];
    portalExit.position = ccp(50,50);

    [astLayer addAeste:ast1,ast2,ast3,ast4,portalExit,nil];
    
}

-(void)nextLevel
{
    [[CCDirector sharedDirector]replaceScene:[Level1_7 scene]];
}

@end
