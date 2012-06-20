// 
//  Level1_1.m
//  Snake Escape
//
//  Created by Pix-Factory.
//  Copyright 2011 Pix-Factory. All rights reserved.
//

#import "Level1_1.h"
#import "Credits.h"
#import "Level1_2.h"

@implementation Level1_1
+(CCScene*)scene
{
	return [[Level1_1 alloc]initWithBackGroundImageFile:@"busch2.png" AndLevelWidth:480];
}
+(NSArray *)getNeededHighScores
{
	NSNumber* oneStar = [NSNumber numberWithInt:5000];
	NSNumber* twoStar = [NSNumber numberWithInt:10000];
	NSNumber* threeStar = [NSNumber numberWithInt:13000];
	return [NSArray arrayWithObjects:oneStar,twoStar,threeStar, nil];
}
-(void)LevelSetup
{
	levelPack = 1;
	self.levelTimeout = 15;
	[schlangeLayer setSchlangePosition:ccp(110.566406, 215.445312)];

	PortalExit* ast1 = [[PortalExit alloc]init];
	ast1.position = ccp(380.328125, 140.613281);
	ast1.rotation = 0.000000;

	AstNormal* ast2 = [[AstNormal alloc]init];
	ast2.position = ccp(123.625000, 163.167969);
	ast2.rotation = 0.000000;

	AstNormal* ast3 = [[AstNormal alloc]init];
	ast3.position = ccp(230.328125, 183.835938);
	ast3.rotation = 0.000000;

	CCSprite* baum0 = [CCSprite spriteWithSpriteFrameName:@"baum1"];
	baum0.position = ccp(157.816406, 173.664062);
	baum0.scale = 1.420000;
	baum0.rotation = 0.000000;
	[backgroundLayer addChild:baum0];

	CCSprite* baum1 = [CCSprite spriteWithSpriteFrameName:@"baum2"];
	baum1.position = ccp(351.003906, 163.804688);
	baum1.scale = 1.000000;
	baum1.rotation = 0.000000;
	[backgroundLayer addChild:baum1];

	CCSprite* baumkrone2 = [CCSprite spriteWithSpriteFrameName:@"baumkrone_1"];
	baumkrone2.position = ccp(484.128906, 285.148438);
	baumkrone2.scale = 1.000000;
	baumkrone2.rotation = 0.000000;
	[backgroundLayer addChild:baumkrone2];

	[astLayer addAeste:ast1,ast2,ast3,nil];

}
-(void)nextLevel
{
	[[CCDirector sharedDirector]replaceScene:[Level1_2 scene]];
}
@end