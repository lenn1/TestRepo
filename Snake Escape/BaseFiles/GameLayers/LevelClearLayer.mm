//
//  LevelClearLayer.m
//  Snake Escape
//
//  Created by Lennart Hansen on 27.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelClearLayer.h"
#import "LevelSelection.h"


@implementation LevelClearLayer
@synthesize delegate;
-(id)initWithHighScore:(int)score;
{
    self = [super init];
    if (self) 
    {
        currentScore = score;
        CCSprite* backGround = [CCSprite spriteWithFile:@"levelClearbg.png"];
        CGSize winSize = [[CCDirector sharedDirector]winSize];
        backGround.position = ccp(winSize.width/2,winSize.height/2);
        [self addChild:backGround];
        
        
        CCMenuItemImage* restart = [CCMenuItemImage itemFromNormalImage:@"button_restart.png" selectedImage:@"button_restart_selected.png" target:self selector:@selector(restartButton)];
        restart.position = ccp(0, -85);
        
        
        CCMenuItemImage* levelMenu = [CCMenuItemImage itemFromNormalImage:@"button_menu.png" selectedImage:@"button_menu_selected.png" target:self selector:@selector(menuButton)];
        levelMenu.position = ccp(-125, -85);
        
        CCMenuItemImage* resume = [CCMenuItemImage itemFromNormalImage:@"LevelClearNext.png" selectedImage:@"LevelClearNextSelected.png" target:self selector:@selector(nextLevel)];
        resume.position = ccp(125, -85);
        
        self.scale = 0.01;
        
        menu = [CCMenu menuWithItems:restart,resume,levelMenu, nil];
        [self addChild:menu];
        
        CCLabelTTF* scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",score] fontName:@"eartmb" fontSize:45];
        scoreLabel.position = ccp(240, 145);
        CCRenderTexture* stroke = [UsefulStuff createStrokeTTF:scoreLabel  size:3  color:ccBLACK];
        [self addChild:stroke];
        [self addChild:scoreLabel];

    }
    return self;
}

-(void)Stars
{
    int neededHighScore1 = [[[NSClassFromString([self.delegate LevelName]) getNeededHighScores]objectAtIndex:0] intValue];
    int neededHighScore2 = [[[NSClassFromString([self.delegate LevelName]) getNeededHighScores]objectAtIndex:1] intValue];
    int neededHighScore3 = [[[NSClassFromString([self.delegate LevelName]) getNeededHighScores]objectAtIndex:2] intValue];
    CCSprite* star;
    CCSprite* title;
    if(currentScore >= neededHighScore1 && currentScore < neededHighScore2)
    {
        star = [CCSprite spriteWithFile:@"LevelClear1Stars.png"];
        title = [CCSprite spriteWithFile:@"TitleGood.png"];

    }
    else if(currentScore >= neededHighScore2 && currentScore < neededHighScore3)
    {
        star = [CCSprite spriteWithFile:@"LevelClear2Stars.png"];
        title = [CCSprite spriteWithFile:@"TitleGreat.png"];
    }
    else if(currentScore >= neededHighScore3)
    {
        star = [CCSprite spriteWithFile:@"LevelClear3Stars.png"];
        title = [CCSprite spriteWithFile:@"TitleExcellent.png"];

    }
    else
    {
        star = [CCSprite spriteWithFile:@"LevelClear0Stars.png"];
        title = [CCSprite spriteWithFile:@"TitlePoor.png"];

    }
    [self addChild:star];
    star.position = ccp(240,180);
    [self addChild:title];
    title.position = ccp(240, 240);
}

-(void)onExit
{
    [self.delegate removeChild:self cleanup:YES];
    [[CCTouchDispatcher sharedDispatcher]removeDelegate:self];
    [super onExit];
}

-(void)onEnter
{
    [super onEnter];
    [[CCTouchDispatcher sharedDispatcher]addTargetedDelegate:self priority:0 swallowsTouches:YES];
    // TOUCHDISPATCHER als Hack, um zu vermeiden, dass Interaktion mit dem Hintergrund geschehen!
    
    CCFiniteTimeAction* scale1 = [CCScaleTo actionWithDuration:0.15 scale:1.2];
    CCFiniteTimeAction* scale2 = [CCScaleTo actionWithDuration:0.1 scale:1];
    [self runAction:[CCSequence actions:scale1,scale2, nil]];
    [self Stars];
    
}
-(void)restartButton
{
    [self.delegate restartLevel];
}
-(void)nextLevel
{
    [self.delegate nextLevel];

}
-(void)menuButton
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[LevelSelection scene]]];
}
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}
@end
