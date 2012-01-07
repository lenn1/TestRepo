//
//  CCNodeExt.h
//  Snake Escape
//
//  Created by Lennart Hansen on 23.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCNode.h"

@interface CCNode (PauseResumeStuff)
- (void)resumeTimersForHierarchy;
- (void)pauseTimersForHierarchy;

@end
