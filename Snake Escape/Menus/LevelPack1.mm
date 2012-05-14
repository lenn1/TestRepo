//
//  LevelSelection.m
//  Snake Escape
//
//  Created by Lennart Hansen on 19.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "BaseLevel.h"
#import "LevelPack1.h"
#import "Level1_1.h"
#import "Level1_2.h"
#import "Level1_3.h"
#import "Level1_4.h"
#import "Level1_5.h"
#import "Level1_6.h"
#import "Level1_7.h"
#import "Level1_8.h"
#import "Level1_9.h"
#import "Level1_10.h"
#import "Level1_11.h"
#import "Level1_12.h"

@implementation LevelPack1
+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
	LevelPack1 *layer = [LevelPack1 node];
    [scene addChild: layer];
    return scene;
}
- (id)init {
    self = [super init];
    if (self) 
    {
        levelWithStars = [NSMutableArray array];
        CCMenuItemImage* temp = [CCMenuItemImage itemFromNormalImage:@"IconLevel.png" selectedImage:@"IconSelectedLevel.png" target:self selector:@selector(runLevel1_1)];
        [levelWithStars addObject:temp];
        CCMenu* menu = [CCMenu menuWithItems:temp, nil];
        menu.position = ccpAdd(ccp(0,40),menu.position);
        [self addChild:menu];


        for(int i=2;i<=21;i++)
        {
            if([[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"Level1_%d",i-1]]intValue] != 0 && i<=12)
            {
                CCMenuItemImage* temp = [CCMenuItemImage itemFromNormalImage:@"IconLevel.png" selectedImage:@"IconSelectedLevel.png" target:self selector:NSSelectorFromString([NSString stringWithFormat:@"runLevel1_%d",i])];
                
                [menu addChild:temp];
                [levelWithStars addObject:temp];
            }
            else
            {
                CCMenuItemImage* temp = [CCMenuItemImage itemFromNormalImage:@"IconLevel_lock.png" selectedImage:@"IconLevel_lock.png"];
                [menu addChild:temp];
            }
        }
        
        [menu alignItemsInColumns:[NSNumber numberWithInt:7],[NSNumber numberWithInt:7],[NSNumber numberWithInt:7], nil];
        
        for(int i=0;i<[levelWithStars count];i++)
        {
            CCMenuItemImage* temp = (CCMenuItemImage*)[levelWithStars objectAtIndex:i];
            
            int neededHighScore1 = [[[NSClassFromString([NSString stringWithFormat:@"Level1_%d",i+1]) getNeededHighScores]objectAtIndex:0] intValue];
            int neededHighScore2 = [[[NSClassFromString([NSString stringWithFormat:@"Level1_%d",i+1]) getNeededHighScores]objectAtIndex:1] intValue];
            int neededHighScore3 = [[[NSClassFromString([NSString stringWithFormat:@"Level1_%d",i+1]) getNeededHighScores]objectAtIndex:2] intValue];
            int highscore = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"Level1_%d",i+1]]intValue];
            if(highscore >= neededHighScore1 && highscore < neededHighScore2)
            {
                CCSprite* star = [CCSprite spriteWithFile:@"star1.png"];
                [self addChild:star];
                star.position = ccpAdd(temp.position, ccp(240,200));
            }
            else if(highscore >= neededHighScore2 && highscore < neededHighScore3)
            {
                CCSprite* star = [CCSprite spriteWithFile:@"star2.png"];
                [self addChild:star];
                star.position = ccpAdd(temp.position, ccp(240,200));
                
            }
            else if(highscore >= neededHighScore3)
            {
                CCSprite* star = [CCSprite spriteWithFile:@"star3.png"];
                [self addChild:star];
                star.position = ccpAdd(temp.position, ccp(240,200));
            }
            else
            {
                CCSprite* star = [CCSprite spriteWithFile:@"star0.png"];
                [self addChild:star];
                star.position = ccpAdd(temp.position, ccp(240,200));
            }

            CCLabelTTF *levelNo2 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",i+1] fontName:@"UniversLTStd-Bold.otf" fontSize:36];
            levelNo2.position = ccpAdd(temp.position, ccp(240,200));
            levelNo2.color = ccc3(0, 0, 0);
            [self addChild:levelNo2];
            
            CCLabelTTF *levelNo = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",i+1] fontName:@"UniversLTStd-Bold.otf" fontSize:32];
            levelNo.position = ccpAdd(temp.position, ccp(240,200));
            levelNo.color =ccc3(252, 252, 252);
            [self addChild:levelNo];
 
        }
        
        
        
        
    }
    return self;
}

  
-(void)runLevel1_1 {[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[Level1_1 scene]]];}
-(void)runLevel1_2 {[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[Level1_2 scene]]];}
-(void)runLevel1_3 {[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[Level1_3 scene]]];}
-(void)runLevel1_4 {[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[Level1_4 scene]]];}
-(void)runLevel1_5 {[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[Level1_5 scene]]];}
-(void)runLevel1_6 {[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[Level1_6 scene]]];}
-(void)runLevel1_7 {[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[Level1_7 scene]]];}
-(void)runLevel1_8 {[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[Level1_8 scene]]];}
-(void)runLevel1_9 {[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[Level1_9 scene]]];}
-(void)runLevel1_10{[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[Level1_10 scene]]];}
-(void)runLevel1_11{[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[Level1_11 scene]]];}
-(void)runLevel1_12{[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[Level1_12 scene]]];}
-(void)runLevel1_13{};
-(void)runLevel1_14{};
-(void)runLevel1_15{};
-(void)runLevel1_16{};
-(void)runLevel1_17{};
-(void)runLevel1_18{};
-(void)runLevel1_19{};
-(void)runLevel1_20{};
-(void)runLevel1_21{};
@end
