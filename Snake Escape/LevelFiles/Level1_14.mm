// 
//  Level1_14.m
//  Snake Escape
//
//  Created by Pix-Factory.
//  Copyright 2011 Pix-Factory. All rights reserved.
//

#import "Level1_14.h"
#import "Credits.h"

@implementation Level1_14
+(CCScene*)scene
{
	return [[Level1_14 alloc]initWithBackGroundImageFile:@"busch5.png" AndLevelWidth:480];
}
+(NSArray *)getNeededHighScores
{
	NSNumber* oneStar = [NSNumber numberWithInt:5000];
	NSNumber* twoStar = [NSNumber numberWithInt:10000];
	NSNumber* threeStar = [NSNumber numberWithInt:15000];
	return [NSArray arrayWithObjects:oneStar,twoStar,threeStar, nil];
}
-(void)LevelSetup
{
	levelPack = 1;
	self.levelTimeout = 20;
	[schlangeLayer setSchlangePosition:ccp(110.585938, 142.625000)];
    
	PortalExit* ast1 = [[PortalExit alloc]init];
	ast1.position = ccp(411.609375, 30.667969);
	ast1.rotation = 0.000000;
    
	Spinne* spinne0 = [[Spinne alloc]initWithWorld:world];
	[spinne0 setAnkerPosition:ccp(220.394531, 320.0)];
	spinne0.joint->SetLimits(-270.0/PTM_RATIO, -200.0/PTM_RATIO);
	[self addToFrameUpdate:spinne0,nil];
	[self addChild:spinne0];
    
	AstNormal* ast2 = [[AstNormal alloc]init];
	ast2.position = ccp(96.363281, 63.363281);
	ast2.rotation = 0.000000;
    
	AstHindernis* ast3 = [[AstHindernis alloc]initWithWorld:world];
	ast3.position = ccp(286.796875, 249.335938);
	ast3.rotation = 319.000000;
    
	CCSprite* baum1 = [CCSprite spriteWithSpriteFrameName:@"baum1"];
	baum1.position = ccp(125.386719, 173.949219);
	baum1.scale = 1.000000;
	baum1.rotation = 0.000000;
	[backgroundLayer addChild:baum1];
    
	Stein* stein2 = [[Stein alloc]initWithWorld:world AndStein:1];
	stein2.position = ccp(300.0, 0.0);
	stein2.scale = 1.000000;
	stein2.rotation = 0.000000;
	[self addChild:stein2];
    
	CCSprite* baum3 = [CCSprite spriteWithSpriteFrameName:@"baum2"];
	baum3.position = ccp(398.468750, 202.601562);
	baum3.scale = 1.000000;
	baum3.rotation = 0.000000;
	[backgroundLayer addChild:baum3];
    
	CCSprite* baumkrone4 = [CCSprite spriteWithSpriteFrameName:@"baumkrone_6"];
	baumkrone4.position = ccp(478.460938, 318.179688);
	baumkrone4.scale = 1.000000;
	baumkrone4.rotation = 0.000000;
	[backgroundLayer addChild:baumkrone4];
    
	[astLayer addAeste:ast1,ast2,ast3,nil];
    
}
-(void)nextLevel
{
	[[CCDirector sharedDirector]replaceScene:[Credits scene]];
}
@end