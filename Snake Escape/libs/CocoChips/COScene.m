//
//  CocoScene.m
//  CocoChips Template
//
//  Created by Torben on 02.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "COScene.h"


@implementation COScene

- (id)init {
	if ((self = [super init])) {
		if ([self respondsToSelector:@selector(sceneWillRender:)])
			[self schedule:@selector(sceneWillRender:)];
	}
	
	return self;
}

@end
