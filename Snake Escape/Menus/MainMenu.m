
//  MainMenu.m
//
//  Created by curi0u5 on 18.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.


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
        
        CCSprite* bg = [CCSprite spriteWithFile:@"hintergrund_main.png"];
        bg.position = ccp(size.width/2,size.height/2);
        [self addChild:bg];
        
        
        CCMenuItemImage* play = [CCMenuItemImage itemFromNormalImage:@"spielen.png" selectedImage:@"spielen_active.png" target:self selector:@selector(playGame)];
        play.position = ccp(160, 20);
             
        CCMenuItemImage* options = [CCMenuItemImage itemFromNormalImage:@"optionen.png" selectedImage:@"optionen_active.png" target:self selector:@selector(optionGame)];
        options.position = ccp(160, -50);
        
        CCMenuItemImage* credits = [CCMenuItemImage itemFromNormalImage:@"credits.png" selectedImage:@"credits_active.png" target:self selector:@selector(credits)];
        credits.position = ccp(160, -120);
        
        CCMenuItemImage* gamecenter = [CCMenuItemImage itemFromNormalImage:@"gamecenter.png" selectedImage:@"gamecenter_active.png" target:self selector:@selector(self)];
        gamecenter.scale = 1.4;
        gamecenter.position = ccp(-170, -80);
        
        CCMenuItemImage* facebook = [CCMenuItemImage itemFromNormalImage:@"facebook.png" selectedImage:@"facebook_active.png" target:self selector:@selector(self)];
        facebook.scale = 1.4;
        facebook.position = ccp(-110, -80);
               
        CCMenuItemImage* twitter = [CCMenuItemImage itemFromNormalImage:@"twitter.png" selectedImage:@"twitter_active.png" target:self selector:@selector(self)];
        twitter.scale = 1.4;
        twitter.position = ccp(-50, -80);
        
        CCMenuItemImage* google = [CCMenuItemImage itemFromNormalImage:@"google.png" selectedImage:@"google_active.png" target:self selector:@selector(self)];
        google.scale = 1.4;
        google.position = ccp(10, -80);
        
        
        CCMenu* menu = [CCMenu menuWithItems:play,options,credits, gamecenter, facebook, twitter, google, nil];
        [self addChild:menu];
    }
    return self;
    
}

@end
