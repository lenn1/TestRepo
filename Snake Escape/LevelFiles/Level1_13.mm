// 
//  Level1_13.m
//  Snake Escape
//
//  Created by Pix-Factory.
//  Copyright 2011 Pix-Factory. All rights reserved.
//

#import "Level1_13.h"
#import "Level1_14.h"

@implementation Level1_13
+(CCScene*)scene
{
	return [[Level1_13 alloc]initWithBackGroundImageFile:@"busch5.png" AndLevelWidth:960];
}
+(NSArray *)getNeededHighScores
{
	NSNumber* oneStar = [NSNumber numberWithInt:5000];
	NSNumber* twoStar = [NSNumber numberWithInt:10000];
	NSNumber* threeStar = [NSNumber numberWithInt:18000];
	return [NSArray arrayWithObjects:oneStar,twoStar,threeStar, nil];
}
-(void)LevelSetup
{
	levelPack = 1;
	self.levelTimeout = 30;
	[schlangeLayer setSchlangePosition:ccp(114.558594, 192.828125)];
    
	PortalExit* ast1 = [[PortalExit alloc]init];
	ast1.position = ccp(717.785156, 78.769531);
	ast1.rotation = 0.000000;
    
	Vogel* vogel0 = [[Vogel alloc]init];
	vogel0.position = ccp(380.109375,279.183594);
	vogel0.maxLeft = 100;
	vogel0.maxRight = 700;
	vogel0.speed = 150;
	vogel0.abwurfPosition = 630;
	vogel0.delegate = self;
	[self addToFrameUpdate:vogel0,nil];
	[self addChild:vogel0];
    
	VerkohlterAst* ast2 = [[VerkohlterAst alloc]init];
	ast2.position = ccp(248.886719, 175.222656);
	ast2.rotation = 0.000000;
    
	AstNormal* ast3 = [[AstNormal alloc]init];
	ast3.position = ccp(693.664062, 157.796875);
	ast3.rotation = 0.000000;
    
	CCSprite* baum1 = [CCSprite spriteWithSpriteFrameName:@"baum1"];
	baum1.position = ccp(735.792969, 118.894531);
	baum1.scale = 1.130000;
	baum1.rotation = 0.000000;
	[backgroundLayer addChild:baum1];
    
	CCSprite* baum2 = [CCSprite spriteWithSpriteFrameName:@"baum3"];
	baum2.position = ccp(103.332031, 244.058594);
	baum2.scale = 1.490000;
	baum2.rotation = 0.000000;
	[backgroundLayer addChild:baum2];
    
	AstNormal* ast4 = [[AstNormal alloc]init];
	ast4.position = ccp(113.472656, 102.367188);
	ast4.rotation = 0.000000;
    
	CCSprite* baum3 = [CCSprite spriteWithSpriteFrameName:@"baum4"];
	baum3.position = ccp(277.695312, 208.718750);
	baum3.scale = 1.000000;
	baum3.rotation = 0.000000;
	[backgroundLayer addChild:baum3];
    
	CCSprite* baumkrone4 = [CCSprite spriteWithSpriteFrameName:@"baumkrone_1"];
	baumkrone4.position = ccp(483.496094, 290.273438);
	baumkrone4.scale = 1.000000;
	baumkrone4.rotation = 0.000000;
	[backgroundLayer addChild:baumkrone4];
    
	CCSprite* baumkrone5 = [CCSprite spriteWithSpriteFrameName:@"baumkrone_20"];
	baumkrone5.position = ccp(711.992188, 256.199219);
	baumkrone5.scale = 1.000000;
	baumkrone5.rotation = 0.000000;
	[backgroundLayer addChild:baumkrone5];
    
	[astLayer addAeste:ast1,ast2,ast3,ast4,nil];
    
}
-(void)nextLevel
{
	[[CCDirector sharedDirector]replaceScene:[Level1_14 scene]];
}
@end