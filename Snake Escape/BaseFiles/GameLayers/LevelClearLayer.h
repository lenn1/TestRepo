//
//  LevelClearLayer.h
//  Snake Escape
//
//  Created by Lennart Hansen on 27.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BaseLevel.h"
#import "LevelClearLayerDelegate.h"
#import "UsefulStuff.h"
@interface LevelClearLayer : CCLayer  <CCTargetedTouchDelegate>
{
    CCMenu* menu;
    id <LevelClearLayerDelegate>delegate;
    
    int currentScore;

}

@property (assign)id<LevelClearLayerDelegate>delegate;
-(void)restartButton;
-(void)nextLevel;
-(void)menuButton;
-(void)Stars;
-(id)initWithHighScore:(int)score;
@end
