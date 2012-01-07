//
//  CocoLayer.m
//  CocoChips Template
//
//  Created by Torben on 02.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "COLayer.h"


@implementation COLayer

- (BOOL)ccTouchBegan:(UITouch *)touch_ withEvent:(UIEvent *)event_ {
	if ([self.delegate respondsToSelector:@selector(layerDidTouchBegan:touch:event:)])
		[delegate layerDidTouchBegan:self touch:touch_ event:event_];
	return YES; // TODO: Give return value a meaning
}

- (void)ccTouchEnded:(UITouch *)touch_ withEvent:(UIEvent *)event_ {
	if ([self.delegate respondsToSelector:@selector(layerDidTouchEnded:touch:event:)])
		[delegate layerDidTouchEnded:self touch:touch_ event:event_];
}

- (void)ccTouchMoved:(UITouch *)touch_ withEvent:(UIEvent *)event_ {
	if ([self.delegate respondsToSelector:@selector(layerDidTouchMoved:touch:event:)])
		[delegate layerDidTouchMoved:self touch:touch_ event:event_];
}

- (void)ccTouchesBegan:(NSSet*)touches_ withEvent:(UIEvent*)event_ {
	if ([self.delegate respondsToSelector:@selector(layerDidTouchBegan:touch:event:)]) {
		for (UITouch *touch in touches_)
			[delegate layerDidTouchBegan:self touch:touch event:event_];
	}
}

- (void)ccTouchesEnded:(NSSet*)touches_ withEvent:(UIEvent*)event_ {
	if ([self.delegate respondsToSelector:@selector(layerDidTouchEnded:touch:event:)]) {
		for (UITouch *touch in touches_)
			[delegate layerDidTouchEnded:self touch:touch event:event_];
	}
}

- (void)ccTouchesMoved:(NSSet*)touches_ withEvent:(UIEvent*)event_ {
	if ([self.delegate respondsToSelector:@selector(layerDidTouchMoved:touch:event:)]) {
		for (UITouch *touch in touches_)
			[delegate layerDidTouchMoved:self touch:touch event:event_];
	}
}

- (void)accelerometer:(UIAccelerometer*)accelerometer_ didAccelerate:(UIAcceleration*)acceleration_ {
	if ([self.delegate respondsToSelector:@selector(layerDidAccelerate:accelerometer:acceleration:)])
		[delegate layerDidAccelerate:self accelerometer:accelerometer_ acceleration:acceleration_];
}

@synthesize delegate;

@end
