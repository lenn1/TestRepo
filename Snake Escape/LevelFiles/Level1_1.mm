//
//  Level1_1.m
//  Snake Escape
//
//  Created by Lennart Hansen on 19.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level1_1.h"
#import "Level1_2.h"
#import "Vogel.h"


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
    [self addToFrameUpdate:vogel,nil];
    
    /* VOGEL DEBUG */
    
    [schlangeLayer setSchlangePosition:ccp(120, 230)];

    levelPack = 1;

    
    CCSprite* erklaerung = [CCSprite spriteWithFile:@"Level1-Erklaerung.png"];
    erklaerung.position = ccp(deviceWidth/2, deviceHeight/2-30);
    [backgroundLayer addChild:erklaerung];
    
    self.levelTimeout = 15;
    
    
    AstNormal* ast1 = [[AstNormal alloc]init];
    ast1.position = ccp(120,150);
    
    AstNormal* ast2 = [[AstNormal alloc]init];
    ast2.position = ccp(260,150);
    
    PortalExit* portalExit = [[PortalExit alloc]init];
    portalExit.position = ccp(365,120);
    
    [astLayer addAeste:ast1,ast2,portalExit,nil];

}
-(void)nextLevel
{
    [[CCDirector sharedDirector]replaceScene:[Level1_2 scene]];
}
@end
