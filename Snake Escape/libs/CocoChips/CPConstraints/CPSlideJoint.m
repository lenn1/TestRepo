//
//  CPPinJoint.m
//  Contraints
//
//  Created by Torben on 07.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "../CPBody.h"

#import "CPSlideJoint.h"


@implementation CPSlideJoint

+ (id) slideJointWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ andAnchors:(cpVect)anchor1_ :(cpVect)anchor2_ min:(cpFloat)min_ max:(cpFloat)max_ {
	return [[[self alloc] initWithBodies:bodyA_ :bodyB_ andAnchors:anchor1_ :anchor2_ min:min_ max:max_] autorelease];
}

- (id) initWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ andAnchors:(cpVect)anchor1_ :(cpVect)anchor2_ min:(cpFloat)min_ max:(cpFloat)max_ {
	if ((self = [self init])) {
		cpconstraint = cpSlideJointNew(bodyA_.cpbody, bodyB_.cpbody, anchor1_, anchor2_, min_, max_);
		cpconstraint->data = self;
	}
	
	return self;
}

- (cpVect) anchor1 {
	return cpSlideJointGetAnchr1(cpconstraint);
}

- (cpVect) anchor2 {
	return cpSlideJointGetAnchr2(cpconstraint);
}

- (cpFloat) min {
	return cpSlideJointGetMin(cpconstraint);
}

- (cpFloat) max {
	return cpSlideJointGetMax(cpconstraint);
}


@end
