//
//  LevelSelectionNew.m
//  Snake Escape
//
//  Created by Lennart Hansen on 26.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelSelection.h"
#import "LevelPack1.h"
#import "LevelPack2.h"
#import "CCScrollLayer.h"
#import "SimpleAudioEngine.h"
#import "MainMenu.h"
@implementation LevelSelection

+(CCScene*)scene
{
    return [[LevelSelection alloc]init];
}
- (id)init {
    self = [super init];
    if (self) 
    {
        if(![[SimpleAudioEngine sharedEngine]isBackgroundMusicPlaying])
            [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"soundtrack.mp3" loop:YES];
        
        
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite* bg = [CCSprite spriteWithFile:@"hintergrund.png"];
        bg.position = ccp(size.width/2,size.height/2);
        [self addChild:bg];
        
        LevelPack1* level1 = [[LevelPack1 alloc]init];
    
        LevelPack2* level2 = [[LevelPack2 alloc]init];
        CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:[NSMutableArray arrayWithObjects: level1,level2,nil] widthOffset: 0];   
        [scroller selectPage:[[[NSUserDefaults standardUserDefaults]objectForKey:@"LevelSelectionPage"]intValue]-1];
        
        
        [self addChild:scroller];


        CCMenuItemImage* back = [CCMenuItemImage itemFromNormalImage:@"IconLevel_back.png" selectedImage:@"IconSelectedLevel_back.png" target:self selector:@selector(goToMainMenu)];
        back.position = ccp(-180, -105);
        
        CCMenu* menu = [CCMenu menuWithItems:back, nil];
        [self addChild:menu];
        
        scroller.minimumTouchLengthToChangePage = 50.0f;
    }
    return self;
}
-(void)onEnterTransitionDidFinish
{
    if(![[SimpleAudioEngine sharedEngine]isBackgroundMusicPlaying])
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"soundtrack.mp3" loop:YES];
    [super onEnterTransitionDidFinish];
    
}
-(void)goToMainMenu
{    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[MainMenu scene]]];
}
@end
