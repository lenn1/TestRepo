//
//  CCNodeExt.m
//  Snake Escape
//
//  Created by Lennart Hansen on 23.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCNodeExt.h"


@implementation CCNode (PauseResumeStuff)

- (void)resumeTimersForHierarchy
{
	for (CCNode* child in [self children])
	{
		[child resumeTimersForHierarchy];
	}
	@try {
		[self resumeSchedulerAndActions];
	}
	@catch (NSException * e) {}
}

- (void)pauseTimersForHierarchy
{
	@try {
		[self pauseSchedulerAndActions];
	}
	@catch (NSException * e) {}
    
	for (CCNode* child in [self children])
	{
		[child pauseTimersForHierarchy];
	}
}

@end
