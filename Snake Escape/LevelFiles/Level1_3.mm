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
    NSNumber* oneStar = [NSNumber numberWithInt:8000];
    NSNumber* twoStars = [NSNumber numberWithInt:13000];
    NSNumber* threeStars = [NSNumber numberWithInt:23000];
    return [NSArray arrayWithObjects:oneStar,twoStars,threeStars, nil];
    
}
-(void)LevelSetup
{
    levelPack = 1;
        
    
    self.levelTimeout = 30;
    
    [schlangeLayer setSchlangePosition:ccp(90, 230)];
    
    AstNormal* ast1 = [[AstNormal alloc]init];
    ast1.position = ccp(90,170);
    
    AstNormal* ast2 = [[AstNormal alloc]init];
    ast2.position = ccp(230,210);
    
    AstNormal* ast4 = [[AstNormal alloc]init];
    ast4.position = ccp(330,230);
    
    AstNormal* ast3 = [[AstNormal alloc]init];
    ast3.position = ccp(235,80);
    
    PortalExit* portalExit = [[PortalExit alloc]init];
    portalExit.position = ccp(415,135);
    
    [astLayer addAeste:ast1,ast2,ast3,ast4,portalExit,nil];
       
    
    Affe* affe1 = [[Affe alloc]initWithWorld:world AndDelegate:self];
    [self addChild:affe1];
    [affe1 setPosition:ccpAdd(ast3.position, ccp(20, 100))];
    [self addToFrameUpdate:affe1,nil];

}
-(void)nextLevel
{
    [[CCDirector sharedDirector]replaceScene:[Level1_4 scene]];
}

@end