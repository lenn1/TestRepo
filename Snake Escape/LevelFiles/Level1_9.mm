// 
//  Level1_9.m
//  Snake Escape
//
//  Created by Pix-Factory.
//  Copyright 2011 Pix-Factory. All rights reserved.
//

#import "Level1_9.h"
#import "Level1_10.h"

@implementation Level1_9
+(CCScene*)scene
{
	return [[Level1_9 alloc]initWithBackGroundImageFile:@"Level1_9.png" AndLevelWidth:480];
}
+(NSArray *)getNeededHighScores
{
	NSNumber* oneStar = [NSNumber numberWithInt:7000];
	NSNumber* twoStar = [NSNumber numberWithInt:12000];
	NSNumber* threeStar = [NSNumber numberWithInt:17000];
	return [NSArray arrayWithObjects:oneStar,twoStar,threeStar, nil];
}
-(void)LevelSetup
{
	levelPack = 1;
	self.levelTimeout = 25;
	[schlangeLayer setSchlangePosition:ccp(101.816406, 217.875000)];

	PortalExit* ast1 = [[PortalExit alloc]init];
	ast1.position = ccp(450.644531, 287.492188);
	ast1.rotation = 0.000000;

	AstNormal* ast2 = [[AstNormal alloc]init];
	ast2.position = ccp(103.894531, 107.140625);
	ast2.rotation = 0.000000;

	StachelAst* ast3 = [[StachelAst alloc]init];
	ast3.position = ccp(330.429688, 224.015625);
	ast3.rotation = 0.000000;

	VerkohlterAst* ast4 = [[VerkohlterAst alloc]init];
	ast4.position = ccp(221.808594, 169.011719);
	ast4.rotation = 0.000000;

	AstHindernis* ast5 = [[AstHindernis alloc]initWithWorld:world];
	ast5.position = ccp(306.222656, 373.371094);
	ast5.rotation = 341.000000;

	AstNormal* ast6 = [[AstNormal alloc]init];
	ast6.position = ccp(244.343750, 89.097656);
	ast6.rotation = 0.000000;

	AstHindernis* ast7 = [[AstHindernis alloc]initWithWorld:world];
	ast7.position = ccp(374.894531, 194.648438);
	ast7.rotation = 17.000000;

	AstNormal* ast8 = [[AstNormal alloc]init];
	ast8.position = ccp(386.234375, 58.628906);
	ast8.rotation = 0.000000;

	[astLayer addAeste:ast1,ast2,ast3,ast4,ast5,ast6,ast7,ast8,nil];

}
-(void)nextLevel
{
	[[CCDirector sharedDirector]replaceScene:[Level1_10 scene]];
}
@end