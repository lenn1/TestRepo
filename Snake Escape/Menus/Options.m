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
        /*
        [[SimpleAudioEngine sharedEngine]setEnabled:NO];
        [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:0] forKey:@"SoundEnabled"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [menuItem1 setString:@"Enable Sound"];*/
        
    }
    else
    {
        /*
        [[SimpleAudioEngine sharedEngine]setEnabled:YES];
        [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:1] forKey:@"SoundEnabled"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"soundtrack.mp3" loop:YES];
        [menuItem1 setString:@"Disable Sound"];*/
        
    }
    
}
-(void)resetGame
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[MainMenu scene]]];
}
- (id)init {
    self = [super init];
    if (self)
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite* bg = [CCSprite spriteWithFile:@"hintergrund.png"];
        bg.position = ccp(size.width/2,size.height/2);
        [self addChild:bg];
        
    
        if([[SimpleAudioEngine sharedEngine]enabled])
        {
            menuItem1 = [CCMenuItemFont itemWithLabel:[CCLabelBMFont labelWithString:@"Disable Sound" fntFile:@"menue.fnt"] target:self selector:@selector(toggleSound)];  
        }
        else
        {
           menuItem1 = [CCMenuItemFont itemWithLabel:[CCLabelBMFont labelWithString:@"Enable Sound" fntFile:@"menue.fnt"] target:self selector:@selector(toggleSound)]; 
        }
        menuItem1.tag = SoundMenuItemTag;

            CCMenuItem* menuItem2 = [CCMenuItemFont itemWithLabel:[CCLabelBMFont labelWithString:@"Reset Game" fntFile:@"menue.fnt"] target:self selector:@selector(resetGame)]; 
            CCMenuItem* menuItem3 = [CCMenuItemFont itemWithLabel:[CCLabelBMFont labelWithString:@"Main Menu" fntFile:@"menue.fnt"] target:self selector:@selector(goToMainMenu)]; 

        menu = [CCMenu menuWithItems:menuItem1,menuItem2,menuItem3, nil];
        [menu alignItemsVerticallyWithPadding:5];
        
        [self addChild:menu];
     
        
        
    }
    return self;
}

@end
