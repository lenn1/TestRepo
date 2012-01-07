//
//  LevelSelection.m
//  Snake Escape
//
//  Created by Lennart Hansen on 19.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelPack2.h"
#import "Level1_1.h"
#define spacing 60
#define startLevel 22
#define endLevel 42

@implementation LevelPack2
+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
	LevelPack2 *layer = [LevelPack2 node];
    [scene addChild: layer];
    return scene;
}
- (id)init {
    self = [super init];
    if (self) 
    {
        CCMenu* menu = [CCMenu menuWithItems: nil];
        menu.position = ccpAdd(ccp(0,40),menu.position);
        [self addChild:menu];
        
        levelWithStars  = [NSMutableArray array];

        CCMenuItemImage* temp;
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"Level1_21"]intValue] != 0)
        {
            temp = [CCMenuItemImage itemFromNormalImage:@"IconLevel2_1.png" selectedImage:@"IconSelectedLevel2_1.png" target:self selector:@selector(runLevel2_1)];
            [levelWithStars addObject:temp];
            [menu addChild:temp];

        }
        else
        {
            temp = [CCMenuItemImage itemFromNormalImage:@"IconLevel_lock.png" selectedImage:@"IconLevel_lock.png"];
            [menu addChild:temp];
        }
        
        
        for(int i=2;i<=21;i++)
        {
            if([[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"Level2_%d",i-1]]intValue] != 0)
            {
                CCMenuItemImage* temp = [CCMenuItemImage itemFromNormalImage:[NSString stringWithFormat:@"IconLevel2_%d.png",i] selectedImage:[NSString stringWithFormat:@"IconSelectedLevel2_%d.png",i] target:self selector:NSSelectorFromString([NSString stringWithFormat:@"runLevel2_%d",i])];
                
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
            
            int neededHighScore1 = [[[NSClassFromString([NSString stringWithFormat:@"Level2_%d",i+1]) getNeededHighScores]objectAtIndex:0] intValue];
            int neededHighScore2 = [[[NSClassFromString([NSString stringWithFormat:@"Level2_%d",i+1]) getNeededHighScores]objectAtIndex:1] intValue];
            int neededHighScore3 = [[[NSClassFromString([NSString stringWithFormat:@"Level2_%d",i+1]) getNeededHighScores]objectAtIndex:2] intValue];
            int highscore = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"Level2_%d",i+1]]intValue];
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
            
            
        }
    
        
        // <ENTFERNEN WENN LEVELS ERSTELLT WERDEN> 
        
        //CGSize size = [[CCDirector sharedDirector] winSize];

        // CCLabelBMFont* comingSoon = [CCLabelBMFont labelWithString:@"Coming Soon !" fntFile:@"menue.fnt"];
        
        //comingSoon.position = ccp(size.width/2,size.height/2+40);
        //comingSoon.scale = 1.5;
        //comingSoon.rotation = 25;
       // [self addChild:comingSoon];
        
        // </ENTFERNEN WENN LEVELS ERSTELLT WERDEN>

        
        
        
        
    }
    return self;
}
-(void)setLevelSelectionPage
{
    [[NSUserDefaults standardUserDefaults]setValue:[NSNumber numberWithInt:2] forKey:@"LevelSelectionPage"];
}
-(void)runLevel2_1{};
-(void)runLevel2_2{};
-(void)runLevel2_3{};
-(void)runLevel2_4{};
-(void)runLevel2_5{};
-(void)runLevel2_6{};
-(void)runLevel2_7{};
-(void)runLevel2_8{};
-(void)runLevel2_9{};
-(void)runLevel2_10{};
-(void)runLevel2_11{};
-(void)runLevel2_12{};
-(void)runLevel2_13{};
-(void)runLevel2_14{};
-(void)runLevel2_15{};
-(void)runLevel2_16{};
-(void)runLevel2_17{};
-(void)runLevel2_18{};
-(void)runLevel2_19{};
-(void)runLevel2_20{};
-(void)runLevel2_21{};
@end