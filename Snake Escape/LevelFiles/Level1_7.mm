// 
//  Level1_7.m
//  Snake Escape
//
//  Created by Pix-Factory.
//  Copyright 2011 Pix-Factory. All rights reserved.
//

#import "Level1_7.h"
#import "Credits.h"
#import "Level1_8.h"

@implementation Level1_7
+(CCScene*)scene
{
	return [[Level1_7 alloc]initWithBackGroundImageFile:@"busch9.png" AndLevelWidth:480];
}
+(NSArray *)getNeededHighScores
{
	NSNumber* oneStar = [NSNumber numberWithInt:4000];
	NSNumber* twoStar = [NSNumber numberWithInt:9000];
	NSNumber* threeStar = [NSNumber numberWithInt:12000];
	return [NSArray arrayWithObjects:oneStar,twoStar,threeStar, nil];
}
-(void)LevelSetup
{
	levelPack = 1;
	self.levelTimeout = 15;
	[schlangeLayer setSchlangePosition:ccp(121.179688, 212.441406)];
    
	PortalExit* ast1 = [[PortalExit alloc]init];
	ast1.position = ccp(418.988281, 147.589844);
	ast1.rotation = 0.000000;
    
	AstNormal* ast2 = [[AstNormal alloc]init];
	ast2.position = ccp(113.511719, 133.148438);
	ast2.rotation = 0.000000;
    
	CCSprite* baum0 = [CCSprite spriteWithSpriteFrameName:@"baum2"];
	baum0.position = ccp(67.296875, 158.132812);
	baum0.scale = 1.440000;
	baum0.rotation = 0.000000;
	[backgroundLayer addChild:baum0];
    
	AstKatapult* ast3 = [[AstKatapult alloc]init];
	ast3.position = ccp(257.296875, 135.375000);
	ast3.rotation = 0.000000;
    
	CCSprite* baum1 = [CCSprite spriteWithSpriteFrameName:@"baum1"];
	baum1.position = ccp(263.394531, 152.777344);
	baum1.scale = 1.000000;
	baum1.rotation = 0.000000;
	[backgroundLayer addChild:baum1];
    
	CCSprite* baum2 = [CCSprite spriteWithSpriteFrameName:@"baum3"];
	baum2.position = ccp(406.394531, 192.242188);
	baum2.scale = 1.310000;
	baum2.rotation = 0.000000;
	[backgroundLayer addChild:baum2];
    
	CCSprite* baumkrone3 = [CCSprite spriteWithSpriteFrameName:@"baumkrone_1"];
	baumkrone3.position = ccp(474.453125, 298.242188);
	baumkrone3.scale = 1.000000;
	baumkrone3.rotation = 0.000000;
	[backgroundLayer addChild:baumkrone3];
    
	AstHindernis* ast4 = [[AstHindernis alloc]initWithWorld:world];
	ast4.position = ccp(290.683594, 143.933594);
	ast4.rotation = 178.000000;
    
    
	[astLayer addAeste:ast1,ast2,ast3,ast4,nil];
    
}
-(void)nextLevel
{
	[[CCDirector sharedDirector]replaceScene:[Level1_8 scene]];
}
@end