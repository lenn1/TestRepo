//
//  PauseLayerDelegate.h
//  Snake Escape
//
//  Created by Lennart Hansen on 23.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PauseLayerDelegate <NSObject>

@optional
-(void)restartLevel;
-(void)resumeGame;
-(void)removeChild:(CCNode*)child cleanup:(BOOL)cleanup;
@end
