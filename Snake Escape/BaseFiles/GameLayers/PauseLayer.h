//
//  PauseLayer.h
//  Snake Escape
//
//  Created by Lennart Hansen on 05.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseLevel.h"
#import "cocos2d.h"
#import "PauseLayerDelegate.h"
@class BaseLevel;

@interface PauseLayer : CCLayer <CCTargetedTouchDelegate>
{
    CCMenu* menu;
    id<PauseLayerDelegate> delegate;
}
-(void)resumeButton;
-(void)restartButton;
-(void)MenuButton;
-(void)pauseMenuCleanup;
@property(assign) id<PauseLayerDelegate> delegate;
@property (assign)NSString* levelName;

@end
