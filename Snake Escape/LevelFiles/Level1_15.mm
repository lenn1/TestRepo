// 
//  Level1_15.m
//  Snake Escape
//
//  Created by Pix-Factory.
//  Copyright 2011 Pix-Factory. All rights reserved.
//

#import "Level1_15.h"
#import "Credits.h"
#import "Credits.h"

@implementation Level1_15
+(CCScene*)scene
{
	return [[Level1_15 alloc]initWithBackGroundImageFile:@"busch12.png" AndLevelWidth:480];
}
+(NSArray *)getNeededHighScores
{
	NSNumber* oneStar = [NSNumber numberWithInt:5000];
	NSNumber* twoStar = [NSNumber numberWithInt:10000];
	NSNumber* threeStar = [NSNumber numberWithInt:17000];
	return [NSArray arrayWithObjects:oneStar,twoStar,threeStar, nil];
}
-(void)LevelSetup
{
	levelPack = 1;
	self.levelTimeout = 20;
	[schlangeLayer setSchlangePosition:ccp(109.292969, 198.234375)];
    
	PortalExit* ast1 = [[PortalExit alloc]init];
	ast1.position = ccp(245.464844, 250.953125);
	ast1.rotation = 0.000000;
    
	CCSprite* baum0 = [CCSprite spriteWithSpriteFrameName:@"baum4"];
	baum0.position = ccp(302.136719, 197.406250);
	baum0.scale = 1.650000;
	baum0.rotation = 0.000000;
	[backgroundLayer addChild:baum0];
    
	CCSprite* baum1 = [CCSprite spriteWithSpriteFrameName:@"baum3"];
	baum1.position = ccp(98.890625, 241.398438);
	baum1.scale = 1.460000;
	baum1.rotation = 0.000000;
	[backgroundLayer addChild:baum1];
    
	Feuer* feuer2 = [[Feuer alloc]initWithWorld:world];
	feuer2.position = ccp(248.687500, 170.0);
	[self addChild:feuer2];
    
	Wasserfall* wasserfall3 = [[Wasserfall alloc]initWithWorld:world];
	wasserfall3.position = ccp(357.441406, 320);
	[self addChild:wasserfall3];
    
	CCSprite* baum4 = [CCSprite spriteWithSpriteFrameName:@"baum1"];
	baum4.position = ccp(427.414062, 186.011719);
	baum4.scale = 1.000000;
	baum4.rotation = 0.000000;
	[backgroundLayer addChild:baum4];
    
	VerkohlterAst* ast2 = [[VerkohlterAst alloc]init];
	ast2.position = ccp(409.699219, 120.449219);
	ast2.rotation = 0.000000;
    
	AstNormal* ast3 = [[AstNormal alloc]init];
	ast3.position = ccp(106.945312, 85.152344);
	ast3.rotation = 0.000000;
    
	AstNormal* ast4 = [[AstNormal alloc]init];
	ast4.position = ccp(261.175781, 90.390625);
	ast4.rotation = 0.000000;
    
	CCSprite* baumkrone5 = [CCSprite spriteWithSpriteFrameName:@"baumkrone_4"];
	baumkrone5.position = ccp(481.910156, 328.472656);
	baumkrone5.scale = 1.000000;
	baumkrone5.rotation = 0.000000;
	[backgroundLayer addChild:baumkrone5];
    
	[astLayer addAeste:ast1,ast2,ast3,ast4,nil];
    
}
-(void)nextLevel
{
	[[CCDirector sharedDirector]replaceScene:[Credits scene]];
}
@end