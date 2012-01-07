//
//  PauseLayer.m
//  Snake Escape
//
//  Created by Lennart Hansen on 05.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PauseLayer.h"
#import "LevelSelection.h"
#import "UsefulStuff.h"
@implementation PauseLayer
@synthesize delegate,levelName = _levelName;
- (id)init 
{
    self = [super init];
    if (self) 
    {
        int fontsize;
        if([[CCDirector sharedDirector]winSizeInPixels].width > 480)
        {
            fontsize = 35;
        }
        else
        {
            fontsize = 40;
        }
        
        CCSprite* backGround = [CCSprite spriteWithFile:@"menu_pause.png"];
        CGSize winSize = [[CCDirector sharedDirector]winSize];
        backGround.position = ccp(winSize.width/2,winSize.height/2);
        [self addChild:backGround];
        
        CCMenuItemImage* levelMenu = [CCMenuItemImage itemFromNormalImage:@"button_menu.png" selectedImage:@"button_menu_selected.png" target:self selector:@selector(MenuButton)];
        levelMenu.position = ccp(-125, -85);
        
        CCMenuItemImage* restart = [CCMenuItemImage itemFromNormalImage:@"button_restart.png" selectedImage:@"button_restart_selected.png" target:self selector:@selector(restartButton)];
        restart.position = ccp(0, -85);
        
        CCMenuItemImage* resume = [CCMenuItemImage itemFromNormalImage:@"button_resume.png" selectedImage:@"button_resume_selected.png" target:self selector:@selector(resumeButton)];
        resume.position = ccp(125, -85);
        
        
        CCLabelTTF* levelName = [CCLabelTTF labelWithString:[_levelName substringFromIndex:7] fontName:@"eartmb.ttf" fontSize:fontsize];
        levelName.position = ccp(230,183);
        CCRenderTexture* levelNameStroke = [UsefulStuff createStrokeTTF:levelName size:3 color:ccBLACK];
        [self addChild:levelNameStroke];
        [self addChild:levelName];
        
        
        NSString* highscoreString = [[NSUserDefaults standardUserDefaults]objectForKey:_levelName];
        int highscore = [highscoreString intValue];
        CCLabelTTF* highscoreLabel;
        if(highscore != 0)
        {
            highscoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",highscore] fontName:@"eartmb.ttf" fontSize:fontsize];
            highscoreLabel.position = ccp(255,143);

        }
        else
        {
            highscoreLabel = [CCLabelTTF labelWithString:@"No Score" fontName:@"eartmb.ttf" fontSize:fontsize];
            highscoreLabel.position = ccp(265,143);
        }
        CCRenderTexture* highScoreLabelStroke = [UsefulStuff createStrokeTTF:highscoreLabel size:3 color:ccBLACK];
        [self addChild:highScoreLabelStroke];
        [self addChild:highscoreLabel];
        
        self.scale = 0.01;
        
        menu = [CCMenu menuWithItems:restart,levelMenu,resume, nil];
        [self addChild:menu];
                
    }
    return self;
}
-(void)onEnter
{
    [super onEnter];
    [[CCTouchDispatcher sharedDispatcher]addTargetedDelegate:self priority:0 swallowsTouches:YES];
    // TOUCHDISPATCHER als Hack, um zu vermeiden, dass Interaktion mit dem Hintergrund geschehen!
    
    CCFiniteTimeAction* scale1 = [CCScaleTo actionWithDuration:0.15 scale:1.2];
    CCFiniteTimeAction* scale2 = [CCScaleTo actionWithDuration:0.1 scale:1];
    [self runAction:[CCSequence actions:scale1,scale2, nil]];

    
}
-(void)onExit
{
    [[CCTouchDispatcher sharedDispatcher]removeDelegate:self];
    // TOUCHDISPATCHER als Hack, um zu vermeiden, dass Interaktion mit dem Hintergrund geschehen!
    [self removeAllChildrenWithCleanup:YES];
    [super onExit];
}
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}
-(void)resumeButton
{
    CCFiniteTimeAction* scale1 = [CCScaleTo actionWithDuration:0.15 scale:1.2];
    CCFiniteTimeAction* scale2 = [CCScaleTo actionWithDuration:0.1 scale:0.01];
    CCCallFunc* pauseMenuCleanup = [CCCallFunc actionWithTarget:self selector:@selector(pauseMenuCleanup)];
    [self runAction:[CCSequence actions:scale1,scale2,pauseMenuCleanup, nil]];
}
-(void)pauseMenuCleanup
{
    [self.delegate removeChild:self cleanup:YES];
    [self.delegate resumeGame];
}

-(void)restartButton
{
    [self.delegate restartLevel];
}
-(void)MenuButton
{
    [self.delegate removeChild:self cleanup:YES];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[LevelSelection scene]]];
}
@end
