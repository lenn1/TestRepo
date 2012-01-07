//
//  Options.m
//  Snake Escape
//
//  Created by Lennart Hansen on 20.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// 

#import "Options.h"
#import "SimpleAudioEngine.h"
#import "MainMenu.h"
#define SoundMenuItemTag 1234
@implementation Options
+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
	Options *layer = [Options node];
    [scene addChild: layer];
	
    return scene;
}

-(void)goToMainMenu
{    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[MainMenu scene]]];
}
-(void)toggleSound
{
    if([[SimpleAudioEngine sharedEngine]enabled])
    {        
        [[SimpleAudioEngine sharedEngine]setEnabled:NO];
        [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:0] forKey:@"SoundEnabled"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self drawMenu];

    }
    else
    {
        [[SimpleAudioEngine sharedEngine]setEnabled:YES];
        [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:1] forKey:@"SoundEnabled"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"soundtrack.mp3" loop:YES];
        [self drawMenu];

    
    }
    
}

-(void)resetGame
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[MainMenu scene]]];
    
}
-(void)drawMenu
{
    if(menu)
    {
        [self removeChild:menu cleanup:YES];
    }
    
    if([[SimpleAudioEngine sharedEngine]enabled])
    {
        menuItem1 = [CCMenuItemImage itemFromNormalImage:@"ButtonEnableSound.png" selectedImage:@"ButtonEnableSoundSelected.png" target:self selector:@selector(toggleSound)];
    }
    else
    {
        menuItem1 = [CCMenuItemImage itemFromNormalImage:@"ButtonDisableSound.png" selectedImage:@"ButtonDisableSoundSelected.png" target:self selector:@selector(toggleSound)];
        
    }
    menuItem1.tag = SoundMenuItemTag;
    
    CCMenuItem* menuItem2 = [CCMenuItemImage itemFromNormalImage:@"ButtonReset.png" selectedImage:@"ButtonResetSelected.png" target:self selector:@selector(resetGame)];
    CCMenuItem* menuItem3 = [CCMenuItemImage itemFromNormalImage:@"ButtonMainMenu.png" selectedImage:@"ButtonMainMenuSelected.png" target:self selector:@selector(resetGame)];
    
    menu = [CCMenu menuWithItems:menuItem1,menuItem2,menuItem3, nil];
    [menu alignItemsVerticallyWithPadding:5];
    
    [self addChild:menu];
}
- (id)init {
    self = [super init];
    if (self)
    {
        CCDirector* director = [CCDirector sharedDirector];
        CGSize size = [director winSize];
        
        CCSprite* bg = [CCSprite spriteWithFile:@"bg.png"];
        bg.position = ccp(size.width/2,size.height/2);
        [self addChild:bg];
        
    

     
        [self drawMenu];
        
    }
    return self;
}

@end
