//
//  LevelClearLayerDelegate.h
//  Snake Escape
//
//  Created by Lennart Hansen on 27.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LevelClearLayerDelegate <NSObject>
@required
-(void)nextLevel;
-(void)restartLevel;
-(void)removeChild:(CCNode*)child cleanup:(BOOL)cleanup;
-(NSString*)LevelName;
@end
