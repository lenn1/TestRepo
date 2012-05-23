//
//  Level1_1.m
//  Snake Escape
//
//  Created by Lennart Hansen on 19.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level1_1.h"
#import "Level1_2.h"
#import "Stein.h"
@implementation Level1_1
+(CCScene*)scene
{
    return [[Level1_1 alloc]initWithBackGroundImageFile:@"Level1_1.png" AndLevelWidth:480];
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
    /* VOGEL DEBUG */
    
    Vogel *vogel = [[Vogel alloc]init];
    [self addChild:vogel];
    vogel.position = ccp(100,300);
    vogel.maxLeft = 40;
    vogel.maxRight = 450;
    vogel.abwurfPosition = 190;
    vogel.speed = 150;
    [self addToFrameUpdate:vogel,nil];
    vogel.delegate = self;
    
    /* VOGEL DEBUG */
         


    [schlangeLayer setSchlangePosition:ccp(120, 230)];

    levelPack = 1;

    
    CCSprite* erklaerung = [CCSprite spriteWithFile:@"Level1-Erklaerung.png"];
    erklaerung.position = ccp(deviceWidth/2, deviceHeight/2-30);
    [backgroundLayer addChild:erklaerung];
    
    self.levelTimeout = 15;
    
    Spinne* spinne = [[Spinne alloc]initWithWorld:world];
    [spinne setAnkerPosition:ccp(170.0, 480.0)];
    spinne.joint->SetLimits(-300/PTM_RATIO, -100.0/PTM_RATIO);
    
    [self addToFrameUpdate:spinne,nil];
    [self addChild:spinne];
    
    AstNormal* ast1 = [[AstNormal alloc]init];
    ast1.position = ccp(120,150);
    
    AstNormal* ast2 = [[AstNormal alloc]init];
    ast2.position = ccp(260,150);
    
    PortalExit* portalExit = [[PortalExit alloc]init];
    portalExit.position = ccp(365,120);
    
    [astLayer addAeste:ast1,ast2,portalExit,nil];
    

    
    Affe* affe1 = [[Affe alloc]initWithWorld:world];
    [self addChild:affe1];
    [affe1 setAnkerPosition:ast2.position];

    
}
-(void)nextLevel
{
    [[CCDirector sharedDirector]replaceScene:[Level1_2 scene]];
}
@end
