//
//  CPPinJoint.m
//  Contraints
//
//  Created by Torben on 07.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "../CPBody.h"

#import "CPPinJoint.h"


@implementation CPPinJoint

+ (id) pinJointWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ andAnchors:(cpVect)anchor1_ :(cpVect)anchor2_ {
	return [[[self alloc] initWithBodies:bodyA_ :bodyB_ andAnchors:anchor1_ :anchor2_] autorelease];
}

- (id) initWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ andAnchors:(cpVect)anchor1_ :(cpVect)anchor2_ {
	if ((self = [self init])) {
		cpconstraint = cpPinJointNew(bodyA_.cpbody, bodyB_.cpbody, anchor1_, anchor2_);
		cpconstraint->data = self;
	}
	
	return self;
}

- (cpVect) anchor1 {
	return cpPinJointGetAnchr1(cpconstraint);
}

- (cpVect) anchor2 {
	return cpPinJointGetAnchr2(cpconstraint);
}

- (cpFloat) distance {
	return cpPinJointGetDist(cpconstraint);
}

@end
