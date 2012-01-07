//
//  MainMenu.m
//
//  Created by curi0u5 on 18.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"
#import "LevelSelection.h"
#import "Credits.h"
#import "SimpleAudioEngine.h"
#import "Options.h"
#import "UsefulStuff.h"
@implementation MainMenu
+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
	MainMenu *layer = [MainMenu node];
    [scene addChild: layer];
	
    return scene;
}
-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];

    if(![[SimpleAudioEngine sharedEngine]isBackgroundMusicPlaying])
    {
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"soundtrack.mp3" loop:YES];
    }
    
}
-(void)onExit
{
    [super onExit];

}
-(void) playGame
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[LevelSelection scene]]];
}
-(void) optionGame
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[Options scene]]];
}
-(void) credits
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[Credits scene]]];
}

-(id) init
{
    if((self = [super init]))
    { 
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite* bg = [CCSprite spriteWithFile:@"menue_hintergrund.png"];
        bg.position = ccp(size.width/2,size.height/2);
        [self addChild:bg];
        
        
        CCMenuItemImage* play = [CCMenuItemImage itemFromNormalImage:@"ButtonPlay.png" selectedImage:@"ButtonPlaySelected.png" target:self selector:@selector(playGame)];
        play.position = ccp(0, 70);
        
     
        CCMenuItemImage* options = [CCMenuItemImage itemFromNormalImage:@"ButtonOptions.png" selectedImage:@"ButtonOptionsSelected.png" target:self selector:@selector(optionGame)];
        options.position = ccp(0, 0);
        
        CCMenuItemImage* credits = [CCMenuItemImage itemFromNormalImage:@"ButtonCredits.png" selectedImage:@"ButtonCreditsSelected.png" target:self selector:@selector(credits)];
        credits.position = ccp(0, -70);
        
        
        CCMenu* menu = [CCMenu menuWithItems:play,options,credits, nil];
        [self addChild:menu];
    }
    return self;
    
}

@end
