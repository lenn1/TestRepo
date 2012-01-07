//
//  CPTest.m
//  Contraints
//
//  Created by Torben on 07.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CPConstraint.h"


@implementation CPConstraint

+ (id) constraint {
	return [[[self alloc] init] autorelease];
}

- (id) init {
	if ((self = [super init])) {
		data = nil;
		cpconstraint = NULL;
	}
	
	return self;
}

- (void) dealloc {
	NSLog(@"CPConstraint.dealloc"); // DEBUG
	
	[data release];
	if (cpconstraint)
		cpConstraintFree(cpconstraint);
	
	[super dealloc];
}

- (CPBody*) bodyA {
	return (CPBody*)(cpconstraint->a->data);
}
- (CPBody*) bodyB {
	return (CPBody*)(cpconstraint->b->data);
}

- (cpFloat) maxForce {
	return cpconstraint->maxForce;
}

- (cpFloat) biasCoef {
	return cpconstraint->biasCoef;
}

- (cpFloat) maxBias {
	return cpconstraint->maxBias;
}

- (cpFloat) impulse {
	return cpConstraintGetImpulse(cpconstraint);
}

@synthesize data;
@synthesize space;

@synthesize cpconstraint;

@end
