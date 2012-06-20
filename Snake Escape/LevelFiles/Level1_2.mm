// 
//  Level1_2.m
//  Snake Escape
//
//  Created by Pix-Factory.
//  Copyright 2011 Pix-Factory. All rights reserved.
//

#import "Level1_2.h"
#import "Credits.h"
#import "Level1_3.h"

@implementation Level1_2
+(CCScene*)scene
{
	return [[Level1_2 alloc]initWithBackGroundImageFile:@"busch2.png" AndLevelWidth:480];
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
	self.levelTimeout = 20;
	[schlangeLayer setSchlangePosition:ccp(92.617188, 222.304688)];

	PortalExit* ast1 = [[PortalExit alloc]init];
	ast1.position = ccp(431.019531, 166.207031);
	ast1.rotation = 0.000000;

	AstNormal* ast2 = [[AstNormal alloc]init];
	ast2.position = ccp(90.019531, 126.125000);
	ast2.rotation = 0.000000;

	AstNormal* ast3 = [[AstNormal alloc]init];
	ast3.position = ccp(215.433594, 183.910156);
	ast3.rotation = 0.000000;

	AstNormal* ast4 = [[AstNormal alloc]init];
	ast4.position = ccp(314.960938, 113.718750);
	ast4.rotation = 0.000000;

	CCSprite* baum0 = [CCSprite spriteWithSpriteFrameName:@"baum2"];
	baum0.position = ccp(60.160156, 225.562500);
	baum0.scale = 1.000000;
	baum0.rotation = 0.000000;
	[backgroundLayer addChild:baum0];

	CCSprite* baum1 = [CCSprite spriteWithSpriteFrameName:@"baum1"];
	baum1.position = ccp(227.351562, 205.363281);
	baum1.scale = 1.000000;
	baum1.rotation = 0.000000;
	[backgroundLayer addChild:baum1];

	CCSprite* baum2 = [CCSprite spriteWithSpriteFrameName:@"baum4"];
	baum2.position = ccp(334.183594, 196.355469);
	baum2.scale = 1.000000;
	baum2.rotation = 0.000000;
	[backgroundLayer addChild:baum2];

	CCSprite* baum3 = [CCSprite spriteWithSpriteFrameName:@"baum3"];
	baum3.position = ccp(416.796875, 211.628906);
	baum3.scale = 1.280000;
	baum3.rotation = 0.000000;
	[backgroundLayer addChild:baum3];

	CCSprite* baumkrone4 = [CCSprite spriteWithSpriteFrameName:@"baumkrone_2"];
	baumkrone4.position = ccp(488.285156, 298.675781);
	baumkrone4.scale = 1.000000;
	baumkrone4.rotation = 0.000000;
	[backgroundLayer addChild:baumkrone4];

	CCSprite* baumkrone5 = [CCSprite spriteWithSpriteFrameName:@"baumkrone_16"];
	baumkrone5.position = ccp(527.011719, 260.179688);
	baumkrone5.scale = 1.000000;
	baumkrone5.rotation = 0.000000;
	[backgroundLayer addChild:baumkrone5];

	[astLayer addAeste:ast1,ast2,ast3,ast4,nil];

}
-(void)nextLevel
{
	[[CCDirector sharedDirector]replaceScene:[Level1_3 scene]];
}
@end