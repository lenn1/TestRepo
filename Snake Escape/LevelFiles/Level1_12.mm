// 
//  Level1_12.m
//  Snake Escape
//
//  Created by Pix-Factory.
//  Copyright 2011 Pix-Factory. All rights reserved.
//

#import "Level1_12.h"
#import "Credits.h"

@implementation Level1_12
+(CCScene*)scene
{
	return [[Level1_12 alloc]initWithBackGroundImageFile:@"Level1_12.png" AndLevelWidth:960];
}
+(NSArray *)getNeededHighScores
{
	NSNumber* oneStar = [NSNumber numberWithInt:5000];
	NSNumber* twoStar = [NSNumber numberWithInt:20000];
	NSNumber* threeStar = [NSNumber numberWithInt:29000];
	return [NSArray arrayWithObjects:oneStar,twoStar,threeStar, nil];
}
-(void)LevelSetup
{
	levelPack = 1;
	self.levelTimeout = 40;
	[schlangeLayer setSchlangePosition:ccp(100.000000, 300)];

	PortalExit* ast1 = [[PortalExit alloc]init];
	ast1.position = ccp(102.710938, 55.539062);
	ast1.rotation = 0.000000;

	VerkohlterAst* ast2 = [[VerkohlterAst alloc]init];
	ast2.position = ccp(752.585938, 60.421875);
	ast2.rotation = 0.000000;

	VerkohlterAst* ast3 = [[VerkohlterAst alloc]init];
	ast3.position = ccp(364.433594, 63.589844);
	ast3.rotation = 0.000000;

	VerkohlterAst* ast4 = [[VerkohlterAst alloc]init];
	ast4.position = ccp(224.058594, 64.078125);
	ast4.rotation = 0.000000;

	VerkohlterAst* ast5 = [[VerkohlterAst alloc]init];
	ast5.position = ccp(573.847656, 60.648438);
	ast5.rotation = 0.000000;

	AstNormal* ast6 = [[AstNormal alloc]init];
	ast6.position = ccp(785.695312, 233.445312);
	ast6.rotation = 0.000000;

	ast7 = [[AstNormal alloc]init];
	ast7.position = ccp(496.675781, 241.960938);
	ast7.rotation = 0.000000;

	AstNormal* ast8 = [[AstNormal alloc]init];
	ast8.position = ccp(338.058594, 253.070312);
	ast8.rotation = 0.000000;

	AstNormal* ast9 = [[AstNormal alloc]init];
	ast9.position = ccp(213.699219, 260.558594);
	ast9.rotation = 0.000000;

	AstNormal* ast10 = [[AstNormal alloc]init];
	ast10.position = ccp(100.835938, 201.710938);
	ast10.rotation = 0.000000;

	AstHindernis* ast11 = [[AstHindernis alloc]initWithWorld:world];
	ast11.position = ccp(429.984375, 265.0);
	ast11.rotation = 0.000000;

	VerkohlterAst* ast12 = [[VerkohlterAst alloc]init];
	ast12.position = ccp(668.824219, 245.613281);
	ast12.rotation = 0.000000;   
    
	[astLayer addAeste:ast1,ast2,ast3,ast4,ast5,ast6,ast7,ast8,ast9,ast10,ast11,ast12,nil];
    [self schedule:@selector(astvisitedCheck) interval:0.1];

}
-(void)astvisitedCheck
{
    if(ast7.astAktiv)
    {
        [self unschedule:@selector(astvisitedCheck)];
        [self runAction:[CCMoveTo actionWithDuration:0.6 position:ccp(-400,0)]];
    }
}
-(void)nextLevel
{
	[[CCDirector sharedDirector]replaceScene:[Credits scene]];
}
@end